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
 *  Limitations:
 *
 *  1) Only the final values of each signal are compared. Glitch
 *     mismatches are ignored. One could conceive of an algorithm
 *     to compare trace histories within a single time step but
 *     that was considered beyond the scope of this simple test.
 *
 *  2) Differences in optimization can cause mismatches to be missed.
 *     For example, if two signals were combined in the reference run
 *     (and thus were assigned the same identifier tag in the VCD
 *     file), the corresponding signals in the present simulation are
 *     compared with the VCD only once. If they happen to differ in
 *     value at any point during the simulation, whichever happens
 *     last in sequence will be compared against the recorded VCD
 *     value and the other signals's mismatch will be missed.
 *
 *     Ideally, we would check to make sure the real events come from
 *     the same object but that may not be feasible on-the-fly.
 *
 *  3) For now, the initial values of the signals (those inside the
 *     $dumpvars block in the VCD) are not compared. These are nearly
 *     always "X" anyway.
 *
 *  4) The $vcdCompare task assumes it is run at time zero. If this is
 *     not the case, the "expired" VCD chaff from the file should be
 *     discarded (keeping a table of last-known values) and the current
 *     value of each signal should be verified.
 *
 *  5) Only single-bit signals are compared. Vectors might require
 *     more work, since the real-time object may not be available as
 *     a vector from VPI (if it is, the values can be compared as
 *     strings, just like the single-bit values).
 */

#include "vcsuser.h"
#include "vpi_user.h"
#include <strings.h>

#include "vpiDebug.h"

static hash_table vcdHash;

/*
 *  Create a new vdiff_node (addendum to callback data structures)
 */
p_vdiff_node newVdiffNode( p_cback_data refn, char* mark )
{
    p_vdiff_node this = ( p_vdiff_node )malloc( sizeof( s_vdiff_node ) );

    this->refn = refn;
    this->mark = strdup( mark );

    return( this );
}

/*
 *  Queue of expected/actual events
 */
struct event
{
    char*         mark;
    char*         vexp;
    char*         vact;
    struct event* next;
};

void printEventList(struct event* head) {
    struct event* current = head;

    while (current != NULL) {
        printf("Mark: %s, Vexp: %s, Vact: %s\n", current->mark, current->vexp, current->vact);
        current = current->next;
    }
}

static struct event* top = ( struct event* )0;

static struct event* createNewEvent( char* mark, char* vexp, char* vact )
{
    struct event* ptr = ( struct event* )malloc( sizeof( struct event ) );

    ptr->mark = mark;
    ptr->vexp = vexp;
    ptr->vact = vact;
    ptr->next = top; 

    return( top = ptr );
}

static struct event* expectedEvent( char* mark, char* valu )
{
    struct event* ptr = top;

    while ( ptr )
    {
        if ( strcmp( mark, ptr->mark ) == 0 )
        {
            if ( ptr->vexp ) free( ptr->vexp );

            ptr->vexp = strdup( valu ); return( ptr );
        }
        ptr = ptr->next;
    }
    return( createNewEvent( strdup( mark ), strdup( valu ), ( char* )0 ) );
}

static struct event* actualEvent( char* mark, char* valu )
{
    struct event* ptr = top;

    while ( ptr )
    {
        if ( strcmp( mark, ptr->mark ) == 0 )
        {
            if ( ptr->vact ) free( ptr->vact );

            ptr->vact = strdup( valu ); return( ptr );
        }
        ptr = ptr->next;
    }
  /*  printf("Value of valu: %s\n", mark);
    printf("Value of valu: %s\n", valu); */
    return( createNewEvent( strdup( mark ), ( char* )0, strdup( valu ) ) );
}

/*
 *  Callback to compare events after each time step
 *   (save/clear callback handle to prevent multiple callbacks)
 */
static vpiHandle compareCallback = 0;

