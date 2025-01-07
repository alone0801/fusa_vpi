/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

#include "vpiDebug.h"
#include "vpi_user.h"
/*
 * Debug output flags
 */

int DbgCback;  /* debug event callback installation */
int DbgEvent;  /* debug event callback handling     */
int DbgTrace;  /* debug netlist back-trace          */
int DbgVdiff;  /* debug on-the-fly vcdiff algorithm */
int DbgOscil;  /* debug oscillation detection tool  */

/***
 ***  Move this stuff elsewhere
 ***/

/*
 *  Finally, the endresult of this project (this is kinda outdated)
 */
void analyzeCause( int level, p_trace_node this )
{
    p_trace_link link, mark; int flag = 1; 

    char* head = makeSpace( ++level ); /* must be pre-increment */

    #define HEAD makeSpace( level )

    int   t_hi = this->valu ? this->t_hi :  0;
    int   t_lo = this->valu ? this->t_lo :  0;
    char* valu = this->valu ? this->valu : "X";

    vpi_printf( "%sanalyze: %s => %s at %ld:%ld\n", HEAD, FullName( this->refn->refn ),
                                                          this->valu,
                                                          this->t_hi,
                                                          this->t_lo );

    /* walk the list of drivers (re-using pointer) */

    for ( link = this->back, mark = 0; link; link = link->next )
    {
        p_trace_node node = link->back;

        if ( nodeTimeCompare( node, this ) <= 0 )
        {
            /* find the cause with the most recent event time */

            if ( ( mark == 0 ) || ( nodeTimeCompare( mark->back, node ) <= 0 ) )
            {
                mark = link; /* 'dis be our guy */
            }

            vpi_printf( "%scompare: %s (%ld:%ld)\n", HEAD, FullName( node->refn->refn ),
                                                           node->t_hi,
                                                           node->t_lo );
        }
        else /* ignore non-causal input changes (later in time) */
        {

/* we can't ignore these until we have a way of stopping on the mis-match */

if ( ( mark == 0 ) || ( nodeTimeCompare( mark->back, node ) <= 0 ) )
{
    mark = link; /* 'dis be our guy */
}

            vpi_printf( "%scompare: %s (%ld:%ld) changed after %s\n", HEAD, FullName( node->refn->refn ),
                                                                            node->t_hi,
                                                                            node->t_lo,
                                                                            FullName( this->refn->refn ) );
        }
    }

    if ( mark )
    {
        /* follow all nodes that may have changed at the same time */

        for ( link = this->back; link; link = link->next )
        {
            p_trace_node node = link->back;

            if ( nodeTimeCompare( node, mark->back ) == 0 )
            {
                PLI_UINT32 t_hi = this->t_hi - node->t_hi;
                PLI_UINT32 t_lo = this->t_lo - node->t_lo;

                if ( flag && ( link != mark ) ) /* multiple causal events at same time */
                {
                    vpi_printf( "%sanalyze: possible RACE (see below):\n", HEAD ); flag = 0;
                }

                vpi_printf( "%sanalyze: found %s, delay %ld:%ld\n", HEAD, FullName( node->refn->refn ), t_hi, t_lo );

                if ( vpi_compare_objects( this->refn->refn, node->refn->refn ) )
                {
                    vpi_printf( "%sanalyze: looks like %s might be a CLOCK\n", HEAD, FullName( node->refn->refn ) );
                }
                else if ( node->loop )
                {
                    vpi_printf( "%sanalyze: possible FEEDBACK loop at %s\n", HEAD, FullName( node->refn->refn ) );
                }
                else /* follow all "latest" events */
                {
                    node->loop = 1; analyzeCause( level, node ); node->loop = 0;
                }
            }
        }
    }
    else
    {
        vpi_printf( "%sanalyze: no causal events found\n", HEAD );
    }
}

/***
 ***  End of stuff to move elsewhere
 ***/

/*
 *  PLI instance data for $vpiDebug
 */
typedef struct t_vpiDebug_data
{
  int  dbgCback;
  int  dbgEvent;
  int  dbgTrace;
  int  dbgVdiff;
  int  dbgOscil;

} s_vpiDebug_data, *p_vpiDebug_data;

