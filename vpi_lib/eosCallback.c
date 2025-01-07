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
#include "vpi_user.h"
/*
 *  List of end-of-simulation callback handlers
 */
typedef struct t_cback_func
{
    void             ( * func )( p_cb_data );
    struct t_cback_func* next;

} s_cback_func, *p_cback_func;

static p_cback_func cbackRoot = ( p_cback_func )0;

static void newEosCallback( void ( *func )( p_cb_data ) )
{
    p_cback_func this = ( p_cback_func )malloc( sizeof( s_cback_func ) );

    this->func = func; this->next = cbackRoot; cbackRoot = this;
}

/*
 *  Callback for end-of-simulation
 */
static int eosHandler( p_cb_data cb_data_p )
{
    if ( cbackRoot )
    {
        DBG_EVENT(( "eosHandler: calling end-of-simulation functions\n" ));

        for ( ; cbackRoot; cbackRoot = cbackRoot->next )
        {
            if ( cbackRoot->func ) ( *( cbackRoot->func ) )( cb_data_p );
        }
    }
    return( 1 );
}

/*
 *  Set end-of-simulation callback
 */
static int eosCallbackFlag = 1;

static void setEosCallback( )
{
    if ( eosCallbackFlag )
    {
        static s_vpi_time  time_s  = { vpiSimTime };
        static s_vpi_value value_s = { vpiSuppressVal };

        s_cb_data cbData = { cbEndOfSimulation, eosHandler, 0, &time_s, &value_s };

        vpi_register_cb( &cbData );

        DBG_CBACK(( "End-of-simulation callback set\n" ));
    }

    eosCallbackFlag = 0; /* prevent repetition (VPI workaround) */
}

/*
 *  Add a NEW end-of-simulation callback target
 */
void addEosCallback( void ( *cbFunction )( p_cb_data ) )
{
    p_cback_func cback;

    for ( cback = cbackRoot; cback; cback = cback->next )
    {
        if ( cback->func == cbFunction ) return;  /* reject duplicates */ 
    }

    /* add the callback and make sure the end-of-simulation callback is set */

    newEosCallback( cbFunction ); setEosCallback( );
}

void dummyEosHandler( ) { p_cb_data dummyData; eosHandler( dummyData ); }

void register_eosCallback(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$eosCallback";
    tf_data.calltf=addEosCallback;
    tf_data.compiletf=NULL;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}
//extern void register_eosCallback();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_eosCallback,
//  NULL /*** final entry must be 0 ***/
//};
