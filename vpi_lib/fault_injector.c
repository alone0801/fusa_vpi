#include "veriuser.h"
#include "vpi_user.h"
#include "fault_injector.h"
#include <stdio.h>

void fault_injector_callback(p_cb_data cb_data);
void fault_injector(p_cb_data cb_data);
extern char DUT_NAME[100];
////////////////////////////////////////// Written by Wayne //////////////////////
void fault_injector_check(struct Fault *fault_p ,int vact_num)
{
    s_cb_data cb_data_s;
    s_vpi_time time_s;
    vpiHandle cb_handle,module_handle;
    struct cb_Userdata *udata_p = (struct cb_Userdata *)malloc(sizeof(struct cb_Userdata));
    PLI_BYTE8 *TESTBENCH_NAME_p; //To be determined////////////////////////////
    //vpi_printf("vact_num = %d\n", vact_num);
    module_handle = vpi_handle_by_name(TESTBENCH_NAME,0);
    if(module_handle == NULL)
    {
        vpi_printf((PLI_BYTE8*) "ERROR: set: unable to locate hdl path (%s)\n",TESTBENCH_NAME);
        vpi_printf((PLI_BYTE8*) " Either the name is incorrect, or you may not have PLI/ACC visibility to that name\n");
    }
    else
    {
        TESTBENCH_NAME_p = vpi_get_str(vpiName,module_handle);
        //vpi_printf("\nThe module name is %s\n",TESTBENCH_NAME_p);
    }

    //fault_p = &fault;

    vpi_printf("Fault node name is %s\n",fault_p->fault_node_name);
    vpi_printf("Injection time is %d\n",fault_p->injection_time);

    //Specifying the fault injeciton time
    //time_s.type = vpiScaledRealTime;
    time_s.type = vpiSimTime;
    //time_s.real = fault.injection_time;
    time_s.low       = fault_p->injection_time;
    time_s.high      = 0;

    udata_p->module_handle = module_handle;
    udata_p->vact_num = vact_num;
    udata_p->fault_p = (struct Fault *)fault_p;
    //vpi_printf("%s,%d,%s\n",vpi_get_str(vpiName,udata_p->module_handle),udata_p->vact_num,udata_p->fault_p->fault_node_name);
    //Registration of fault_injector simulation callback routine
    //cb_data_s.reason = cbNBASynch;
    //cb_data_s.reason = cbReadWriteSynch;
    cb_data_s.reason =cbAtEndOfSimTime;
    //cb_data_s.reason = cbReadOnlySynch;
    //cb_data_s.cb_rtn = fault_injector_callback;
    cb_data_s.cb_rtn = fault_injector;
    cb_data_s.obj = NULL;
    cb_data_s.time = &time_s;
    cb_data_s.value = NULL;
    cb_data_s.index = NULL;
    //cb_data_s.user_data = (PLI_BYTE8 *)module_handle;  //Pass fault related infomation to fault_injector()
    cb_data_s.user_data = (PLI_BYTE8 *)udata_p;
    cb_handle = vpi_register_cb(&cb_data_s);
    //vpi_printf("cb_data_s.index = %d\n", cb_data_s.index);
    vpi_free_object(cb_handle);
}

