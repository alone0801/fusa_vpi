//#include "vcsuser.h"
#include "vpi_user.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <strings.h>
#include "StringList.h"

#define SA_FAULT 0
#define SEU_FAULT 1

static StringList *fault_target,*fault_exclude;
static int fault_tw[2];

void fault_modeling(p_cb_data cb_data);
int find_submodule(vpiHandle this_mod_h,int type,FILE *fp,int node_num);
int find_local_signals(vpiHandle module_h,int type,FILE *fp,int node_num);
int find_net_or_logic_signal(vpiHandle module_h, FILE *fp,int node_num,int is_logic);
int find_reg_signal(vpiHandle module_h,FILE *fp,int node_num);
int find_reg_array(vpiHandle module_h,FILE *fp,int node_num);
int find_wire_array(vpiHandle module_h,FILE *fp,int node_num);
int GetRandNum(int min,int max,int seed);

void fault_modeling_check(StringList* fault_target_p,StringList* fault_exclude_p,int fault_tw_[])
{
    s_cb_data cb_data_s;
    vpiHandle cb_handle,module_handle;

    vpi_printf("\nThis is fault_modeling_check() running\n");
    fault_target = fault_target_p;
    fault_exclude = fault_exclude_p;
    fault_tw[0] = fault_tw_[0];
    fault_tw[1] = fault_tw_[1];

    //Registration of fault_modeling simulation callback routine
    cb_data_s.reason = cbEndOfCompile;
    cb_data_s.cb_rtn = (void *)fault_modeling;
    cb_data_s.obj = NULL;
    cb_data_s.time = NULL;
    cb_data_s.value = NULL;
    cb_data_s.index = 0;
    cb_data_s.user_data = NULL;
    cb_handle = vpi_register_cb(&cb_data_s);
    vpi_free_object(cb_handle);
    
}

void fault_modeling(p_cb_data cb_data)
{
    vpiHandle   systf_handle,module_h;
    PLI_INT32   format;
    FILE *fp;
    int node_num = 0,type,i;

    type = SA_FAULT;                          // to be determined////////////
    //vpi_printf("This is fault_modeling() running\n");
    fp = fopen("Fault_list.xml","w");           // to be determined/////////////
    if(fp == NULL)
        printf("Error opening file!\n");
    else
    {
        /*
        if(type == SA_FAULT)
            fprintf(fp,"Fault Type : SA0/1\n");
        else if(type == SEU_FAULT)
            fprintf(fp,"Fault Type : SEU\n");
            */
        fprintf(fp,"<LOCATION> <TYPE> <TIME> <RESULT>\n");
    }

    for ( i = 0; i < fault_target->count; i++) {
        module_h = vpi_handle_by_name(fault_target->strings[i], 0);
        //vpi_printf("\nIn scope of %s\n",vpi_get_str(vpiFullName,module_h));
        find_submodule(module_h,type,fp,node_num);
    }
    fclose(fp);
    vpi_printf("fault_modeling() has finished\n");
}

int find_submodule(vpiHandle this_mod_h,int type,FILE *fp,int node_num)
{
    vpiHandle submodule_itr, submodule_h;
    int i,is_exclude;

    // Find local signals in this module
    //vpi_printf("\nmodule = %s\n",vpi_get_str(vpiFullName,this_mod_h));
    node_num = find_local_signals(this_mod_h,type,fp,node_num);

    // Find all submodule in this module,and recursively find all signals in submodules
    submodule_itr = vpi_iterate(vpiModule, this_mod_h);
    if (submodule_itr != NULL)
        while (submodule_h = vpi_scan(submodule_itr))
        {
            is_exclude = 0;
            for ( i = 0; i < fault_target->count; i++)
            {
                //vpi_printf("Exclude = %s\n",fault_exclude->strings[i]);
                if(strcmp(vpi_get_str(vpiFullName,submodule_h),fault_exclude->strings[i]) == 0)
                    is_exclude = 1;
            }
            if(is_exclude == 0)
                node_num = find_submodule(submodule_h,type,fp,node_num);
        }
    
    return node_num;
}