s_vpiDebug_data vpi_debug_data; 

/*
 *  PLI check function for $vpiDebug
 */
void vpiDebugCheck( int data, int reason )
{
    int index, err = 0;
	char* str;
    p_vpiDebug_data this = ( p_vpiDebug_data )malloc( sizeof( s_vpiDebug_data ) );

    this->dbgCback = 0;
    this->dbgEvent = 0;
    this->dbgTrace = 0;
    this->dbgVdiff = 0;
    this->dbgOscil = 0;
    vpiHandle systf_h, arg_itr, arg_h; 
	s_vpi_value value_s;
	// 获取PLI系统任务的句柄 
	systf_h = vpi_handle(vpiSysTfCall, NULL); 
	// 获取参数的迭代器 
	arg_itr = vpi_iterate(vpiArgument, systf_h);
	if(arg_itr) {
      for (index = 1; arg_h = vpi_scan(arg_itr); index++) { 
	    if (vpi_get(vpiType, arg_h) == vpiStringVal) { 
		 value_s.format = vpiStringVal;
		 vpi_get_value(arg_h, &value_s); 
		 str = strdup(value_s.value.str);  
//    for ( index = 1; index <= tf_nump( ); index++ )
//    {
//        if ( tf_typep( index ) == tf_string )
//        vpiHandle obj = vpi_iterate(vpiArgument, tf_ithandle(index));
//        if(obj)
//        {
//            char* str = tf_getcstringp( index );
//            char* str = vpi_get_str(vpiName, obj);

                 if ( strcmp( str, "callback"    ) == 0 ) this->dbgCback = 1;
            else if ( strcmp( str, "event"       ) == 0 ) this->dbgEvent = 1;
            else if ( strcmp( str, "trace"       ) == 0 ) this->dbgTrace = 1;
            else if ( strcmp( str, "vcdiff"      ) == 0 ) this->dbgVdiff = 1;
            else if ( strcmp( str, "oscillation" ) == 0 ) this->dbgOscil = 1;
            else
            {
                tf_text( "vpiDebug: Unrecognized debug option <%s>\n", str ); ++err;
            }
        }
        else
        {
            tf_text( "vpiDebug: Non-string parameter at %d\n", index ); ++err;
        }
    }
	}

    if ( err )
    {
        tf_text( "vpiDebug: Usage: $vpiDebug( <option> [, ... ])\n" );
        tf_text( "vpiDebug:            callback    = enable debug for callback installation\n" );
        tf_text( "vpiDebug:            event       = enable debug for event callback triggers\n" );
        tf_text( "vpiDebug:            trace       = enable debug for back/hier tracing\n" );
        tf_text( "vpiDebug:            vcdiff      = enable debug for $vcdCompare\n" );
        tf_text( "vpiDebug:            oscillation = enable debug for $oscDetect\n" );
 
//        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }
    tf_setworkarea( ( char* )this ); /* save flags */
}

/*
 *  PLI call function for $vpiDebug
 */
//void vpiDebugCall( int data, int reason )
//{
//    p_vpiDebug_data this = ( p_vpiDebug_data )tf_getworkarea( );
//
//    DbgCback = this->dbgCback;
//    DbgEvent = this->dbgEvent;
//    DbgTrace = this->dbgTrace;
//    DbgVdiff = this->dbgVdiff;
//    DbgOscil = this->dbgOscil;
//}


void vpiDebugCall(int data, int reason) {
    DbgCback = vpi_debug_data.dbgCback;
    DbgEvent = vpi_debug_data.dbgEvent;
    DbgTrace = vpi_debug_data.dbgTrace;
    DbgVdiff = vpi_debug_data.dbgVdiff;
    DbgOscil = vpi_debug_data.dbgOscil;
}


void register_vpiDebug(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$vpiDebug";
    tf_data.calltf=vpiDebugCall;
    tf_data.compiletf=vpiDebugCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_vpiDebug();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_vpiDebug,
//  NULL /*** final entry must be 0 ***/
//};
