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
	char* str;
    p_dumpUpstream_arg this = ( p_dumpUpstream_arg )malloc( sizeof( s_dumpUpstream_arg ) );

    this->sigList = ( p_object_list )0;

    this->myDummy = 0;
    vpiHandle systf_h, arg_itr, arg_h; 
	s_vpi_value value_s;
	// 获取PLI系统任务的句柄 
	systf_h = vpi_handle(vpiSysTfCall, NULL); 
	// 获取参数的迭代器 
	arg_itr = vpi_iterate(vpiArgument, systf_h);
	if(arg_itr) {
//    for ( index = 1; index <= tf_nump( ); index++ )
//    {
//        if ( tf_typep( index ) == tf_string )
//        vpiHandle obj = vpi_iterate(vpiArgument, tf_ithandle(index));
//        if(obj)
//        {
//            char* str = tf_getcstringp( index );
//            char* str = vpi_get_str(vpiName, obj);
      for (index = 1; arg_h = vpi_scan(arg_itr); index++) { 
	    if (vpi_get(vpiType, arg_h) == vpiStringVal) { 
		 value_s.format = vpiStringVal;
		 vpi_get_value(arg_h, &value_s); 
		 str = strdup(value_s.value.str); 
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
 
//        tf_message( ERR_ERROR, "User", "TFARG", "" );
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

// 注册函数
void register_dumpUpstream() { 
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$dumpUpstreame";
    tf_data.calltf=dumpUpstreamCall;
    tf_data.compiletf=dumpUpstreamCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
} 
//extern void register_dumpUpstream();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_dumpUpstream,
//  NULL /*** final entry must be 0 ***/
//};