int find_local_signals(vpiHandle module_h,int type,FILE *fp,int node_num)
{
    int is_logic = 0;       // 0 refer to net signal, and 1 refer to logic variable
    //vpi_printf("This is find_local_signals() running\n");
    if(type == SA_FAULT)
    {
        // Find all net signal
        node_num = find_net_or_logic_signal(module_h,fp,node_num,is_logic);

        // Find all logic variables
        is_logic = 1;
        node_num = find_net_or_logic_signal(module_h,fp,node_num,is_logic);

        // Find all net array signal
        node_num = find_wire_array(module_h,fp,node_num);
    }

    // Find all reg signal
    node_num = find_reg_signal(module_h,fp,node_num);

    // Find all reg array signal
    node_num = find_reg_array(module_h,fp,node_num);

    return node_num;
}

int find_net_or_logic_signal(vpiHandle module_h, FILE *fp,int node_num,int is_logic)
{
    //vpi_printf("This is find_net_signal() running\n");
    vpiHandle signal_iterator,signal_handle,signalBit_iterator,signalBit_handle;
    vpiHandle port_iterator,port_handle,lowconn_h,use_iterator,use_handle,instance_iterator,instance_handle;
    vpiHandle port_connect_iterator,port_connect_handle;
    int is_port,is_not_port,have_been_used,variable_type;

    //vpi_printf("module_h = %s\n",vpi_get_str(vpiFullName,module_h));

    if(!is_logic)
        signal_iterator = vpi_iterate(vpiNet,module_h);
    else
        signal_iterator = vpi_iterate(vpiVariables,module_h);
    if(signal_iterator != NULL)
        while((signal_handle = vpi_scan(signal_iterator)) != NULL)
        {
            variable_type = vpi_get(vpiType,signal_handle);
            if(!is_logic || (is_logic&&(variable_type != vpiIntegerVar)&&(variable_type != vpiRealVar)&&(variable_type != vpiTimeVar)))
            {
                // Processing ports
//                port_iterator = vpi_iterate(vpiPorts,signal_handle);
                port_iterator = vpi_iterate(vpiPort,signal_handle);
                if(port_iterator != NULL)
                    while((port_handle = vpi_scan(port_iterator)) != NULL)
                    {
//                        lowconn_h = vpi_handle(vpiLowConn,port_handle);
                        have_been_used = 0;
                        is_port = 0;
                        is_not_port = 0;
                        //find module instance
                        instance_iterator = vpi_iterate(vpiModule,module_h);
//                        use_iterator = vpi_iterate(vpiPort,lowconn_h);
//                        if(use_iterator != NULL)
                        if(instance_iterator != NULL)
                        {
                            while ((instance_handle = vpi_scan(instance_iterator)) != NULL)
                            {
                                // 查找与端口连接的信号
                                port_connect_iterator = vpi_iterate(vpiPort, instance_handle);
                                if (port_connect_iterator != NULL)
                                {
                                    while ((port_connect_handle = vpi_scan(port_connect_iterator)) != NULL)
                                    {
                                        if (port_connect_handle == port_handle)
                                        {
                                            // 如果端口与信号相连接
                                            have_been_used = 1;
                                            if (vpi_get(vpiType, port_connect_handle) == vpiPort)
                                                is_port = 1;
                                            else
                                                is_not_port = 1;
                                        }
                                    }
                                }
                            }
                        }
//                            have_been_used = 1;
//                            is_port = 0;
//                            is_not_port = 0;
//                            
//                            // Find all place where this signal is used
//                            while((use_handle = vpi_scan(use_iterator)) != NULL)
//                            {
//                                //fprintf(fp,"use_handle = %s,Type = %s\n",vpi_get_str(vpiFullName,use_handle),vpi_get_str(vpiType,use_handle));
//                                if(vpi_get(vpiType,use_handle) == vpiPort)
//                                    is_port = 1;                   // There is a port user
//                                else if(vpi_get(vpiType,use_handle) != vpiSysTaskCall)
//                                    is_not_port = 1;            // Once there is a non-port user
//                            }
//                        }
                        
                        // Ports that don't need to be optimized
                        // The condition for determining if this port is to be optimized or not is that
                        // this port is used and the user of this port is only port.
                        // Then the condition of determing if this port isn't to be optimized or not 
                        // is the opposite of previous condition
                        //fprintf(fp,"%s Type = %s\nis_port = %d,is_not_port = %d,have_been_used = %d\n",vpi_get_str(vpiFullName,lowconn_h),vpi_get_str(vpiType,lowconn_h),is_port,is_not_port,have_been_used);
                        if(!(is_port && (!is_not_port)) && have_been_used)
                        {
                            signalBit_iterator = vpi_iterate(vpiNetBit,lowconn_h);
                            if(signalBit_iterator != NULL)
                                while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                                {
                                    // It's a vector signal, get all of its bits
                                    if((GetRandNum(0,100,node_num) % 2) == 0)
                                        fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA0",GetRandNum(0,100,node_num));
                                    else
                                        fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA1",GetRandNum(0,100,node_num));
                                    node_num = node_num + 1;
                                }
                            else
                            {
                                // It's a scalar signal
                                if((GetRandNum(0,100,node_num) % 2) == 0)
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,port_handle),"SA0",GetRandNum(0,100,node_num));
                                else
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,port_handle),"SA1",GetRandNum(0,100,node_num));
                                node_num = node_num + 1;
                            }
                        }
                        //else
                            //fprintf(fp,"%s is delete\n",vpi_get_str(vpiFullName,lowconn_h));
                    }
                else
                {
                    // Processing non-port signals
                    have_been_used = 0;
                    use_iterator = vpi_iterate(vpiNet,signal_handle);
                    if(use_iterator != NULL)
                    {
                        have_been_used = 1;
                        is_port = 0;
                        is_not_port = 0;
                        while((use_handle = vpi_scan(use_iterator)) != NULL)
                        {
                            //fprintf(fp,"use_handle = %s,Type = %s\n",vpi_get_str(vpiFullName,use_handle),vpi_get_str(vpiType,use_handle));
                            if(vpi_get(vpiType,use_handle) == vpiPort)
                                is_port = 1;
                            else
                                is_not_port = 1;
                        }
                    }

                    // Signals that don't need to be optimized
                    //fprintf(fp,"%s Type = %s\nis_port = %d,is_not_port = %d,have_been_used = %d\n",vpi_get_str(vpiFullName,signal_handle),vpi_get_str(vpiType,signal_handle),is_port,is_not_port,have_been_used);
                    if(!(is_port && (!is_not_port)) && have_been_used)
                    {
                        signalBit_iterator = vpi_iterate(vpiNetBit,signal_handle);
                        if(signalBit_iterator != NULL)
                            while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                            {
                                if((GetRandNum(0,100,node_num) % 2) == 0)
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA0",GetRandNum(0,100,node_num));
                                else
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA1",GetRandNum(0,100,node_num));
                                node_num = node_num + 1;
                            }
                        else
                        {
                            if((GetRandNum(0,100,node_num) % 2) == 0)
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA0",GetRandNum(0,100,node_num));
                                else
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA1",GetRandNum(0,100,node_num));
                            node_num = node_num + 1;
                        }
                    }
                    //else
                        //fprintf(fp,"%s is delete\n",vpi_get_str(vpiFullName,signal_handle));
                }
            
            }
        }

    return node_num;
}

