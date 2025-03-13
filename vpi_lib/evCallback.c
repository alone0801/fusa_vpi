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
extern char DUT_NAME[100];
/*
 *  Head of doubly-linked list of last seen events
 */
static p_cback_data lastEvent = ( p_cback_data )0;

p_cback_data getLastEvent( ) { return( lastEvent ); }

/*
 *  Create a user_data structure for the new callback
 */
static p_cback_data newCallbackData( vpiHandle obj ,int vact_num )
{
    p_cback_data this = ( p_cback_data )malloc( sizeof( s_cback_data ) );

    this->refn = obj;
    this->vact_num = vact_num ;
    this->last = strdup( "-" );

    this->tree = ( p_trace_node )0;

    this->dnod = ( p_vdiff_node )0;
    this->oscp = ( p_oscil_node )0;
    this->eptr = ( p_exmod_node )0;
#ifdef USE_LASTSEEN

    /* node not yet in event list */
    this->next = this;
    this->prev = this;

#endif

    return( this );
}

/*
 *  Callback for each event on tracked signals
 */
static int eventHandler( p_cb_data cb_data_p )
{
    p_cback_data this = ( p_cback_data )cb_data_p->user_data;

    if ( this == ( p_cback_data )0 )
    {
        vpi_printf( "==> Oops... ignoring NULL user data on a callback\n" ); return( 0 );
    }

    /* report the event early so the effects show up after the cause */
    //printf("_________DEBUG:%d_____________\n in eventHandler",this->vact_num);
    //printf("\nDEBUG::i==%d,name==%s in eventHandler\n",this->vact_num,FullName( this->refn ));
    DBG_EVENT(( "eventHandler: %s ( %s -> %s ) at %ld:%ld\n", FullName( this->refn ), this->last,
                                                              cb_data_p->value->value.str,
                                                              cb_data_p->time->high,
                                                              cb_data_p->time->low ));

#ifdef USE_LASTSEEN

    /* remove this node from event list... */

    this->prev->next = this->next;
    this->next->prev = this->prev;

    /* ...add it back at the top of the list... */

    if ( lastEvent )
    {
        this->prev = lastEvent->prev;
        this->next = lastEvent;

        this->prev->next = this;
        this->next->prev = this;
    }

    /* ...and call this one the "last" (ie: most recent) event */

    lastEvent = this;

#endif

    /*
     *  Call the causal tree event handler
     *    (must be called before other event handlers
     */
    if ( this->tree ) traceSignalEventHandler( this->tree, cb_data_p );

    /*
     *  Call the individual event handlers
     *    (this should eventually be a list)
     */
    if ( this->dnod ) vcdCompareEventHandler(  this->dnod, cb_data_p, this->vact_num );
    //vcdCompareEventHandler(  this->dnod, cb_data_p, this->vact_num );
    if ( this->oscp ) oscDetectEventHandler(   this->oscp, cb_data_p );
    if ( this->eptr ) extractModEventHandler(  this->eptr, cb_data_p );

    triggerOnEvent( this );

    /* save "last-known" value (freeing old value's memory) */
 
    if ( this->last ) free( this->last );
 
    this->last = strdup( cb_data_p->value->value.str );

    return( 1 );
}

/*
 *  Set a NEW callback on a net/reg
 */

vpiHandle obj_replace(vpiHandle obj, int vact_num)
{
    int i;
    vpiHandle  tb_h, dut_h;
    static vpiHandle con_obj;
    char* origin_name ;
    char* tb_name ;
    char* con_name;
    if(vact_num==1) con_obj=obj;
    else {
        origin_name = vpi_get_str(vpiFullName,obj);
        dut_h = vpi_handle_by_name(DUT_NAME,0);
        tb_h = vpi_handle(vpiScope,dut_h);
        //printf("=====origin_name==%s=======\n",origin_name);
        tb_name = vpi_get_str(vpiFullName,tb_h);
        //printf("=====tb_name==%d=======\n",vact_num-1);
        char *con_name = malloc(strlen(tb_name)+30* sizeof(char));
        sprintf(con_name,"%s.concur_%d",tb_name,vact_num-1); 
        size_t lenA = strlen(con_name);
        size_t lenB = strlen(DUT_NAME);  
        size_t lenC = strlen(origin_name); 
        size_t new_len = lenA + lenC - lenB;
        char* replace_name = (char*)malloc(new_len + 1);
        strcpy(replace_name, con_name);
        strcat(replace_name, origin_name + lenB);
        con_obj = vpi_handle_by_name(replace_name,0);
        printf("+++++++DEBUG::replace_name:%s+++++++++",replace_name);
        if(con_obj==NULL) {
            printf("ERROR:concurrent tb generate fail, please check the 'DUT_NAME' and 'TB_NAME' defined in FI.xml");
            return(0);
        }
    }
    //printf("\n==========%s===========\n",vpi_get_str(vpiFullName,con_obj));
    return(con_obj);

}


