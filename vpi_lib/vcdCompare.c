#include "vcsuser.h"
#include "vpi_user.h"
#include <strings.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include "vpiDebug.h"

static hash_table vcdHash;
static StringList checker_list,functional_list,nostop_list;
static int flag_continue=0;
static char status_checker[10] = "Undetect";
static char status_functional[10] = "Undetect";
static char strobe_mode[10] = "Dual";
static int fault_classification( p_cb_data cb_data_p );
static void FaultClassEosHandler( p_cb_data data );
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
    int flag_stop=0; 
    /*flag control if drop this simulation at the end of time step*/
    static s_vpi_time time_s = { vpiSimTime };

    vpi_get_time( 0, &time_s );
    /*printf("Compare at%ld:%ld:\n", time_s.high, time_s.low );*/
    /*printEventList(top);*/
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
            if(!checkStringList(&nostop_list,name))flag_stop=1;
            if(checkStringList(&checker_list,name)) strcpy(status_checker, "Detect");
            if(checkStringList(&functional_list,name)) strcpy(status_functional, "Detect");
        }
        else if ( ptr->vact == 0 )
        {
            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

            char* name = node ? FullName( node->refn->refn ) : "<noname>";

            vpi_printf( "*** Missing <%s> event on <%s(%s)> at %ld:%ld\n",
                         ptr->vexp, name, ptr->mark, time_s.high, time_s.low );

            triggerOnDiff( node->refn );
            if(!checkStringList(&nostop_list,name))flag_stop=1;
            if(checkStringList(&checker_list,name)) strcpy(status_checker, "Detect");
            if(checkStringList(&functional_list,name)) strcpy(status_functional, "Detect");
        }
        else if ( strcmp( ptr->vexp, ptr->vact ) )
        {
            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

            char* name = node ? FullName( node->refn->refn ) : "<noname>";

            vpi_printf( "*** Mismatch on <%s(%s)>: exp=<%s>, act=<%s> at %ld:%ld\n",
                         name, ptr->mark, ptr->vexp, ptr->vact, time_s.high, time_s.low );
            if(!checkStringList(&nostop_list,name))flag_stop=1;
            if(checkStringList(&checker_list,name)) strcpy(status_checker, "Detect");  
            if(checkStringList(&functional_list,name)) strcpy(status_functional, "Detect");
            triggerOnDiff( node->refn );
        }
        ptr = ptr->next;
    }
    compareCallback = 0; /* clear the callback handle */

    top = ( struct event* )0; /* manhole -- fix memory leak */
    if(flag_stop&&!flag_continue){
        flag_continue = 1;
  /*      printf("Strobe Mode is %s\n",strobe_mode);
        if (strcmp(strobe_mode, "Single") == 0) printf("the classificaiton of the inject fault is :%s\n",status_checker);
        else printf("the classificaiton of the inject fault is :\nFunctional:%s,\nChecker:%s\n",status_functional,status_checker);
       */
       vpi_control(vpiStop,1);
 }

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
    initializeStringList(&checker_list);
    initializeStringList(&functional_list);
    initializeStringList(&nostop_list);
    /*parseXML("FI.xml", &checker_list);*/
    parseXML("FI.xml"); 
    printStringList(&checker_list);
    printStringList(&functional_list);
    printStringList(&nostop_list);
    hashInitialize( &vcdHash, 200 );
    addEosCallback( FaultClassEosHandler );
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

/*void parseXML(const char* filename, struct StringList* list) {*/
void parseXML(const char* filename) {
    xmlDocPtr doc;
    xmlNodePtr root, node;

    doc = xmlReadFile(filename, NULL, 0);
    if (doc == NULL) {
        fprintf(stderr, "Failed to parse XML file.\n");
        return;
    }
    root = xmlDocGetRootElement(doc);
    if (root == NULL) {
        fprintf(stderr, "Empty XML file.\n");
        xmlFreeDoc(doc);
        return;
    }
    xmlNodePtr child;
    // Traverse the XML tree to find the desired elements
    for (node = root->children; node != NULL; node = node->next) {
        if (xmlStrcmp(node->name, (const xmlChar*)"OBSERVATION_POINTS") == 0) {
            for ( child = node->children; child != NULL; child = child->next) {
                if (xmlStrcmp(child->name, (const xmlChar*)"CHECKER_STROBE") == 0) {
                    xmlChar* content = xmlNodeGetContent(child);
                    // Add the content to the string list
                    checker_list.strings[checker_list.count++] = strdup((const char*)content);
                    xmlFree(content);
                }
                else if (xmlStrcmp(child->name, (const xmlChar*)"FUNCTIONAL_STROBE") == 0) {
                    xmlChar* content = xmlNodeGetContent(child);
                    // Add the content to the string list                          
                    functional_list.strings[functional_list.count++] = strdup((const char*)content);
                    xmlFree(content);
                }
               else if (xmlStrcmp(child->name, (const xmlChar*)"NOSTOP_STROBE") == 0) {
                     xmlChar* content = xmlNodeGetContent(child);
                     // Add the content to the string list
                    nostop_list.strings[nostop_list.count++] = strdup((const char*)content);
                     xmlFree(content);
                 }
            }
        }
    }
    if (functional_list.count==0) strcpy(strobe_mode, "Single");
    xmlFreeDoc(doc);
}
static int fault_classification( p_cb_data cb_data_p )
{
    printf("Strobe Mode is %s\n",strobe_mode);
    if (strcmp(strobe_mode, "Single") == 0) printf("the classificaiton of the inject fault is :%s\n",status_checker);
    else printf("the classificaiton of the inject fault is :\nFunctional:%s,\nChecker:%s\n",status_functional,status_checker);
}

static void FaultClassEosHandler( p_cb_data data )
{
    fault_classification( data );
}