static int compareHandler( p_cb_data cb_data_p )
{
    struct event* ptr = top;

    static s_vpi_time time_s = { vpiSimTime };

    vpi_get_time( 0, &time_s );
    printf("Compare at%ld:%ld:\n", time_s.high, time_s.low );
    printEventList(top);
    DBG_VDIFF(( "Compare at %ld:%ld:\n", time_s.high, time_s.low ));

    while ( ptr )
    {
        DBG_VDIFF(( "=> mark=%s, exp=%s, act=%s\n", ptr->mark ? ptr->mark : "<null>",
                                                    ptr->vexp ? ptr->vexp : "<null>",
                                                    ptr->vact ? ptr->vact : "<null>" ));

        if ( ptr->vexp == 0 )
        {
            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

            char* name = node ? FullName( node->refn->refn ) : "<noname>";

            vpi_printf( "*** Unexpected <%s> event on <%s(%s)> at %ld:%ld\n",
                         ptr->vact, name, ptr->mark, time_s.high, time_s.low );

            triggerOnDiff( node->refn );
        }
        else if ( ptr->vact == 0 )
        {
            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

            char* name = node ? FullName( node->refn->refn ) : "<noname>";

            vpi_printf( "*** Missing <%s> event on <%s(%s)> at %ld:%ld\n",
                         ptr->vexp, name, ptr->mark, time_s.high, time_s.low );

            triggerOnDiff( node->refn );
        }
        else if ( strcmp( ptr->vexp, ptr->vact ) )
        {
            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

            char* name = node ? FullName( node->refn->refn ) : "<noname>";

            vpi_printf( "*** Mismatch on <%s(%s)>: exp=<%s>, act=<%s> at %ld:%ld\n",
                         name, ptr->mark, ptr->vexp, ptr->vact, time_s.high, time_s.low );

            triggerOnDiff( node->refn );
        }
        ptr = ptr->next;
    }
    compareCallback = 0; /* clear the callback handle */

    top = ( struct event* )0; /* manhole -- fix memory leak */
}

static void setCompareCallback( struct event* ptr )
{
    if ( ptr && ( compareCallback == 0 ) )
    {
        static s_vpi_time time_s = { vpiSimTime };

        s_cb_data callbackData = { cbReadOnlySynch, compareHandler, 0, &time_s, 0 };

        callbackData.time->high = 0;
        callbackData.time->low  = 0; /* set callback to NOW */

        callbackData.user_data = ( char* )0;

        compareCallback = vpi_register_cb( &callbackData );
    }
}

static void processVcd( void* );

/*
 *  Callback for each simulation time change (VCD driven)
 */
static int timeHandler( p_cb_data cb_data_p )
{

    DBG_VDIFF(( "Wakeup: %ld:%ld\n", cb_data_p->time->high, cb_data_p->time->low ));

    /*
     *  When the time expires, we resume processing the VCD
     */
    processVcd( ( void* )cb_data_p->user_data );
}

static void setTimeCallback( long time, void* ptr )
{
    static s_vpi_time time_s = { vpiSimTime };

    s_cb_data callbackData = { cbAtStartOfSimTime, timeHandler, 0, &time_s, 0 };

    callbackData.time->high = 0;
    callbackData.time->low  = time;

    callbackData.user_data = ( char* )ptr; /* VCD handle */

    DBG_VDIFF(( "Next wakeup call at %ld:%ld\n", callbackData.time->high,
                                                 callbackData.time->low ));

    vpi_register_cb( &callbackData );
}

/*
 *  Callback for each event on tracked signals
 */
int vcdCompareEventHandler( p_vdiff_node this, p_cb_data cb_data_p )
{
    DBG_VDIFF(( "Event: <%s> = %s\n", this->mark, cb_data_p->value->value.str ));

    setCompareCallback( actualEvent( this->mark, cb_data_p->value->value.str ) );
}

/*
 *  VCD reader "callbacks" to "register" scopes and signals
 */
static vpiHandle scope;

void foundScope( char* name, char* type, char* path )
{
    scope = vpi_handle_by_name( path, 0 );
}

void foundSignal( char* name, char* type, long size, char* mark )
{
    p_cback_data node = setEventCallback( vpi_handle_by_name( name, scope ) );
 
    node->dnod = newVdiffNode( node, mark );

    /* also enter the VCD hash code into a lookup table */

   /* hashInsert( mark, ( void* )( node->dnod ), &vcdHash );*/
       p_vdiff_node hashreturn = hashInsert( mark, ( void* )( node->dnod ), &vcdHash );
    if(hashreturn) {fprintf(stderr,"strobe config error: %s and %s here are points with Equivalence\n",FullName(hashreturn->refn->refn),name);
    exit(1);}
}