static p_cback_data newEventCallback( vpiHandle obj , int vact_num )
{
    static s_vpi_time  time_s  = { vpiSimTime };
    static s_vpi_value value_s = { vpiBinStrVal };
    s_cb_data cbData = { cbValueChange, eventHandler, 0, &time_s, &value_s };

    /* create a new database entry and store it as user_data */

    //cbData.obj = obj_replace(obj,vact_num);
    int i;
    vpiHandle con_obj , tb_h , dut_h;
    char* origin_name ;
    char* tb_name ;
    char* replace_name;
    //char* replace_name =  obj_replace(obj,vact_num);
    //printf("\n+++++DEBUG::vact_num is in newEventCallback:: %d++++++\n",vact_num);
    //printf("replace_name = %s\n",obj_replace(obj,vact_num));
    //cbData.obj = vpi_handle_by_name(replace_name,0);
    
    con_obj = obj_replace(obj,vact_num);
    //cbData.obj = obj;
    cbData.user_data = ( char* )newCallbackData( cbData.obj = con_obj , vact_num);
    //cbData.user_data = ( char* )newCallbackData(  con_obj , vact_num);
    /* ignore the callback if the node creation failed */

    if ( cbData.user_data ) vpi_register_cb( &cbData );

    DBG_CBACK(( "Callback set on %s (data=%ld)\n", FullName( obj ), cbData.user_data ));

    return( ( p_cback_data )cbData.user_data );
}

/*
 *  Check whether or not we have a callback set on this signal
 */
bool hasEventCallback( vpiHandle obj )
{
    vpiHandle cb, itr = vpi_iterate( vpiCallback, obj );

    while ( itr && ( cb = vpi_scan( itr ) ) )
    {
        s_cb_data cbData; vpi_get_cb_info( cb, &cbData );

        if ( cbData.cb_rtn == eventHandler ) return( 1 );
    }
    return( 0 );
}

/*
 *  Get user-data from an already-set callback
 */
p_cback_data getEventCallback( vpiHandle obj )
{
    vpiHandle cb, itr = vpi_iterate( vpiCallback, obj );
    while ( itr && ( cb = vpi_scan( itr ) ) )
    {
        s_cb_data cbData; vpi_get_cb_info( cb, &cbData );

        if ( cbData.cb_rtn == eventHandler )
        {
            return( ( p_cback_data )cbData.user_data );
        }
    }
    return( ( p_cback_data )0 );
}

/*
 *  Set a callback on a net/reg or return the one already there
 */
p_cback_data setEventCallback( vpiHandle obj , int vact_num)
{
    p_cback_data temp = getEventCallback( obj );
    //printf("8888888888888TEST,%s\n",vpi_get_str(vpiFullName,obj));
    //return( temp ? temp : newEventCallback( obj , vact_num) );
    return(  newEventCallback( obj , vact_num) );
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnEvent( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_EVNT ) )
    {
        causalTrace( this->tree, "onEvent" );
    }
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnDiff( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_DIFF ) )
    {
        causalTrace( this->tree, "onDiff" );
    }
}

/*
 *  This guy gets called whenever a "diff" occurs from $vcdCompare
 */
void triggerOnLoop( p_cback_data this )
{
    if ( this->tree && ( this->tree->dump & FLG_TRACE_ON_LOOP ) )
    {
        causalTrace( this->tree, "onLoop" );
    }
}
