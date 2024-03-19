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

/*
 *  PLI check function for $vpiDebug
 */
void vpiDebugCheck( int data, int reason )
{
    int index, err = 0;

    p_vpiDebug_data this = ( p_vpiDebug_data )malloc( sizeof( s_vpiDebug_data ) );

    this->dbgCback = 0;
    this->dbgEvent = 0;
    this->dbgTrace = 0;
    this->dbgVdiff = 0;
    this->dbgOscil = 0;

    for ( index = 1; index <= tf_nump( ); index++ )
    {
        if ( tf_typep( index ) == tf_string )
        {
            char* str = tf_getcstringp( index );

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

    if ( err )
    {
        tf_text( "vpiDebug: Usage: $vpiDebug( <option> [, ... ])\n" );
        tf_text( "vpiDebug:            callback    = enable debug for callback installation\n" );
        tf_text( "vpiDebug:            event       = enable debug for event callback triggers\n" );
        tf_text( "vpiDebug:            trace       = enable debug for back/hier tracing\n" );
        tf_text( "vpiDebug:            vcdiff      = enable debug for $vcdCompare\n" );
        tf_text( "vpiDebug:            oscillation = enable debug for $oscDetect\n" );
 
        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }
    tf_setworkarea( ( char* )this ); /* save flags */
}

/*
 *  PLI call function for $vpiDebug
 */
void vpiDebugCall( int data, int reason )
{
    p_vpiDebug_data this = ( p_vpiDebug_data )tf_getworkarea( );

    DbgCback = this->dbgCback;
    DbgEvent = this->dbgEvent;
    DbgTrace = this->dbgTrace;
    DbgVdiff = this->dbgVdiff;
    DbgOscil = this->dbgOscil;
}