int find_reg_signal(vpiHandle module_h,FILE *fp,int node_num)
{
    //vpi_printf("This is find_reg_signal() running\n");
    vpiHandle signal_iterator,signal_handle,signalBit_iterator,signalBit_handle,use_iterator;

    // Find all reg signal
    //vpi_printf("module_h = %s\n",vpi_get_str(vpiFullName,module_h));
    signal_iterator = vpi_iterate(vpiReg,module_h);
    if (signal_iterator != NULL)
        while((signal_handle = vpi_scan(signal_iterator)) != NULL)
        {
            use_iterator = vpi_iterate(vpiReg,signal_handle);
            //fprintf(fp,"reg_signal_handle:use_iterator = %d\n",use_iterator);
            if(use_iterator != NULL)
            {
                // If it's been used, then it won't be optimized
                signalBit_iterator = vpi_iterate(vpiRegBit,signal_handle);
                if(signalBit_iterator != NULL)
                    // Processing vector signal
                    while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                    {
                        if((GetRandNum(0,100,node_num) % 2) == 0)
                            fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA0",GetRandNum(0,100,node_num));
                        else
                            fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA1",GetRandNum(0,100,node_num));
                        node_num = node_num + 1;
                    }
                else
                {
                    if((GetRandNum(0,100,node_num) % 2) == 0)
                        fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA0",GetRandNum(0,100,node_num));
                    else
                        fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA1",GetRandNum(0,100,node_num));
                    fprintf(fp,"%d %dns {\"%s\" }\n",node_num,GetRandNum(0,100,node_num),vpi_get_str(vpiFullName,signal_handle));
                    node_num = node_num + 1;
                }
            }
            //else
                //fprintf(fp,"%s is delete\n",vpi_get_str(vpiFullName,signal_handle));
        }
    return node_num;
}

