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
 *  Indented dump of nodes in causal tree
 */
static void dumpCausalNode( int level, int time, p_trace_node this )
{
    p_trace_link link;

    char* head = makeSpace( ++level ); /* must be pre-increment */

    vpi_printf( "%s%s", head, FullName( this->refn->refn ) );

    vpi_printf( " [%s:%d]", vpi_get_str( vpiFile, this->refn->refn ),
                              vpi_get( vpiLineNo, this->refn->refn ) );

    if ( time ) vpi_printf( " (%s at %ld:%ld)", this->valu,
                                                this->t_hi,
                                                this->t_lo );

    vpi_printf( "\n" );

    /* walk the list of drivers */

    for ( link = this->back; link; link = link->next )
    {
        p_trace_node node = link->back;

        if ( node && ( node->loop == 0 ) )
        {
           node->loop = 1; dumpCausalNode( level, time, node ); node->loop = 0;
        }
    }
}

void dumpCausalTree( int time, p_trace_node this )
{
    vpi_printf( "Causal tree for %s\n", FullName( this->refn->refn ) );

    if ( this ) dumpCausalNode( 0, time, this );
}

/*
 *  PLI instance data for $causalTree
 */
typedef struct t_causalTree_arg
{
  int           myDummy;
  p_object_list sigList;

} s_causalTree_arg, *p_causalTree_arg;

/*
 *  PLI check function for $causalTree
 */
void causalTreeCheck( int data, int reason )
{
    int index, err = 0;

    p_causalTree_arg this = ( p_causalTree_arg )malloc( sizeof( s_causalTree_arg ) );

    this->sigList = ( p_object_list )0;

    this->myDummy = 0;

    for ( index = 1; index <= tf_nump( ); index++ )
    {
//        if ( tf_typep( index ) == tf_string )
        vpiHandle obj = vpi_iterate(vpiArgument, tf_ithandle(index));
        if(obj)
        {
//            char* str = tf_getcstringp( index );
            char* str = vpi_get_str(vpiName, obj);

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
                    vpi_printf( "causalTree: Unable to find object <%s>\n", str ); ++err;
                }
            }
        }
        else
        {
            vpi_printf( "causalTree: Non-string parameter at %d\n", index ); ++err;
        }
    }

    /*
     *  We need to see at least one signal
     */
    if ( this->sigList == ( p_object_list )0 )
    {
        vpi_printf( "causalTree: No signals specified\n" ); ++err;
    }
 
    if ( err )
    {
        vpi_printf( "causalTree: Usage: $causalTree( <signal> [, ... ])\n" );
 
//        vpi_error( ERR_ERROR, "User", "TFARG", "" );
    }

    tf_setworkarea( ( char* )this ); /* save flags */
}

/*
 *  PLI call function for $causalTree
 */
void causalTreeCall( int data, int reason )
{
    p_causalTree_arg work = ( p_causalTree_arg )tf_getworkarea( );

    p_object_list this = work->sigList;

    for ( ; this; this = this->next )
    {
        vpi_printf( "causalTree: Dumping hierarchy from %s\n", this->name );

        generateCausalTree( this->refn ); dumpCausalTree( 0, getEventCallback( this->refn )->tree );
    }
}

// 注册函数
void register_causalTree() { 
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$casusalTree";
    tf_data.calltf=causalTreeCall;
    tf_data.compiletf=causalTreeCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data); 
} 


//extern void register_causalTree();
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_causalTree,
//  NULL /*** final entry must be 0 ***/
//};
