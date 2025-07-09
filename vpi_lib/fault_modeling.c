#include "vpi_user.h"
#include "veriuser.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <strings.h>
#include "StringList.h"

#define SA0 1
#define SA1 2
#define SA 3
#define SEU 4
#define SET 5
#define SE 6
#define ALL 7

static StringList *fault_target,*fault_exclude;
static int fault_tw[2];
static int fault_type;
static int set_hold_time;
void fault_modeling(p_cb_data cb_data);
int find_submodule(vpiHandle this_mod_h,FILE *fp,int node_num);
int find_local_signals(vpiHandle module_h,FILE *fp,int node_num);
int find_net_or_logic_signal(vpiHandle module_h, FILE *fp,int node_num,int is_logic);
int find_reg_signal(vpiHandle module_h,FILE *fp,int node_num);
int find_reg_array(vpiHandle module_h,FILE *fp,int node_num);
int find_wire_array(vpiHandle module_h,FILE *fp,int node_num);
int OutputFaultList(FILE *fp,vpiHandle signal_handle,int node_num);
int GetRandNum(int min,int max,int seed);

void fault_modeling_check(StringList* fault_target_p,StringList* fault_exclude_p,int fault_tw_[],int fault_type_local,int set_hold_time_local)
{
    s_cb_data cb_data_s;
    vpiHandle cb_handle,module_handle;

    //vpi_printf("\nThis is fault_modeling_check() running\n");
    fault_target = fault_target_p;
    fault_exclude = fault_exclude_p;
    fault_type = fault_type_local;
    set_hold_time = set_hold_time_local;
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
    int node_num = 0,i;

    fp = fopen("fault.set","w");           // The  output fault list file
    if(fp == NULL)
        printf("Error opening file!\n");
    else
    {
        fprintf(fp,"<LOCATION> <TYPE> <TIME> <SET_RETURN_TIME> <RESULT>\n");
    }

    for ( i = 0; i < fault_target->count; i++) {
        module_h = vpi_handle_by_name(fault_target->strings[i], 0);
        find_submodule(module_h,fp,node_num);
    }
    fclose(fp);
}

int find_submodule(vpiHandle this_mod_h,FILE *fp,int node_num)
{
    vpiHandle submodule_itr, submodule_h;
    int i,is_exclude;

    // Find local signals in this module
    node_num = find_local_signals(this_mod_h,fp,node_num);

    // Find all submodule in this module,and recursively find all signals in submodules
    submodule_itr = vpi_iterate(vpiModule, this_mod_h);
    if (submodule_itr != NULL)
        while (submodule_h = vpi_scan(submodule_itr))
        {
            is_exclude = 0;
            for ( i = 0; i < fault_target->count; i++)
            {
                if(strcmp(vpi_get_str(vpiFullName,submodule_h),fault_exclude->strings[i]) == 0)
                    is_exclude = 1;
            }
            if(is_exclude == 0)
                node_num = find_submodule(submodule_h,fp,node_num);
        }
    
    return node_num;
}

int find_local_signals(vpiHandle module_h,FILE *fp,int node_num)
{
    int is_logic = 0;       // 0 refer to net signal, and 1 refer to logic variable
    if((fault_type >= 1) && (fault_type <= 7) && (fault_type != SEU))
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
    vpiHandle port_iterator,port_handle,lowconn_h,use_iterator,use_handle;
    int is_port,is_not_port,have_been_used,variable_type;

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
                port_iterator = vpi_iterate(vpiPorts,signal_handle);
                if(port_iterator != NULL)
                    while((port_handle = vpi_scan(port_iterator)) != NULL)
                    {
                        lowconn_h = vpi_handle(vpiLowConn,port_handle);
                        have_been_used = 0;
                        use_iterator = vpi_iterate(vpiUse,lowconn_h);
                        if(use_iterator != NULL)
                        {
                            have_been_used = 1;
                            is_port = 0;
                            is_not_port = 0;
                            
                            // Find all place where this signal is used
                            while((use_handle = vpi_scan(use_iterator)) != NULL)
                            {
                                if(vpi_get(vpiType,use_handle) == vpiPort)
                                    is_port = 1;                   // There is a port user
                                else if(vpi_get(vpiType,use_handle) != vpiSysTaskCall)
                                    is_not_port = 1;            // Once there is a non-port user
                            }
                        }
                        
                        // Ports that don't need to be optimized
                        // The condition for determining if this port is to be optimized or not is that
                        // this port is used and the user of this port is only port.
                        // Then the condition of determing if this port isn't to be optimized or not 
                        // is the opposite of previous condition
                        //fprintf(fp,"%s Type = %s\nis_port = %d,is_not_port = %d,have_been_used = %d\n",vpi_get_str(vpiFullName,lowconn_h),vpi_get_str(vpiType,lowconn_h),is_port,is_not_port,have_been_used);
                        if(!(is_port && (!is_not_port)) && have_been_used)
                        {
                            signalBit_iterator = vpi_iterate(vpiBit,lowconn_h);
                            if(signalBit_iterator != NULL)
                                while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                                {
                                    // It's a vector signal, get all of its bits
                                    node_num = OutputFaultList(fp,signalBit_handle,node_num);
                                }
                            else
                            {
                                // It's a scalar signal
                                node_num = OutputFaultList(fp,lowconn_h,node_num);
                            }
                        }
                    }
                else
                {
                    // Processing non-port signals
                    have_been_used = 0;
                    use_iterator = vpi_iterate(vpiUse,signal_handle);
                    if(use_iterator != NULL)
                    {
                        have_been_used = 1;
                        is_port = 0;
                        is_not_port = 0;
                        while((use_handle = vpi_scan(use_iterator)) != NULL)
                        {
                            if(vpi_get(vpiType,use_handle) == vpiPort)
                                is_port = 1;
                            else
                                is_not_port = 1;
                        }
                    }

                    // Signals that don't need to be optimized
                    if(!(is_port && (!is_not_port)) && have_been_used)
                    {
                        signalBit_iterator = vpi_iterate(vpiBit,signal_handle);
                        if(signalBit_iterator != NULL)
                            while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                            {
                                node_num = OutputFaultList(fp,signalBit_handle,node_num);
                            }
                        else
                        {
                            node_num = OutputFaultList(fp,signal_handle,node_num);
                        }
                    }
                }
            
            }
        }

    return node_num;
}

