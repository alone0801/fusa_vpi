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
 *  Head of doubly-linked list of last seen events
 */
static p_cback_data lastEvent = ( p_cback_data )0;

p_cback_data getLastEvent( ) { return( lastEvent ); }

/*
 *  Create a user_data structure for the new callback
 */
static p_cback_data newCallbackData( vpiHandle obj )
{
    p_cback_data this = ( p_cback_data )malloc( sizeof( s_cback_data ) );

    this->refn = obj;

    this->last = strdup( "-" );

    this->tree = ( p_trace_node )0;

    this->dnod = ( p_vdiff_node )0;
    this->oscp = ( p_oscil_node )0;
    this->eptr = ( p_exmod_node )0;

#ifdef USE_LASTSEEN

    /* node not yet in event list */
 
    this->next = this;
    this->prev = this;

#endif

    return( this );
}

/*
 *  Callback for each event on tracked signals
 */
static int eventHandler( p_cb_data cb_data_p )
{
    p_cback_data this = ( p_cback_data )cb_data_p->user_data;

    if ( this == ( p_cback_data )0 )
    {
        vpi_printf( "==> Oops... ignoring NULL user data on a callback\n" ); return( 0 );
    }

    /* report the event early so the effects show up after the cause */

    DBG_EVENT(( "eventHandler: %s ( %s -> %s ) at %ld:%ld\n", FullName( this->refn ), this->last,
                                                              cb_data_p->value->value.str,
                                                              cb_data_p->time->high,
                                                              cb_data_p->time->low ));

#ifdef USE_LASTSEEN

    /* remove this node from event list... */

    this->prev->next = this->next;
    this->next->prev = this->prev;

    /* ...add it back at the top of the list... */

    if ( lastEvent )
    {
        this->prev = lastEvent->prev;
        this->next = lastEvent;

        this->prev->next = this;
        this->next->prev = this;
    }

    /* ...and call this one the "last" (ie: most recent) event */

    lastEvent = this;

#endif

    /*
     *  Call the causal tree event handler
     *    (must be called before other event handlers
     */
    if ( this->tree ) traceSignalEventHandler( this->tree, cb_data_p );

    /*
     *  Call the individual event handlers
     *    (this should eventually be a list)
     */
    if ( this->dnod ) vcdCompareEventHandler(  this->dnod, cb_data_p );
    if ( this->oscp ) oscDetectEventHandler(   this->oscp, cb_data_p );
    if ( this->eptr ) extractModEventHandler(  this->eptr, cb_data_p );

    triggerOnEvent( this );

    /* save "last-known" value (freeing old value's memory) */
 
    if ( this->last ) free( this->last );
 
    this->last = strdup( cb_data_p->value->value.str );

    return( 1 );
}

/*
 *  Set a NEW callback on a net/reg
 */
static p_cback_data newEventCallback( vpiHandle obj )
{
    static s_vpi_time  time_s  = { vpiSimTime };
    static s_vpi_value value_s = { vpiBinStrVal };

    s_cb_data cbData = { cbValueChange, eventHandler, 0, &time_s, &value_s };

    /* create a new database entry and store it as user_data */

    cbData.user_data = ( char* )newCallbackData( cbData.obj = obj );

    /* ignore the callback if the node creation failed */

    if ( cbData.user_data ) vpi_register_cb( &cbData );

    DBG_CBACK(( "Callback set on %s (data=%ld)\n", FullName( obj ), cbData.user_data ));

    return( ( p_cback_data )cbData.user_data );
}

/*
 *  Check whether or not we have a callback set on this signal
 */
//bool hasEventCallback( vpiHandle obj )
int hasEventCallback( vpiHandle obj )
{
    vpiHandle cb, itr = vpi_iterate( vpiCallback, obj );

    while ( itr && ( cb = vpi_scan( itr ) ) )
    {
        s_cb_data cbData; vpi_get_cb_info( cb, &cbData );

        if ( cbData.cb_rtn == eventHandler ) return( 1 );
    }
    return( 0 );
}

/*
 *  Get user-data from an already-set callback
 */
p_cback_data getEventCallback( vpiHandle obj )
{
    vpiHandle cb, itr = vpi_iterate( vpiCallback, obj );

    while ( itr && ( cb = vpi_scan( itr ) ) )
    {
        s_cb_data cbData; vpi_get_cb_info( cb, &cbData );

        if ( cbData.cb_rtn == eventHandler )
        {
            return( ( p_cback_data )cbData.user_data );
        }
    }
    return( ( p_cback_data )0 );
}

/*
 *  Set a callback on a net/reg or return the one already there
 */
p_cback_data setEventCallback( vpiHandle obj )
{
    p_cback_data temp = getEventCallback( obj );

    return( temp ? temp : newEventCallback( obj ) );
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnEvent( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_EVNT ) )
    {
        causalTrace( this->tree, "onEvent" );
    }
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnDiff( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_DIFF ) )
    {
        causalTrace( this->tree, "onDiff" );
    }
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnLoop( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_LOOP ) )
    {
        causalTrace( this->tree, "onLoop" );
    }
}

void register_evCallback(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$evCallback";
    tf_data.calltf=NULL;
    tf_data.compiletf=NULL;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_evCallback();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_evCallback,
//  NULL /*** final entry must be 0 ***/
//};
