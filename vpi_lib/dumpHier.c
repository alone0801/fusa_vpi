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
 *  PLI instance data for $dumpHier
 */
typedef struct t_dumpHier_arg
{
  int           myDummy;
  p_object_list modList;

} s_dumpHier_arg, *p_dumpHier_arg;

/*
 *  PLI check function for $dumpHier
 */
void dumpHierCheck( int data, int reason )
{
    int index, err = 0;
	char* str;
    p_dumpHier_arg work = ( p_dumpHier_arg )malloc( sizeof( s_dumpHier_arg ) );

    work->modList = ( p_object_list )0;

    work->myDummy = 0;
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
            if ( strcmp( str, "myDummy"  ) == 0 ) work->myDummy = 1;
            else
            {
                vpiHandle obj = vpi_handle_by_name( str, 0 );

                if ( obj )
                {
                    if ( vpi_get( vpiType, obj ) == vpiModule )
                    {
                        addNewObject( &( work->modList ), obj, str );
                    }
                    else
                    {
                        vpi_printf( "dumpHier: Object <%s> is not a module\n", str ); ++err;
                    }
                }
                else
                {
                    vpi_printf( "dumpHier: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            vpi_printf( "dumpHier: Non-string parameter at %d\n", index ); ++err;
        }
    }
    }
    if ( err )
    {
        vpi_printf( "dumpHier: Usage: $dumpHier( [ <module> [, ... ] ])\n" );
 
//        tf_message( ERR_ERROR, "User", "TFARG", "" );
    }
 
    tf_setworkarea( ( char* )work ); /* save flags */
}

/*
 *  PLI call function for $dumpHier
 */
void dumpHierCall( int data, int reason )
{
    p_dumpHier_arg work = ( p_dumpHier_arg )tf_getworkarea( );

    if ( work->modList )
    {
        p_object_list this = work->modList;

        for ( ; this; this = this->next )
        {
            vpi_printf( "dumpHier: Dumping hierarchy from %s\n", this->name );

            /*
             *  Trace back from the given object, printing as we go
             */
            hierTrace( 0, this->refn, 0, 0 );
        }
    }
    else
    {
        vpiHandle ptr, itr = vpi_iterate( vpiModule, 0 );

        vpi_printf( "dumpHier: Dumping hierarchy for all top-level modules\n" );

        while ( ptr = vpi_scan( itr ) )
        {
            /*
             *  Trace back from the given object, printing as we go
             */
            hierTrace( 0, ptr, 0, 0 );
        }
    }
}

// 注册函数
void register_dumpHier() { 
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$dumpHier";
    tf_data.calltf=dumpHierCall;
    tf_data.compiletf=dumpHierCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
} 

//extern void register_dumpHier();
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_dumpHier,
//  NULL /*** final entry must be 0 ***/
//};
