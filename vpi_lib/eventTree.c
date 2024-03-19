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
 *  Causal event tree maintenance
 */

#include "vpiDebug.h"

static p_event_node eventNodePool = ( p_event_node )0;
static p_event_link eventLinkPool = ( p_event_link )0;

/*
 *  Allocate a new event node only if none exist in the free list
 */
static p_event_node newEventNode( p_trace_node refn )
{
    p_event_node this = ( p_event_node )0;

    if ( eventNodePool )
    {
        this = eventNodePool; eventNodePool = this->next;
    }
    else
    {
        this = ( p_event_node )malloc( sizeof( s_event_node ) );
    }

    this->back = ( p_event_link )0;
    this->next = ( p_event_node )0;

    this->last = strdup( "-" );
    this->valu = strdup( "x" );

    this->refn = refn;
    this->rcnt = 1;
    this->loop = 0;

    return( this );
}

/*
 *  Freeing an event node simply means returning it to the free list
 */
void freeEventNode( p_event_node node )
{
    node->next = eventNodePool; eventNodePool = node;
}

/*
 *  Allocate a new event node only if none exist in the free list
 */
static p_event_link newEventLink( p_event_link next )
{
    p_event_link this = ( p_event_link )0;

    if ( eventLinkPool )
    {
        this = eventLinkPool; eventLinkPool = this->next;
    }
    else
    {
        this = ( p_event_link )malloc( sizeof( s_event_link ) );
    }

    this->next = next;

    this->forw = ( p_event_node )0;
    this->back = ( p_event_node )0;

    return( this );
}

/*
 *  Freeing an event link simply means returning it to the free list
 */
void freeEventLink( p_event_link link )
{
    link->next = eventLinkPool; eventLinkPool = link;
}

/*
 *  To delete an event node:
 *
 *  1) Decrement reference count
 *  2) If reference count is now zero:
 *     a) Release causal event (this->next)
 *     b) Return this node to the free pool
 */
void releaseEventNode( p_event_node this )
{
    void releaseEventList( p_event_link );

    if ( --( this->rcnt ) < 1 )
    {
        releaseEventList( this->back ); freeEventNode( this );
    }
}

void releaseEventList( p_event_link this )
{
    if ( this == ( p_event_link )0 ) return;

    /* recurse first */

    releaseEventList( this->next );

    /* ...then, release the corresponding node and free this link */

    releaseEventNode( this->back ); freeEventLink( this );
}

/*
 *  Indented dump of nodes in causal tree
 */
static void dumpEventNode( int level, p_event_node this, p_event_node prev )
{
    char* head = makeSpace( ++level ); /* must be pre-increment */
 
    char* name = FullName( this->refn->refn->refn );

    if ( prev && vpi_compare_objects( this->refn->refn->refn, prev->refn->refn->refn ) )
    {
        vpi_printf( "%scause: self (looks like %s might be a CLOCK)\n", head, name );
    }
    else if ( this->loop )
    {
        vpi_printf( "%scause: loop (possible FEEDBACK at %s)\n", head, name );
    }
    else if ( this->refn->loop )
    {
        vpi_printf( "%scause: loop (possible ZERO-LOOP at %s)\n", head, name );
    }
    else /* follow all "latest" events */
    {
        if ( this->back )
        {
            p_event_link link;

            vpi_printf( "%scause: %s ( %s -> %s ) at %ld:%ld\n", head, name, this->last,
                                                                             this->valu,
                                                                             this->t_hi,
                                                                             this->t_lo );

            if ( this->back->next )
            {
                vpi_printf( "%spotential race drives %s:\n", makeSpace( ++level ), name );
            }

            for ( link = this->back; link; link = link->next )
            {
                this->loop = 1; this->refn->loop = 1;

                dumpEventNode( level, link->back, this );

                this->loop = 0; this->refn->loop = 0;
            }
        }
        else /* no cause must imply assign */
        {

            vpi_printf( "%sassign: %s ( %s -> %s ) at %ld:%ld\n", head, name, this->last,
                                                                              this->valu,
                                                                              this->t_hi,
                                                                              this->t_lo );
        }
    }
}