int find_reg_array(vpiHandle module_h,FILE *fp,int node_num)
{
    //vpi_printf("This is find_reg_array() running\n");
    vpiHandle reg_array_iterator,reg_array_handle,signal_iterator,use_iterator;
    vpiHandle signal_handle,signalBit_iterator,signalBit_handle;

    reg_array_iterator = vpi_iterate(vpiRegArray,module_h);
    if(reg_array_iterator != NULL)
        while((reg_array_handle = vpi_scan(reg_array_iterator)) != NULL)
        {
            use_iterator = vpi_iterate(vpiReg,reg_array_handle);
            //fprintf(fp,"reg_array_handle:use_iterator = %d\n",use_iterator);
            if(use_iterator != NULL)
            {
                // If it's been used, then it won't be optimized
                signal_iterator = vpi_iterate(vpiReg,reg_array_handle);
                if(signal_iterator != NULL)
                    while((signal_handle = vpi_scan(signal_iterator)) != NULL)
                        {
                            signalBit_iterator = vpi_iterate(vpiRegBit,signal_handle);
                            if(signalBit_iterator != NULL)
                                while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                                    {
                                        if((GetRandNum(0,100,node_num) % 2) == 0)
                                            fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA0",GetRandNum(0,100,node_num));
                                        else
                                            fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA1",GetRandNum(0,100,node_num));
                                        node_num = node_num + 1;
                                    }
                            else
                            {
                                if((GetRandNum(0,100,node_num) % 2) == 0)
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA0",GetRandNum(0,100,node_num));
                                else
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA1",GetRandNum(0,100,node_num));
                                node_num = node_num + 1;
                            }
                        }
            }
            //else
                //fprintf(fp,"%s is delete\n",vpi_get_str(vpiFullName,reg_array_handle));
        }
    
    return node_num;
}

int find_wire_array(vpiHandle module_h,FILE *fp,int node_num)
{
    //vpi_printf("This is find_wire_array() running\n");
    vpiHandle wire_array_iterator,wire_array_handle,signal_iterator,signal_handle,use_iterator;
    vpiHandle signalBit_iterator,signalBit_handle;

    //fprintf(fp,"Wire array\n");
    wire_array_iterator = vpi_iterate(vpiNetArray,module_h);
    if(wire_array_iterator != NULL)
        while((wire_array_handle = vpi_scan(wire_array_iterator)) != NULL)
        {
            use_iterator = vpi_iterate(vpiNetArray,wire_array_handle);
            //fprintf(fp,"wire_array_handle:use_iterator = %d\n",use_iterator);
            if(use_iterator != NULL)
            {
                signal_iterator = vpi_iterate(vpiNet,wire_array_handle);
                if(signal_iterator != NULL)
                    while((signal_handle = vpi_scan(signal_iterator)) != NULL)
                    {
//                        signalBit_iterator = vpi_iterate(vpiBit,signal_handle);
                        signalBit_iterator = vpi_iterate(vpiNetBit,signal_handle);
                        if(signalBit_iterator != NULL)
                            while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                            {
                                if((GetRandNum(0,100,node_num) % 2) == 0)
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA0",GetRandNum(0,100,node_num));
                                else
                                    fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signalBit_handle),"SA1",GetRandNum(0,100,node_num));
                                node_num = node_num + 1;
                            }
                        else
                        {
                            if((GetRandNum(0,100,node_num) % 2) == 0)
                                fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA0",GetRandNum(0,100,node_num));
                            else
                                fprintf(fp,"%s  %s  %d\n",vpi_get_str(vpiFullName,signal_handle),"SA1",GetRandNum(0,100,node_num));
                            node_num = node_num + 1;
                        }
                    }
            }
            //else
                //fprintf(fp,"%s is delete\n",vpi_get_str(vpiFullName,wire_array_handle));
        }
    
    return node_num;
}

int GetRandNum(int min,int max,int seed)
{
    srand(seed);
    return min + rand() % (max - min + 1);
}

void register_fault_modeling(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$fault_modeling";
    tf_data.calltf=fault_modeling;
    tf_data.compiletf=fault_modeling_check;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}
//extern void register_fault_modeling();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_fault_modeling,
//  NULL /*** final entry must be 0 ***/
//};
