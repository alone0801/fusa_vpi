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

static hash_table sigHash;

/*
 *  manhole -- yeah, this is hacky
 *             eventually the output file name and the name of
 *             the new VCD file should be parameterized
 */
static FILE* outputFile = ( FILE* )0;

static int checkForLoop( vpiHandle obj, char* name )
{
    return( hashInsert( name, "", &sigHash ) ); /* don't use NULL data */
}

static void* loopDetected( vpiHandle obj, char* name, void* targ )
{
    return( targ ); /* nothing to do */
}

static void* installTrace( vpiHandle obj, char* name, void* targ )
{
    fprintf( outputFile, "    $dumpvars( 0, %s );\n", name ); return( targ );
}

static s_trace_data trace_data = { checkForLoop, loopDetected, installTrace };

/*
 *  PLI instance data for $dumpUpstream
 */
typedef struct t_dumpUpstream_arg
{
  int           myDummy;
  p_object_list sigList;

} s_dumpUpstream_arg, *p_dumpUpstream_arg;

/*
 *  PLI check function for $dumpUpstream
 */
void dumpUpstreamCheck( int data, int reason )
{
    int index, err = 0;

    p_dumpUpstream_arg this = ( p_dumpUpstream_arg )malloc( sizeof( s_dumpUpstream_arg ) );

    this->sigList = ( p_object_list )0;

    this->myDummy = 0;

    for ( index = 1; index <= tf_nump( ); index++ )
    {
        if ( tf_typep( index ) == tf_string )
        {
            char* str = tf_getcstringp( index );

            if ( strcmp( str, "myDummy" ) == 0 ) this->myDummy = 1;
            else
            {
                vpiHandle obj = vpi_handle_by_name( str, 0 );

                if ( obj )
                {
                    addNewObject( &( this->sigList ), obj, str );
                }
                else
                {
                    tf_text( "dumpUpstream: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            tf_text( "dumpUpstream: Non-string parameter at %d\n", index ); ++err;
        }
    }

    /*
     *  We need to see at least one signal
     */
    if ( this->sigList == ( p_object_list )0 )
    {
        tf_text( "dumpUpstream: No signals specified\n" ); ++err;
    }
 
    if ( err )
    {
        tf_text( "dumpUpstream: Usage: $dumpUpstream( <signal> [, ... ])\n" );
 
        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }

    tf_setworkarea( ( char* )this ); /* save flags */
}

/*
 *  PLI call function for $dumpUpstream
 */
void dumpUpstreamCall( int data, int reason )
{
    p_dumpUpstream_arg work = ( p_dumpUpstream_arg )tf_getworkarea( );

    p_object_list this = work->sigList;

    hashInitialize( &sigHash, 200 );

    outputFile = fopen( "dummy.v", "w" ); /* manhole -- hardcoded name */

    /*
     *  Write the header of a dummy module to hold the dump statements
     */
    fprintf( outputFile, "module dummy;\n" );
    fprintf( outputFile, "  initial #0 begin\n" );
    fprintf( outputFile, "    $dumpfile( \"trace-%s.vcd\" );\n", this->name );

    /*
     *  Write dumpvars statements for all traced signals
     */
    for ( ; this; this = this->next )
    {
        vpi_printf( "dumpUpstream: Dumping hierarchy from %s\n", this->name );

        backTrace( 0, &trace_data, 0, this->refn );
    }
    fprintf( outputFile, "  end\n" );
    fprintf( outputFile, "endmodule\n" );
}