int find_reg_signal(vpiHandle module_h,FILE *fp,int node_num)
{
    vpiHandle signal_iterator,signal_handle,signalBit_iterator,signalBit_handle,use_iterator;

    // Find all reg signal
    signal_iterator = vpi_iterate(vpiReg,module_h);
    if (signal_iterator != NULL)
        while((signal_handle = vpi_scan(signal_iterator)) != NULL)
        {
            signalBit_iterator = vpi_iterate(vpiBit,signal_handle);
            if(signalBit_iterator != NULL)
                // Processing vector signal
                while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                    node_num = OutputFaultList(fp,signalBit_handle,node_num);
            else
                node_num = OutputFaultList(fp,signal_handle,node_num);
        }
    return node_num;
}

int find_reg_array(vpiHandle module_h,FILE *fp,int node_num)
{
    vpiHandle reg_array_iterator,reg_array_handle,signal_iterator,use_iterator;
    vpiHandle signal_handle,signalBit_iterator,signalBit_handle;

    reg_array_iterator = vpi_iterate(vpiRegArray,module_h);
    if(reg_array_iterator != NULL)
        while((reg_array_handle = vpi_scan(reg_array_iterator)) != NULL)
        {
            use_iterator = vpi_iterate(vpiUse,reg_array_handle);
            if(use_iterator != NULL)
            {
                // If it's been used, then it won't be optimized
                signal_iterator = vpi_iterate(vpiReg,reg_array_handle);
                if(signal_iterator != NULL)
                    while((signal_handle = vpi_scan(signal_iterator)) != NULL)
                        {
                            signalBit_iterator = vpi_iterate(vpiBit,signal_handle);
                            if(signalBit_iterator != NULL)
                                while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                                    {
                                        node_num = OutputFaultList(fp,signalBit_handle,node_num);
                                    }
                            else
                            {
                                node_num = OutputFaultList(fp,signal_handle,node_num);
                            }
                        }
            }
        }
    
    return node_num;
}

int find_wire_array(vpiHandle module_h,FILE *fp,int node_num)
{
    vpiHandle wire_array_iterator,wire_array_handle,signal_iterator,signal_handle,use_iterator;
    vpiHandle signalBit_iterator,signalBit_handle;

    wire_array_iterator = vpi_iterate(vpiNetArray,module_h);
    if(wire_array_iterator != NULL)
        while((wire_array_handle = vpi_scan(wire_array_iterator)) != NULL)
        {
            use_iterator = vpi_iterate(vpiUse,wire_array_handle);
            //fprintf(fp,"wire_array_handle:use_iterator = %d\n",use_iterator);
            if(use_iterator != NULL)
            {
                signal_iterator = vpi_iterate(vpiNet,wire_array_handle);
                if(signal_iterator != NULL)
                    while((signal_handle = vpi_scan(signal_iterator)) != NULL)
                    {
                        signalBit_iterator = vpi_iterate(vpiBit,signal_handle);
                        if(signalBit_iterator != NULL)
                            while((signalBit_handle = vpi_scan(signalBit_iterator)) != NULL)
                            {
                                node_num = OutputFaultList(fp,signalBit_handle,node_num);
                            }
                        else
                        {
                            node_num = OutputFaultList(fp,signal_handle,node_num);
                        }
                    }
            }
        }
    
    return node_num;
}

int OutputFaultList(FILE *fp,vpiHandle signal_handle,int node_num)
{
    int random_num, random_type;

    random_num = GetRandNum(fault_tw[0],fault_tw[1],node_num);      // To be refined. It is supposed to be a floating number.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    random_type = GetRandNum(0,3,node_num);
    switch (fault_type)
    {
    case SA0:
        fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA0",random_num,0);
        break;
    case SA1:
        fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA1",random_num,0);
        break;
    case SA:
        if((random_type % 2) == 0)
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA0",random_num,0);
        else
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA1",random_num,0);
        break;
    case SEU:
        fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SEU",random_num,0);
        break;
    case SET:
        fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SET",random_num,random_num+set_hold_time);
        break;
    default:
        switch (random_type)
        {
        case 0:
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA0",random_num,0);
            break;
        case 1:
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SA1",random_num,0);
            break;
        case 2:
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SEU",random_num,0);
            break;
        default:
            fprintf(fp,"%s  %s  %d  %d  UU\n",vpi_get_str(vpiFullName,signal_handle),"SET",random_num,random_num+set_hold_time);
            break;
        }
        break;
    }
    node_num = node_num + 1;
    return node_num;
}
int GetRandNum(int min,int max,int seed)
{
    srand(seed);
    return min + rand() % (max - min + 1);
}