/*
 *  Main VCD processing loop
 *
 *  This routine is called to "kick-off" the comparison. We read expected
 *  data records one by one and store them in a list. If one or more such
 *  records is read, we also set a callback for the end of that time step.
 *  When we encounter a time advance record (#), we then set a wakeup for
 *  that time and cease processing the VCD file.
 *
 *  As the simulation continues, actual events are logged in the same list.
 *  At the end of the surrent timestep, the list is scanned and diffs are
 *  reported. We then continue to the next wakeup event (any actual events
 *  that may occur along the way are also flagged as diffs).
 */
static void processVcd( void* ptr )
{
    while ( ptr )
    {
        char* str = readVcdLine( ptr );

        if ( str == 0 ) break; /* no more VCD file */

        if ( strcmp( str, "$dumpvars" ) == 0 )
        {
            /*
             *  If we see "$dumpvars", we should process every value
             *  by checking it against the static values of the signals
             *  to which the entries correspond. Since we don't keep
             *  a table of signal tags, this is skipped for now.
             */
           /* while ( strcmp( str, "$end" ) ) str = readVcdLine( ptr );*/
            readVcdLine( ptr );
            while ( strcmp( str, "$end" ) ){
                char *valu = (char *)malloc(strlen(str) + 1);
                char *spacePos = strchr(str, ' ');
                if (spacePos != NULL) {
                    *spacePos = '\0';
                    strcpy(valu, str+1); /*value = bxx*/
                    setCompareCallback(expectedEvent(spacePos + 1, valu));
                } else {
                    *valu = *str;
                    valu[1] = '\0';
                    DBG_VDIFF(("Expect: %s = %s\n", str, valu));

                    setCompareCallback(expectedEvent(str+1, valu));
            }
            readVcdLine( ptr );
            }
        } 
        else if ( *str == '#' )
        {
            /*
             *  If we see a time marker, we set a wakeup-call for that
             *  time and suspend processing the VCD file. Events that
             *  happen before this time must be mismatches.
             */
           /*  printEventList(top);*/
            if ( atol( str + 1 ) ) { setTimeCallback( atol( ++str ), ptr ); return; }
        }
        else /* assume single-bit change record */
        {
        /*    char valu[ ] = " "; valu[ 0 ] = *( str++ );

            DBG_VDIFF(( "Expect: %s = %s\n", str, valu ));

            setCompareCallback( expectedEvent( str, valu ) );*/
                        /*char valu[ ] = " ";*/
            char *valu = (char *)malloc(strlen(str) + 1);
            char *spacePos = strchr(str, ' ');
            if (spacePos != NULL) {
                *spacePos = '\0';
                strcpy(valu, str+1); /*value = bxx*/
                setCompareCallback(expectedEvent(spacePos + 1, valu));
            } else {
                *valu = *str;
                valu[1] = '\0';
                DBG_VDIFF(("Expect: %s = %s\n", str, valu));

                setCompareCallback(expectedEvent(str+1, valu));
            }
        }
    }
}

/*
 *  Callback for end of simulation
 */
static void vcdCompareEosHandler( p_cb_data data )
{
    compareHandler( data );
}

/*
 *  PLI check function for $vcdCompare
 */
void vcdCompareCheck( )
{
    if ( tf_nump( ) == 1 )
    {
        if ( tf_typep( 1 ) == tf_string ) return;

        tf_error( "Error: Non-string parameter\n" );
    }
    else
    {
        tf_error( "Error: Use only one parameter\n" );
    }
}

/*
 *  PLI call function for $vcdCompare
 */
void vcdCompareCall( )
{
    char* filename = tf_getcstringp( 1 );

    vpi_printf( "vcdCompare: reading <%s>\n", filename );

    hashInitialize( &vcdHash, 200 );

    addEosCallback( vcdCompareEosHandler );

    processVcd( readVcdHeader( filename ) );
}

/*
 *  PLI misc function for $vcdCompare
 */
void vcdCompareMisc( int data, int reason )
{
    if ( reason == reason_finish ) dummyEosHandler( );
}