/*
 *  Report causal trace for a given signal
 */
void causalTrace( p_trace_node this, char* why )
{
    vpi_printf( "Backtrace (%s) on signal: %s at %ld:%ld\n", why, FullName( this->refn->refn ),
                                                                  this->last->t_hi,
                                                                  this->last->t_lo );

    /* begin recursive dump */

    dumpEventNode( 1, this->last, ( p_event_node )0 );
}

/*
 *  For each new event:
 *
 *  1) Release "last event" (this->last)
 *  2) Create an new event, store new value and time
 *  3) Signal node points to new event, refn count = 1
 *  4) If causal event can be determined for event:
 *     a) Back-pointer (this->last->next) points to causal event
 *     b) Increment refn count in causal event node
 */
extern int nodeTimeCompare( p_trace_node, p_trace_node );

void exEventHandler( p_trace_node this, p_cb_data cb_data_p )
{
    p_trace_link link = ( p_trace_link )0;
    p_trace_link mark = ( p_trace_link )0;

    DBG_CBACK(( "exEventHandler: Callback from %s\n", FullName( this->refn->refn ) ));

    /* release reference to previous event, if any, and get new event */

    if ( this->last ) releaseEventNode( this->last ); this->last = newEventNode( this );

    /* store former value (freeing old value's memory) */

    if ( this->last->last ) free( this->last->last );
 
    this->last->last = strdup( this->refn->last );
 
    /* store current value (freeing old value's memory) */

    if ( this->last->valu ) free( this->last->valu );
 
    this->last->valu = strdup( cb_data_p->value->value.str );
 
    /* store time of event */
 
    this->last->t_hi = cb_data_p->time->high;
    this->last->t_lo = cb_data_p->time->low;

    /* walk the list of drivers (re-using pointer) */

    for ( link = this->back; link; link = link->next )
    {
        p_trace_node node = link->back;

        /* ignore non-causal input changes (later in time) */

        if ( nodeTimeCompare( node, this ) > 0 )
        {
            DBG_EVENT(( "exEventHandler: %s (%ld:%ld) changed after %s\n", FullName( node->refn->refn ),
                                                                           node->t_hi,
                                                                           node->t_lo,
                                                                           FullName( this->refn->refn ) ));
        }
        else
        {
            DBG_EVENT(( "exEventHandler: %s (%ld:%ld)\n", FullName( node->refn->refn ),
                                                          node->t_hi,
                                                          node->t_lo,
                                                          FullName( this->refn->refn ) ));

            /* find the cause with the most recent event time */

            if ( ( mark == 0 ) || ( nodeTimeCompare( mark->back, node ) <= 0 ) )
            {
                mark = link; /* 'dis be our guy */
            }
        }
    }

    if ( mark )
    {
        /* report ALL nodes that may have changed at the same time */

        for ( link = this->back; link; link = link->next )
        {
            p_trace_node node = link->back;

            if ( nodeTimeCompare( node, mark->back ) == 0 )
            {
                PLI_UINT32 t_hi = this->last->t_hi - node->t_hi;
                PLI_UINT32 t_lo = this->last->t_lo - node->t_lo;

                DBG_EVENT(( "exEventHandler: found %s, delay %ld:%ld\n", FullName( node->refn->refn ), t_hi, t_lo ));

                /* add a causal event only if an event occured on the node */

                if ( node->last )
                {
                    this->last->back = newEventLink( this->last->back );

                    this->last->back->forw = this->last;
                    this->last->back->back = node->last; ++( node->last->rcnt );
                }
            }
        }
    }
    else
    {
        DBG_EVENT(( "exEventHandler: no causal events found\n" ));
    }
}
