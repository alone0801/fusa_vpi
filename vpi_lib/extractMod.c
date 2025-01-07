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
 *  extractMod -- generate a top-level module to extract a
 *                single module from a large testcase
 *
 *  Usage: $extractMod( <module-path> );
 */

#include "vpiDebug.h"
#include "vpi_user.h"
static PLI_UINT32 globalOutFile = 0; /* HACK..HACK (manhole) */

static p_exmod_node newExmodNode( p_cback_data refn, int file )
{
    p_exmod_node this = ( p_exmod_node )malloc( sizeof( s_exmod_node ) );
 
    this->refn = refn;
    this->file = file;
 
    this->dbug = 0;
    this->name = "";

    return( this );
}

char* vectorRange( vpiHandle port )
{
    static char buff[ 128 ]; /* way over-sized */

    sprintf( buff, "[%d:0]", ( vpi_get( vpiSize, port ) - 1 ) );

    return( buff );
}

int checkTimeAdvance( int newTime )
{
    static int oldTime = 0;

    int diff = newTime - oldTime; oldTime = newTime; return( diff );
}

/*
 *  Callback for each event on tracked ports
 */
void extractModEventHandler( p_exmod_node this, p_cb_data cb_data_p )
{
if ( this->dbug )
{
vpi_mcd_printf( this->file, "    // at %d, %s went %s\n", cb_data_p->time->low, this->name, cb_data_p->value->value.str );
}
else
{
    int delay = checkTimeAdvance( cb_data_p->time->low );

    char buf[ 128 ]; buf[ 0 ] = 0x00; /* null string by default */

    if ( delay > 0 ) sprintf( buf, "#%d", delay );

    vpi_mcd_printf( this->file, "    %-8s %s_r = %d'b%s;\n", buf, vpi_get_str( vpiName, this->refn->refn ),
                                                                  vpi_get( vpiSize, this->refn->refn ),
                                                                  cb_data_p->value->value.str );
}
}

static void extractModEosHandler( p_cb_data data )
{
    vpi_mcd_printf( globalOutFile, "  end\n\n" );
    vpi_mcd_printf( globalOutFile, "endmodule\n" ); vpi_mcd_close( globalOutFile );
}

/*
 *  PLI instance data for $extractMod
 */
typedef struct t_extractMod_arg
{
  char*         outName;
  PLI_UINT32    outFile;

  p_object_list modList;

} s_extractMod_arg, *p_extractMod_arg;

/*
 *  PLI check function for $extractMod
 */