void fault_injector_callback(p_cb_data cb_data)
{
    s_cb_data cb_data_s;
    s_vpi_time time_s;
    vpiHandle cb_handle,module_handle;
    PLI_BYTE8 *TESTBENCH_NAME_p;
    struct Fault * fault_p = (struct Fault *) cb_data_s.user_data ;
    //vpi_printf("\nThis is fault_injector_callback() running\n");
    module_handle = vpi_handle_by_name(TESTBENCH_NAME,0);
    //module_handle = (vpiHandle)cb_data->user_data;
    if(module_handle == NULL)
    {
        vpi_printf((PLI_BYTE8*) "ERROR: set: unable to locate hdl path (%s)\n",TESTBENCH_NAME);
        vpi_printf((PLI_BYTE8*) " Either the name is incorrect, or you may not have PLI/ACC visibility to that name\n");
    }
    else
    {
        TESTBENCH_NAME_p = vpi_get_str(vpiName,module_handle);
        vpi_printf("\nThe module name is %s\n",TESTBENCH_NAME_p);
    }

    time_s.type = vpiScaledRealTime;
    time_s.real = 0.0;

    //Registration of fault_injector simulation callback routine
    cb_data_s.reason = cbNBASynch;
    cb_data_s.cb_rtn = fault_injector;
    cb_data_s.obj = module_handle;
    cb_data_s.time = &time_s;
    cb_data_s.value = NULL;
    cb_data_s.index = 0;
    cb_data_s.user_data = NULL;
    cb_handle = vpi_register_cb(&cb_data_s);
    vpi_free_object(cb_handle);
}
vpiHandle cur_replace(vpiHandle obj, int vact_num)
{
    int i;
    vpiHandle  tb_h, dut_h;
    static vpiHandle con_obj;
    char* origin_name ;
    char* tb_name ;
    char* con_name;
    //vpi_printf("vact_num = %d\n", vact_num);
    if(vact_num==0) con_obj=obj;
    else {
        origin_name = strdup(vpi_get_str(vpiFullName,obj));
        if(origin_name==NULL) {
            printf("ERROR get handle in concurrent mode , disable\n");
            return 0;
        }
        dut_h = vpi_handle_by_name(DUT_NAME,0);
        tb_h = vpi_handle(vpiScope,dut_h);
        //printf("=====origin_name==%s=======\n",origin_name);
        tb_name = strdup(vpi_get_str(vpiFullName,tb_h));
        //printf("=====tb_name==%s=======\n",tb_name);
        char *con_name = malloc(strlen(tb_name)+30* sizeof(char));
        sprintf(con_name,"%s.concur_%d",tb_name,vact_num);
        size_t lenA = strlen(con_name);
        size_t lenB = strlen(DUT_NAME);  
        size_t lenC = strlen(origin_name);
        size_t lenD = strlen(tb_name);
        //printf("%s,%zu\n%s,%zu\n%s,%zu\n%s,%zu\n",con_name, lenA, DUT_NAME, lenB, origin_name, lenC, tb_name, lenD);
        char* replace_name;
        size_t new_len;
        if(origin_name[lenB] == '.'){
            new_len = lenA + lenC - lenB;
            replace_name = (char*)malloc(new_len + 1);
            strcpy(replace_name, con_name);
            strcat(replace_name, origin_name + lenB);
            //printf("%zu\n",new_len);
        }
        else {
            new_len = lenA + lenC - lenD;
            replace_name = (char*)malloc(new_len + 1);
            strcpy(replace_name, con_name);
            strcat(replace_name, origin_name + lenD);
        }
        //printf("+++++++DEBUG::replace_name:%s+++++++++\n",replace_name);
        //printf("%zu,%c\n",new_len,replace_name[new_len-1]);
        /*
        if(replace_name[new_len-1] == ']')
        {
            
            const char* last_bracket = strrchr(replace_name, '[');
            size_t sublen = new_len - strlen(last_bracket);
            //printf("%zu\n", sublen);
            char* parent_name = (char*)malloc(sublen + 1);
            strncpy(parent_name, replace_name, sublen);
            parent_name[sublen] = '\0';
            //printf("%s\n", parent_name);
            int index = atoi(last_bracket + 1);
            //printf("+++++++DEBUG::parent_name:%s index:%d+++++++++\n", parent_name, index);
            vpiHandle parent_h = vpi_handle_by_name(parent_name,0);
            con_obj = vpi_handle_by_index(parent_h, index);
    
            printf("debug\n");
            //con_obj = vpi_handle_by_name(replace_name,0);
            
        }
        else*/
        con_obj = vpi_handle_by_name(replace_name,0);

        //printf("+++++++DEBUG::replace_name:%s+++++++++\n",replace_name);

        
        if(con_obj==NULL) {
            printf("ERROR:concurrent tb generate fail, please check the 'DUT_NAME' and 'TB_NAME' defined in FI.xml\n");
            return(0);
        }
    }
    return(con_obj);
}

void fault_injector(p_cb_data cb_data)
{
    vpiHandle signal_handle;
    s_vpi_value fault_value = { vpiIntVal, { 0 } };
    s_vpi_time  time_s = { vpiSimTime, 0, 0, 0.0 };
    PLI_INT32 flag;
    struct cb_Userdata *udata_p =(struct cb_Userdata *) cb_data->user_data;
    vpiHandle module_handle = udata_p->module_handle;
    struct Fault *fault_p = udata_p->fault_p;
    //Get information from fault_injector_callback()
    //vpi_printf("modeule name is %s\n", vpi_get_str(vpiName, module_handle));
    signal_handle = cur_replace(vpi_handle_by_name(fault_p->fault_node_name,0),udata_p->vact_num); 
    //vpi_printf("\nThis is fault_injector() running\n\n");
    //vpi_printf("modeule name is %s\n", vpi_get_str(vpiName, module_handle));
    //printf("debug\n");
    //vpi_printf("signal_name is %s\n", vpi_get_str(vpiFullName, signal_handle));
    //signal_handle = vpi_handle_by_name(fault_p->fault_node_name,0);

    //Used for obtaining a handle for an object using the name of the object. 
    //The first parameter specify name of object, the secend parameter specify the searching scope.

    if(signal_handle == 0)
    {
        vpi_printf((PLI_BYTE8*) "INJECT_ERROR: set: unable to locate hdl path (%s)\n",fault_p->fault_node_name);
        vpi_printf((PLI_BYTE8*) " Either the name is incorrect, or you may not have PLI/ACC visibility to that name\n");
    }
    else
    {
        //Determination of fault type
        if(fault_p->fault_type == SA_FAULT)
            flag = vpiForceFlag;
        else
            flag = vpiInertialDelay;
        //vpi_printf("%s\n%d\n",vpi_get_str(vpiFullName,signal_handle),vpi_get(vpiType,signal_handle));

        fault_value.format = vpiIntVal;
        fault_value.value.integer = fault_p->fault_value;
        vpi_put_value(signal_handle, &fault_value, &time_s, flag);
    }
}

////////////////////////////////// Written by Wayne /////////////////////////////
