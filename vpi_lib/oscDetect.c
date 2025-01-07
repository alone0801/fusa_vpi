/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

/*
 *  This PLI function is a simple example of how to use the back-trace
 *  mechanism to accomplish something very simple. In this function we
 *  print a list of all the upstream nodes for use in $display.
 */

#include "vpiDebug.h"
#include "vpi_user.h"
/*
 *  Create a new trace_node for a net/reg callback
 */
static p_oscil_node newOscilNode( p_cback_data refn, p_oscil_data data )
{
    p_oscil_node this = ( p_oscil_node )malloc( sizeof( s_oscil_node ) );
 
    this->refn = refn;
    this->data = data;
 
    this->t_hi = 0;
    this->t_lo = 0;

    this->tcnt = 0;

    this->next = 0;

    return( this );
}

/*
 *  This function undoes the effects of the oscillation detection
 */
static int timeAdvanceHandler( p_cb_data cb_data_p )
{
    p_oscil_data data = ( p_oscil_data )( cb_data_p->user_data );

    /*
     *  We should only be here as the result of an oscillation
     */
    if ( data->wait )
    {
        vpi_printf( "oscDetect: Oscillation supressed, resuming simulation\n" );

        /*
         *  Clear the global oscillation detect bit first to prevent looping
         */
        data->wait = 0;

        /*
         *  Release all the X-forced signals
         */
        for ( ; data->head; data->head = data->head->next )
        {
            s_vpi_value value = { vpiScalarVal }; value.value.scalar = vpiX;

            vpi_put_value( data->head->refn->refn, &value, ( p_vpi_time )0, vpiReleaseFlag );

            DBG_OSCIL(( "oscDetect: releasing signal %s\n", vpi_get_str( vpiFullName, data->head->refn->refn ) ));
        }
    }
    else
    {
        vpi_printf( "oscDetect: Warning: Time advance trigger without oscillation" );
    }
}

static vpiHandle setTimeAdvanceCallback( p_oscil_data data )
{
    static s_vpi_time time_s = { vpiSimTime };
 
    s_cb_data callbackData = { cbReadOnlySynch, timeAdvanceHandler, 0, &time_s, 0 };
 
    callbackData.time->high = 0;
    callbackData.time->low  = 0; /* set callback to NOW */
 
    callbackData.user_data  = ( char* )data;
 
    return( vpi_register_cb( &callbackData ) );
}

void oscDetectEventHandler( p_oscil_node this, p_cb_data cb_data_p )
{
    p_oscil_data data = this->data;

    /*
     *  Check to see if time has advanced since the last event on this signal
     */
    if ( ( this->t_hi == cb_data_p->time->high )
    &&   ( this->t_lo == cb_data_p->time->low  ) )
    {
        /*
         *  If no oscillation has been detected yet, increment the event count
         */
        if ( ( data->wait == 0 ) && ( ++( this->tcnt ) > data->maxt ) )
        {
            char* name = vpi_get_str( vpiFullName, this->refn->refn );

            /*
             *  Report the oscillation the first time it happens
             */
            vpi_printf( "oscDetect: ==> Oscillation detected at %d:%d on %s\n", this->t_hi,
                                                                                this->t_lo, name );

            /*
             *  Trigger trace output and, if requested, terminate on initial detection...
             */
            triggerOnLoop( this->refn ); if ( data->stop ) tf_dofinish( );

            /*
             *  ...else, set callback to alert us when time finally becomes un-stuck
             */
            data->wait = setTimeAdvanceCallback( data );
        }

        /*
         *  Once oscillation is detected, all signals with events still in the queue
         *  for the same time step must be X-forced in order to supress the oscillation
         */
        if ( data->wait && ( this->tcnt > 1 ) )
        {
            char* name = vpi_get_str( vpiFullName, this->refn->refn );

            /*
             *  Force signal to X and add to list of forced signals.
             */
            s_vpi_value value = { vpiScalarVal }; value.value.scalar = vpiX;

            /*
             *  Be careful to re-set this->tcnt before doing the force,
             *    as the force can/will trigger another callback
             */
            this->tcnt = 1; vpi_printf( "oscDetect: Forcing signal %s to X\n", name );

            vpi_put_value( this->refn->refn, &value, ( p_vpi_time )0, vpiForceFlag );

            /*
             *  Add this signal to the list of forced values
             */
            this->next = data->head; data->head = this;
        }
    }
    else /* time has advanced */
    {
        this->t_hi = cb_data_p->time->high;
        this->t_lo = cb_data_p->time->low;

        this->tcnt = 0; /* restart the count */
    }
}

