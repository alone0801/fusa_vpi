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

/*
 *  Add "node" as one of the causes of "targ"
 */
static void newTraceLink( p_trace_node targ, p_trace_node node )
{
    p_trace_link this = ( p_trace_link )malloc( sizeof( s_trace_link ) );
 
    this->forw = targ;
    this->back = node;
 
    /* attach link to the target's back-trace list */
 
    this->next = targ->back; targ->back = this;
 
    DBG_CBACK(( "Linking driver %s", FullName( node->refn->refn ) ));
    DBG_CBACK(( " as cause of %s\n", FullName( targ->refn->refn ) ));
}

/*
 *  Create a new trace_node for a net/reg callback
 */
static p_trace_node newTraceNode( p_cback_data refn, p_trace_node targ )
{
    p_trace_node this = ( p_trace_node )malloc( sizeof( s_trace_node ) );
 
    this->refn = refn;
    this->loop = 0;
 
    this->valu = strdup( "x" );
 
    this->t_hi = 0;
    this->t_lo = 0;
 
    /* initialize event-tracing pointers */
 
    this->back = ( p_trace_link )0;
    this->last = ( p_event_node )0;
 
    /* add this node to the "drivers" list of the calling node, if any */
 
    if ( targ ) newTraceLink( targ, this );
 
    return( this );
}

/*
 *  Trace callback to determine if a trace_node has already been installed
 */
static int checkForLoop( vpiHandle obj, char* name )
{
    p_cback_data node = getEventCallback( obj );

    return( ( node && node->tree ) ? 1 : 0 );
}

/*
 *  Trace callback to link trace to an already existing trace_node
 */
static void* loopDetected( vpiHandle obj, char* name, void* targ )
{
    if ( targ )
    {
        p_cback_data node = getEventCallback( obj );

        if ( node && node->tree )
        {
            p_trace_link link = ( ( p_trace_node )targ )->back;
 
            /* add driver link from node to targ if not already there */

            for ( ; link; link = link->next )
            {
                if ( link->back == node->tree ) return( targ ); /* dup check */
            }
            newTraceLink( ( p_trace_node )targ, node->tree );
        }
    }
    return( targ );
}

/*
 *  Trace callback to install a trace_node on a signal
 */
static void* installTrace( vpiHandle obj, char* name, void* targ )
{
    p_cback_data node = setEventCallback( obj );

    node->tree = newTraceNode( node, ( p_trace_node )targ );

    return( ( void* )( node->tree ) );
}

static s_trace_data traceData = { checkForLoop, loopDetected, installTrace };

/*
 *  Public function to generate the causal tree
 */
void generateCausalTree( vpiHandle obj )
{
    backTrace( 0, &traceData, 0, obj );
}

/*
 *  Callback for each event on tracked signals
 */
void traceSignalEventHandler( p_trace_node this, p_cb_data cb_data_p )
{
    extern void exEventHandler( p_trace_node, p_cb_data );
 
    /* add value (freeing old value's memory) */
 
    if ( this->valu ) free( this->valu );
 
    this->valu = strdup( cb_data_p->value->value.str );
 
    /* store time of event */
 
    this->t_hi = cb_data_p->time->high;
    this->t_lo = cb_data_p->time->low;
 
    exEventHandler( this, cb_data_p ); /* manhole -- trigger "new" event handler */
}

/*
 *  Callback for end-of-simulation (reporting)
 */
static void traceSignalEosHandler( p_cb_data cb_data_p )
{
    p_cback_data last = getLastEvent( );

    if ( last && last->tree && ( last->tree->dump & FLG_TRACE_ON_LAST ) )
    {
        vpi_printf( "=== event trace ===\n" );     dumpCausalTree( 1, last->tree );
        vpi_printf( "=== causality trace ===\n" ); analyzeCause( 0, last->tree );
    }
}

/*
 *  PLI instance data for $traceSignal
 */
typedef struct t_traceSignal_arg
{
  int           onEvent;
  int           onVdiff;
  int           onOscil;
  int           onFinal;

  p_object_list sigList;

} s_traceSignal_arg, *p_traceSignal_arg;

/*
 *  PLI check function for $traceSignal
 */
void traceSignalCheck( int data, int reason )
{
    int index, err = 0;

    p_traceSignal_arg this = ( p_traceSignal_arg )malloc( sizeof( s_traceSignal_arg ) );

    this->sigList = ( p_object_list )0;

    this->onEvent = 0;
    this->onVdiff = 0;
    this->onOscil = 0;
    this->onFinal = 0;

    for ( index = 1; index <= tf_nump( ); index++ )
    {
        if ( tf_typep( index ) == tf_string )
        {
            char* str = tf_getcstringp( index );

                 if ( strcmp( str, "onEvent"  ) == 0 ) this->onEvent = 1;
            else if ( strcmp( str, "onDiff"   ) == 0 ) this->onVdiff = 1;
            else if ( strcmp( str, "onLoop"   ) == 0 ) this->onOscil = 1;
            else if ( strcmp( str, "onOsc"    ) == 0 ) this->onOscil = 1;
            else if ( strcmp( str, "onFinish" ) == 0 ) this->onFinal = 1;
            else
            {
                vpiHandle obj = vpi_handle_by_name( str, 0 );

                if ( obj )
                {
                    addNewObject( &( this->sigList ), obj, str );
                }
                else
                {
                    tf_text( "traceSignal: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            tf_text( "traceSignal: Non-string parameter at %d\n", index ); ++err;
        }
    }

    /*
     *  We need to see at least one signal
     */
    if ( this->sigList == ( p_object_list )0 )
    {
        tf_text( "traceSignal: No signals specified\n" ); ++err;
    }

    if ( err )
    {
        tf_text( "traceSignal: Usage: $traceSignal( <signal-or-option> [, ... ])\n" );
        tf_text( "traceSignal:            onEvent = display trace on every transition\n" );
        tf_text( "traceSignal:            onVdiff = display trace on VCD mismatch ($vcdCompare)\n" );
        tf_text( "traceSignal:            onOscil = display trace on oscullation ($oscDetect)\n" );
        tf_text( "traceSignal:            onFinal = display trace at end-of-simulation (obsolete)\n" );

        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }

    tf_setworkarea( ( char* )this ); /* save flags */
}

/*
 *  PLI call function for $traceSignal
 */
void traceSignalCall( int data, int reason )
{
    p_traceSignal_arg work = ( p_traceSignal_arg )tf_getworkarea( );

    p_object_list this;

    for ( this = work->sigList; this; this = this->next )
    {
        vpi_printf( "traceSignal: back-tracing from %s\n", this->name );

        /*
         *  Trace back from the given object and then fetch it's event node
         */
        generateCausalTree( this->refn );

        /*
         *  Enable trace output for this signal
         */
        if ( work->onEvent ) getEventCallback( this->refn )->tree->dump |= FLG_TRACE_ON_EVNT;
        if ( work->onVdiff ) getEventCallback( this->refn )->tree->dump |= FLG_TRACE_ON_DIFF;
        if ( work->onOscil ) getEventCallback( this->refn )->tree->dump |= FLG_TRACE_ON_LOOP;
        if ( work->onFinal ) getEventCallback( this->refn )->tree->dump |= FLG_TRACE_ON_LAST;
    }

    addEosCallback( traceSignalEosHandler ); /* trigger at end-of-simulation */
}

/*
 *  PLI misc function for $traceSignal
 */
void traceSignalMisc( int data, int reason )
{
    if ( reason == reason_finish ) dummyEosHandler( );
}
