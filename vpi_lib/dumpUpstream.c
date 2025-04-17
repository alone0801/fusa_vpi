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

    vpiHandle systf = vpi_handle(vpiSysTfCall, NULL);
    vpiHandle args = vpi_iterate(vpiArgument, systf);
    vpiHandle arg;

    if(args != NULL)
    {
        while((arg = vpi_scan(args)) != NULL)
        {
            s_vpi_value val;
            val.format = vpiStringVal;
            vpi_get_value(arg, &val);

            if(val.value.str == NULL)
            {
                vpi_printf("dumpUpstream: Non-string parameter at %d\n", index);
                ++err;
            }
            else
            {
                char* str = val.value.str;
                if(strcmp(str, "myDummy") == 0)
                    this->myDummy = 1;
                else
                {
                    vpiHandle obj = vpi_handle_by_name( str, 0 );

                    if ( obj )
                        addNewObject( &( this->sigList ), obj, str );
                    else
                    {
                        vpi_printf("dumpUpstream: Unable to find object <%s>\n", str); 
                        ++err;
                    }
                }
            }
        }
    }
    /*
     *  We need to see at least one signal
     */
    if ( this->sigList == ( p_object_list )0 )
    {
        vpi_printf( "dumpUpstream: No signals specified\n" ); ++err;
    }
 
    if ( err )
    {
        vpi_printf( "dumpUpstream: Usage: $dumpUpstream( <signal> [, ... ])\n" ); 
    }
    
    vpi_free_object(args); 
    vpi_put_userdata(systf, (PLI_BYTE8*)this);/* save flags */
}

/*
 *  PLI call function for $dumpUpstream
 */
void dumpUpstreamCall( int data, int reason )
{
    vpiHandle systf = vpi_handle(vpiSysTfCall, NULL);
    p_dumpUpstream_arg work = ( p_dumpUpstream_arg )vpi_get_userdata(systf);

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
