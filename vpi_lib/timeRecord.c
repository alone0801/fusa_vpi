#include "vpi_user.h"
#include <strings.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include "vpiDebug.h"
#include"fault_injector.h"

int time_record_print( p_cb_data cb_data_p )
{
    s_vpi_time time_s;
    FILE *fp;
    vpiHandle systf = vpi_handle(vpiSysTfCall, NULL);
    fp=fopen("golden.time","w");
    time_s.type=vpiScaledRealTime;
    vpi_get_time(systf,&time_s); 
    printf("The simulation finish at %2.0f\n",time_s.real);
    fprintf(fp,"%2.0f",time_s.real);
}
void timeRecordEosHandler( p_cb_data data )
{
    time_record_print( data );
}