void extractModCheck( int data, int reason )
{
    int index, err = 0;

    p_extractMod_arg work = ( p_extractMod_arg )malloc( sizeof( s_extractMod_arg ) );

    work->modList = ( p_object_list )0;

    work->outName = ( char* )0;

    work->outFile = 1; /* use stdout by default */
	vpiHandle systf_h, arg_itr, arg_h; 
	s_vpi_value value_s; 
	/* 获取PLI系统任务的句柄 */ 
	systf_h = vpi_handle(vpiSysTfCall, NULL); 
	/* 获取参数的迭代器 */ 
	arg_itr = vpi_iterate(vpiArgument, systf_h);
    if (arg_itr) { 
	/* 遍历所有参数 */
	 for (index = 1; arg_h = vpi_scan(arg_itr); index++) { 
	 static char* fname = "outfile="; 
	 if (vpi_get(vpiType, arg_h) == vpiStringVal) { 
	 value_s.format = vpiStringVal; 
	 vpi_get_value(arg_h, &value_s); 
	 char* str = strdup(value_s.value.str);
//    for ( index = 1; index <= tf_nump( ); index++ )
//    {
//        static char* fname = "outfile=";
//        vpiHandle obj = vpi_handle_by_index(index);
//        vpiHandle obj = vpi_iterate(vpiArgument, tf_ithandle(index));
//        if ( tf_typep( index ) == tf_string )
//        if(obj)
//        {
//            char* str = tf_getcstringp( index );
//            char* str = vpi_get_str(vpiName, obj);
            if ( strncmp( str, fname, strlen( fname ) ) == 0 )
            {
                if ( work->outName )
                {
                    tf_text( "extractMod: Multiple 'outfile=', <%s> ignored\n", str ); ++err;
                }
                else
                {
//                    vpiHandle obj = vpi_handle_by_name(str, 0);
                    work->outName = strdup( str + strlen( fname ) );

                    work->outFile = vpi_mcd_open( work->outName );

                    if ( work->outFile == 0 )
                    {
                        tf_text( "extractMod: Cannot open <%s> for writing\n", work->outName ); ++err;
                    }
                }
            }
            else
            {
                vpiHandle obj = vpi_handle_by_name( str, 0 );

                if ( obj )
                {
                    if ( vpi_get( vpiType, obj ) == vpiModule )
                    {
                        if ( work->modList )
                        {
                            tf_text( "extractMod: Multiple modules, <%s> ignored\n", str ); ++err;
                        }
                        else
                        {
                            addNewObject( &( work->modList ), obj, str );
                        }
                    }
                    else
                    {
                        tf_text( "extractMod: Object <%s> is not a module\n", str ); ++err;
                    }
                }
                else
                {
                    tf_text( "extractMod: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            tf_text( "extractMod: Non-string parameter at %d\n", index ); ++err;
        }
    }
	}

    /*
     *  This function requires at least one module
     */
    if ( work->modList == 0 )
    {
        tf_error( "extractMod: No module specified\n" ); ++err;
    }

    if ( err )
    {
        tf_text( "extractMod: Usage: $extractMod( [ <module-or-option> [, ... ] ])\n" );
        tf_text( "extractMod:            outfile=<file> = specify output file\n" );
 
//        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }
 
    tf_setworkarea( ( char* )work ); /* save flags */
}

/*
 *  PLI call function for $extractMod
 */
void extractModCall( int data, int reason )
{
    p_extractMod_arg work = ( p_extractMod_arg )tf_getworkarea( );

    vpiHandle itr, ptr, mod = work->modList->refn;

    int modNameLen = 0; /* formatting flag */

    int file = work->outFile; /* extraction output file */

    vpi_printf( "extractMod: Generating top-level module to extract %s\n", work->modList->name );

    #define ForEach( t ) if ( itr = vpi_iterate( t, mod ) ) while ( ptr = vpi_scan( itr ) )

    vpi_mcd_printf( file, "module top;\n" );
    vpi_mcd_printf( file, "\n" );

    ForEach( vpiPort )
    {
        char* name = vpi_get_str( vpiName, ptr );

        char* size = vpi_get( vpiVector, ptr ) ? vectorRange( ptr ) : "     ";

        switch ( vpi_get( vpiDirection, ptr ) )
        {
            case vpiInput:  vpi_mcd_printf( file, "  reg  %8s %s_r;\n",        size, name );       break;
            case vpiOutput: vpi_mcd_printf( file, "  wire %8s %s_w;\n",        size, name );       break;
            case vpiInout:  vpi_mcd_printf( file, "  reg  %8s %s_r;\n",        size, name );
                            vpi_mcd_printf( file, "  wire %8s %s_w = %s_r;\n", size, name, name ); break;
        }
    }
    vpi_mcd_printf( file, "\n" );

    vpi_mcd_printf( file, "  %s uut( ", vpi_get_str( vpiDefName, mod ) );

    ForEach( vpiPort )
    {
        char* name = vpi_get_str( vpiName, ptr );

        if ( modNameLen )
        {
            vpi_mcd_printf( file, ",\n%s", makeSpace( modNameLen ) );
        }

        switch ( vpi_get( vpiDirection, ptr ) )
        {
            case vpiInput:  vpi_mcd_printf( file, ".%s( %s_r )", name, name ); break;
            case vpiInout:
            case vpiOutput: vpi_mcd_printf( file, ".%s( %s_w )", name, name ); break;
        }

        if ( modNameLen == 0 )
        {
            modNameLen = strlen( vpi_get_str( vpiDefName, mod ) ) + 8;
        }
    }
    vpi_mcd_printf( file, " );\n\n" );

    vpi_mcd_printf( file, "  initial begin\n" );

    ForEach( vpiPort )
    {
        if ( vpi_get( vpiDirection, ptr ) != vpiOutput )
        {
            p_exmod_node node = newExmodNode( setEventCallback( ptr ), file ); 

            node->refn->eptr = node; /* register interest in events */
        }

//        if ( vpi_get( vpiDirection, ptr ) == vpiInout )
//        {
//            p_exmod_node node = newExmodNode( setEventCallback( vpi_handle( vpiHighConn, ptr ) ), file ); 

//            node->refn->eptr = node; node->dbug = 1; node->name = malloc( 128 );

//            strcpy( node->name, vpi_get_str( vpiName, ptr ) ); strcat( node->name, "-hiconn" );
//        }

//        if ( vpi_get( vpiDirection, ptr ) == vpiInout )
//        {
//            p_exmod_node node = newExmodNode( setEventCallback( vpi_handle( vpiLowConn, ptr ) ), file ); 

//            node->refn->eptr = node; node->dbug = 1; node->name = malloc( 128 );

//            strcpy( node->name, vpi_get_str( vpiName, ptr ) ); strcat( node->name, "-loconn" );
//        }
    }

    globalOutFile = file; /* HACK..HACK (manhole) */

    /*
     *  Can't close off module until after end-of-simulation
     */
    addEosCallback( extractModEosHandler );
}

/*
 *  PLI misc function for $vcdCompare
 */
void extractModMisc( int data, int reason )
{
    if ( reason == cbAtEndOfSimTime ) dummyEosHandler( );
}

void register_extractMod(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$extractMod";
    tf_data.calltf=extractModCall;
    tf_data.compiletf=extractModCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_extractMod();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_extractMod,
//  NULL /*** final entry must be 0 ***/
//};
