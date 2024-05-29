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

    fp=fopen("golden.time","w");
    vpi_get_time(0,&time_s);
    time_s.type=vpiScaledRealTime;
    //printf("The simulation finish at %2.0f\n",time_s.real);
    fprintf(fp,"%2.0f",time_s.real);
}
void timeRecordEosHandler( p_cb_data data )
{
    time_record_print( data );
}

