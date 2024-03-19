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

    p_dumpHier_arg work = ( p_dumpHier_arg )malloc( sizeof( s_dumpHier_arg ) );

    work->modList = ( p_object_list )0;

    work->myDummy = 0;

    for ( index = 1; index <= tf_nump( ); index++ )
    {
        if ( tf_typep( index ) == tf_string )
        {
            char* str = tf_getcstringp( index );

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
                        tf_text( "dumpHier: Object <%s> is not a module\n", str ); ++err;
                    }
                }
                else
                {
                    tf_text( "dumpHier: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            tf_text( "dumpHier: Non-string parameter at %d\n", index ); ++err;
        }
    }

    if ( err )
    {
        tf_text( "dumpHier: Usage: $dumpHier( [ <module> [, ... ] ])\n" );
 
        tf_message( ERR_ERROR, "User", "TFARG", "" );
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
