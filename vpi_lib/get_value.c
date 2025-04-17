#include "veriuser.h"
#include "vpi_user.h"
#include <strings.h>
#include <stdlib.h>
void value_get(const char* fault_location){
    vpiHandle location_handle;
    s_vpi_value value_s;
    value_s.format = vpiBinStrVal;
    location_handle = vpi_handle_by_name(fault_location,0);
    vpi_get_value(location_handle, &value_s);
    vpi_printf("DEBUG:%s value is %s\n",fault_location,value_s.value.str);
}
extern void vpit_RegisterTfs( void )
{
    s_vpi_systf_data systf_data;
    vpiHandle        systf_handle;

    systf_data.type        = vpiSysTask;
    systf_data.sysfunctype = 0;
    systf_data.tfname      = "$test";
    systf_data.calltf      = value_get;
    systf_data.compiletf   = 0;
    systf_data.sizetf      = 0;
    systf_data.user_data   = 0;
    systf_handle = vpi_register_systf( &systf_data );
    vpi_free_object( systf_handle );
}