static int oscDetectCallback( int level, vpiHandle obj, void* userData )
{
    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiNet:
        case vpiReg:
        {
            p_cback_data node = getEventCallback( obj );
 
            if ( node && node->oscp )
            {
                DBG_TRACE(( "%s...duplicate...\n", makeSpace( level ) )); return( 1 );
            }
            else /* install callback */
            {
                p_cback_data node = setEventCallback( obj );
 
                node->oscp = newOscilNode( node, ( p_oscil_data )userData );

                break; /* could be hierTraceCont( level, obj, oscDetectCallback, userData ) */
            }
        }
    }
    return( 0 );  /* continue tracing */
}

/*
 *  PLI instance data for $oscDetect
 */
typedef struct t_oscDetect_arg
{
  int           stop;
  int           maxt;

  p_object_list list;

} s_oscDetect_arg, *p_oscDetect_arg;

/*
 *  PLI check function for $oscDetect
 */
void oscDetectCheck( int data, int reason )
{
    int index, err = 0;
	char* str;
    p_oscDetect_arg work = ( p_oscDetect_arg )malloc( sizeof( s_oscDetect_arg ) );

    work->list = ( p_object_list )0;

    work->stop = 0;
    work->maxt = 100;
    vpiHandle systf_h, arg_itr, arg_h; 
	s_vpi_value value_s;
	// 获取PLI系统任务的句柄 
	systf_h = vpi_handle(vpiSysTfCall, NULL); 
	// 获取参数的迭代器 
	arg_itr = vpi_iterate(vpiArgument, systf_h);
	if(arg_itr) {
	/* 遍历所有参数 */
	 for (index = 1; arg_h = vpi_scan(arg_itr); index++) { 
     static char* thresh = "thresh=";
	 if (vpi_get(vpiType, arg_h) == vpiStringVal) { 
	 value_s.format = vpiStringVal; 
	 vpi_get_value(arg_h, &value_s); 
	 char* str = strdup(value_s.value.str);
//    for ( index = 1; index <= tf_nump( ); index++ )
//    {
//        static char* thresh = "thresh=";

//        if ( tf_typep( index ) == tf_string )
//        vpiHandle obj = vpi_iterate(vpiArgument, tf_ithandle(index));
//        if(obj)
//        {
//            char* str = tf_getcstringp( index );
//            char* str = vpi_get_str(vpiName, obj);
                 if ( strcmp(  str, "stopOnDetect"           ) == 0 ) work->stop = 1;
            else if ( strncmp( str, thresh, strlen( thresh ) ) == 0 ) work->maxt = atol( str + strlen( thresh ) );
            else
            {
                vpiHandle obj = vpi_handle_by_name( str, 0 );

                if ( obj )
                {
                    if ( vpi_get( vpiType, obj ) == vpiModule )
                    {
                        addNewObject( &( work->list ), obj, str );
                    }
                    else
                    {
                        tf_text( "oscDetect: Object <%s> is not a module\n", str ); ++err;
                    }
                }
                else
                {
                    tf_text( "oscDetect: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            tf_text( "oscDetect: Non-string parameter at %d\n", index ); ++err;
        }
    }
	}

    if ( err )
    {
        tf_text( "oscDetect: Usage: $oscDetect( [ <module-or-option> [, ... ] ])\n" );
        tf_text( "oscDetect:            stopOnDetect = enter CLI on detection\n" );
        tf_text( "oscDetect:            thresh=<n>   = set detection event threshold\n" );
 
//        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }

    tf_setworkarea( ( char* )work ); /* save flags */
}

/*
 *  PLI call function for $oscDetect
 */
void oscDetectCall( int data, int reason )
{
    p_oscDetect_arg work = ( p_oscDetect_arg )tf_getworkarea( );

    p_oscil_data userData = ( p_oscil_data )malloc( sizeof( s_oscil_data ) );

    userData->head = 0;
    userData->wait = 0;

    userData->stop = work->stop;
    userData->maxt = work->maxt;

    if ( work->list )
    {
        p_object_list this = work->list;

        for ( ; this; this = this->next )
        {
            vpi_printf( "oscDetect: Instrumenting %s for oscillation detection...\n", this->name );

            hierTrace( 0, this->refn, oscDetectCallback, ( void* )userData );
        }
    }
    else
    {
        vpiHandle ptr, itr = vpi_iterate( vpiModule, 0 );

        vpi_printf( "oscDetect: Instrumenting entire design for oscillation detection...\n" );

        while ( ptr = vpi_scan( itr ) )
        {
            hierTrace( 0, ptr, oscDetectCallback, ( void* )userData );
        }
    }
}


void register_oscDetect(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$oscDetect";
    tf_data.calltf=oscDetectCall;
    tf_data.compiletf=oscDetectCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_oscDetect();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_oscDetect,
//  NULL /*** final entry must be 0 ***/
//};
