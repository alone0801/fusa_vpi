#include "vcsuser.h"
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
    PLI_BYTE8 *TESTBENCH_NAME_p; //To be determined////////////////////////////

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
    //vpi_printf("Fault type is %s\n",fault_p->fault_type);
    //vpi_printf("Fault value is %d\n",fault_p->fault_value);
    vpi_printf("Injection time is %d\n",fault_p->injection_time);

    //Specifying the fault injeciton time
    //time_s.type = vpiScaledRealTime;
    time_s.type = vpiSimTime;
    //time_s.real = fault.injection_time;
    time_s.low       = fault_p->injection_time;
    time_s.high      = 0;

    //Registration of fault_injector simulation callback routine
    //cb_data_s.reason = cbNBASynch;
    //cb_data_s.reason = cbReadWriteSynch;
    cb_data_s.reason =cbAtEndOfSimTime;
    //cb_data_s.reason = cbReadOnlySynch;
    //cb_data_s.cb_rtn = fault_injector_callback;
    cb_data_s.cb_rtn = fault_injector;
    cb_data_s.obj = module_handle;
    cb_data_s.time = &time_s;
    cb_data_s.value = NULL;
    cb_data_s.index = vact_num;
    //cb_data_s.user_data = (PLI_BYTE8 *)module_handle;  //Pass fault related infomation to fault_injector()
    cb_data_s.user_data = (struct Fault *)fault_p;
    cb_handle = vpi_register_cb(&cb_data_s);
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
    if(vact_num==1) con_obj=obj;
    else {
        origin_name = vpi_get_str(vpiFullName,obj);
        dut_h = vpi_handle_by_name(DUT_NAME,0);
        tb_h = vpi_handle(vpiScope,dut_h);
        //printf("=====origin_name==%s=======\n",origin_name);
        tb_name = vpi_get_str(vpiFullName,tb_h);
        //printf("=====tb_name==%d=======\n",vact_num-1);
        char *con_name = malloc(strlen(tb_name)+30* sizeof(char));
        sprintf(con_name,"%s.concur_%d",tb_name,vact_num-1); 
        size_t lenA = strlen(con_name);
        size_t lenB = strlen(DUT_NAME);  
        size_t lenC = strlen(origin_name); 
        size_t new_len = lenA + lenC - lenB;
        char* replace_name = (char*)malloc(new_len + 1);
        strcpy(replace_name, con_name);
        strcat(replace_name, origin_name + lenB);
        con_obj = vpi_handle_by_name(replace_name,0);
        //printf("+++++++DEBUG::replace_name:%s+++++++++",replace_name);
        if(con_obj==NULL) {
            printf("ERROR:concurrent tb generate fail, please check the 'DUT_NAME' and 'TB_NAME' defined in FI.xml");
            return(0);
        }
    }
    //printf("\n==========%s===========\n",vpi_get_str(vpiFullName,con_obj));
    return(con_obj);

}

void fault_injector(p_cb_data cb_data)
{
    vpiHandle signal_handle;
    s_vpi_value fault_value = { vpiIntVal, { 0 } };
    s_vpi_time  time_s = { vpiSimTime, 0, 0, 0.0 };
    PLI_INT32 flag;
    struct Fault * fault_p = (struct Fault *) cb_data->user_data ;
    //Get information from fault_injector_callback()
    signal_handle = cur_replace(vpi_handle_by_name(fault_p->fault_node_name,0),cb_data->index); 
    //vpi_printf("\nThis is fault_injector() running\n\n");
    //vpi_printf("signal_name is %s\n", fault_p->fault_node_name);
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
        
        fault_value.format = vpiIntVal;
        fault_value.value.integer = fault_p->fault_value;
        vpi_put_value(signal_handle, &fault_value, &time_s, flag);
    }
}

////////////////////////////////// Written by Wayne /////////////////////////////
