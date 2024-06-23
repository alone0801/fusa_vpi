#include "vcsuser.h"
#include "vpi_user.h"
#include "fault_injector.h"
#include <stdio.h>

void fault_injector_callback(p_cb_data cb_data);
void fault_injector(p_cb_data cb_data);
void const_inject_register( vpiHandle obj );
void InjectHandler(p_cb_data cb_data);
//void iso_test(char* port_name);

void fault_injector_register( )
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
        vpi_printf("\nThe module name is %s\n",TESTBENCH_NAME_p);
    }

    fault_p = &fault;

    vpi_printf("Fault node name is %s\n",fault_p->fault_node_name);
    //vpi_printf("Fault type is %s\n",fault_p->fault_type);
    //vpi_printf("Fault value is %d\n",fault_p->fault_value);
    vpi_printf("Injection time is %f\n",fault_p->injection_time);

    //Specifying the fault injeciton time
    //time_s.type = vpiScaledRealTime;
    time_s.type = vpiSimTime;
    //time_s.real = fault.injection_time;
    time_s.low       = fault.injection_time;
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
    cb_data_s.index = 0;
    cb_data_s.user_data = (PLI_BYTE8 *)module_handle;  //Pass fault related infomation to fault_injector()
    cb_handle = vpi_register_cb(&cb_data_s);
    vpi_free_object(cb_handle);
    /****/
    vpiHandle signal_handle = vpi_handle_by_name("test_new.test_ins.sub_inst.a",0);
    s_vpi_value value_s;
    //value_s.format = vpiLogicVal;
    value_s.format = vpiReg;
    vpi_put_value(signal_handle, &value_s, NULL, vpiNoDelay);
    //iso_test("test_new.test_ins.sub_inst.a");
    /****/
}

void fault_injector_callback(p_cb_data cb_data)
{
    s_cb_data cb_data_s;
    s_vpi_time time_s;
    vpiHandle cb_handle,module_handle;
    PLI_BYTE8 *TESTBENCH_NAME_p;

    vpi_printf("\nThis is fault_injector_callback() running\n");

    module_handle = (vpiHandle)cb_data->user_data;
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

void fault_injector(p_cb_data cb_data)
{
    vpiHandle signal_handle;
    s_vpi_value fault_value = { vpiIntVal, { 0 } };
    s_vpi_time  time_s = { vpiSimTime, 0, 0, 0.0 };
    PLI_INT32 flag;

    //Get information from fault_injector_callback()
    
    vpi_printf("\nThis is fault_injector() running\n\n");
    vpi_printf("signal_name is %s\n", fault_p->fault_node_name);
    signal_handle = vpi_handle_by_name(fault_p->fault_node_name,0);
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
            //flag = vpiNoDelay;
            //flag = vpiInertialDelay;
        else
            flag = vpiInertialDelay;
        
        fault_value.format = vpiIntVal;
        fault_value.value.integer = fault_p->fault_value;
        vpi_put_value(signal_handle, &fault_value, &time_s, flag);
        //const_inject_register(signal_handle);
        vpiHandle test_h = vpi_handle_by_name("test_new.test_ins.a",0);
        s_vpi_value test_value = { vpiIntVal, { 0 } };
        test_value.format = vpiIntVal;
        test_value.value.integer = 0;
//        vpi_put_value(test_h, &test_value , &time_s, flag);
    }
}

void const_inject_register( vpiHandle obj )
{
    static s_vpi_time  time_s  = { vpiSimTime };
    static s_vpi_value value_s = { vpiBinStrVal };

    s_cb_data cbData = { cbValueChange, InjectHandler, 0, &time_s, &value_s };
    cbData.obj = obj;
    //vpi_register_cb( &cbData );
    vpi_printf( "*********Callback set on value change*********\n");
}

void InjectHandler(p_cb_data cb_data){
    s_vpi_value fault_value = { vpiIntVal, { 0 } };
    s_vpi_time  time_s = { vpiSimTime, 0, 0, 0.0 };
    static s_vpi_time time_int = { vpiSimTime };
    vpi_get_time( 0, &time_int );
    fault_value.format = vpiIntVal;
    fault_value.value.integer = fault_p->fault_value;
    value_get(fault_p->fault_node_name);
    vpi_printf("*****DEBUG:call back to %d at time %d*****\n",fault_p->fault_value,time_int.low);
    //vpi_put_value(cb_data->obj, &fault_value, &time_s, vpiInertialDelay);
    //vpi_put_value(cb_data->obj, &fault_value, &time_s, vpiNoDelay);
    value_get(fault_p->fault_node_name);

}

