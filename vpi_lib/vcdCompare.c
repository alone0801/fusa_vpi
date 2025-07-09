#include "veriuser.h"
#include "vxl_veriuser.h"
#include "vpi_user.h"
#include <strings.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include "vpiDebug.h"
#include <stdlib.h>
#include"fault_injector.h"
#include"meminit.h"
extern int num_lines ;
static hash_table vcdHash;
static hash_table lexpHash;// store last exp for given mark
static StringList checker_list,functional_list,nostop_list,fault_target,fault_exclude,fault_tw_str;
static PortInfoNode* port_list = NULL;
static Module* iso_inst_list = NULL;
static int fault_tw[2];
static int fault_type; /////////////ADDED
static int flag_continue=0;
static int flag_checker=0;
static int flag_functional=0;
static int last_time = 0;
//static char fault_target[100];
static char* fault_type_str; //////////ADDED
static int set_hold_time;
static char iso_mode[20];
char DUT_NAME[100];
static int  CON_NUM = 1;  // default==1 
//static char status_checker[10] = "Undetect";
//static char status_functimefonal[10] = "Undetect";
//static char status_checker[10][CON_NUM] = "Undetect";
static struct Fault *fault_array = NULL;
//char (*status_checker)[10] = NULL;
//char (*status_functional)[10] = NULL;
char **status_checker=NULL;
char **status_functional=NULL;
static char strobe_mode[10] = "Dual";
static char FAULT_ID[100];
static char FAULT_LOCATION[200];
static char FAULT_TYPE[10];
static char FAULT_TIME[100];
static char SET_RETURN_TIME[100];   ///////ADDED
static char CHECKER_TIME[100]="NULL";
static char FUNCTIONAL_TIME[100]="NULL";
static int tolerant_time = 10;
static int fault_classification( p_cb_data cb_data_p );
static void FaultClassEosHandler( p_cb_data data );
void parse_injectXML(const char* filename);
void SAInject(const char* fault_location, const char* fault_time, const char* fault_typeo);
void generateXML(const char* idValue, const char* locationValue, const char** statusValue,const char* typeValue, int vact_num);
void fault_injector_check(struct Fault *fault_p,int vact_num);
void fault_modeling_check(StringList* fault_target,StringList* fault_exclude, int fault_tw[],int fault_type_local,int set_hold_time_local);             ///////////////////////////////////ADDED
void _check(StringList* fault_target,StringList* fault_exclude, int fault_tw[]);
void value_get(const char* fault_location);
static int timeoutHandler( p_cb_data cb_data_p );
void freeStringList(StringList *list);
vpiHandle cur_replace(vpiHandle obj, int vact_num);

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
    char**        vact;
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
//vpiHandle obj_replace(vpiHandle obj, int vact_num)
static struct event* createNewEvent( char* mark, char* vexp, char* vact, int vact_count)
{
    struct event* ptr = ( struct event* )malloc( sizeof( struct event ) );
    int i;
    ptr->mark = mark;
    ptr->vexp = vexp;
    //ptr->vact = vact;
    ptr->vact = (char**)malloc((CON_NUM+1) * sizeof(char*));
    ptr->next = top;
    for (i = 0; i < CON_NUM+1; i++) {
        ptr->vact[i] = (char*)0;
    }
    //printf("\nDEBUG::CON_NUM==%d,i==%d in createNewEvent\n",CON_NUM,vact_count);
    if (vact != NULL)ptr->vact[vact_count] = vact;
    else ptr->vact[vact_count] = vact;
    return( top = ptr );
}

static struct event* expectedEvent( char* mark, char* valu )
{
    struct event* ptr = top;
    while ( ptr )
    {
        if ( strcmp( mark, ptr->mark ) == 0 )
        {
            if ( ptr->vexp ){
                free( ptr->vexp );
            }
            ptr->vexp = strdup( valu ); return( ptr );
        }
        ptr = ptr->next;
    }
    return( createNewEvent( strdup( mark ), strdup( valu ), ( char* )0 , 0) );
}

static struct event* actualEvent( char* mark, char* valu , int vact_count)
{
    struct event* ptr = top;
    //printf("\nDEBUG::CON_NUM==%d,i==%d in actualEvent\n",CON_NUM,vact_count);
    while ( ptr )
    {
        if ( strcmp( mark, ptr->mark ) == 0 )
        {
            //printf("\nDEBUG::CON_NUM==%d,i==%d\n",CON_NUM,vact_count);
            if ( ptr->vact[vact_count] ) free( ptr->vact[vact_count] );

            ptr->vact[vact_count] =  strdup(valu) ;
            //printf("Value of valu: %s\n", valu);
            return( ptr );
        }
        ptr = ptr->next;
    }
    //printf("Value of valu: %s\n", mark);
    //printf("Value of valu: %s\n", valu);
    return( createNewEvent( strdup( mark ), ( char* )0, strdup( valu ), vact_count) );
}

/*
 *  Callback to compare events after each time step
 *   (save/clear callback handle to prevent multiple callbacks)
 */

typedef struct t_BoolArray
{
    char *data;
    size_t capacity;
} s_BoolArray, *p_BoolArray;

void BoolArray_init(s_BoolArray *arr, size_t initial_capacity) {
    arr->data = (char *)malloc(initial_capacity * sizeof(char));
    if (!arr->data) {
        printf("malloc failed\n");
        return;
    }

    arr->capacity = initial_capacity;
    memset(arr->data, 0, initial_capacity); // 初始化为 0（false）
}

// 释放内存
void BoolArray_free(s_BoolArray *arr) {
    free(arr->data);
    arr->data = NULL;
    arr->capacity = 0;
}

bool compare(const char *a, const char *b) {
    int len_a = strlen(a);
    int len_b = strlen(b);
    int i;
    // 只比较右边对齐的最小长度部分
    int min_len = (len_a < len_b) ? len_a : len_b;

    // 从两串的末尾向前比较
    for (i = 1; i <= min_len; ++i) {
        if (a[len_a-i] != b[len_b-i])
            return false;
    }
    if(min_len == len_a){
        for (i = 0 ; i < len_b-len_a; ++i){
            if(b[i] == '1')
                return false;
        }
    }
    else{
        for (i = 0 ; i < len_a-len_b; ++i){
            if(a[i] == '1')
                return false;
        }
    }
    return true;
}

static vpiHandle compareCallback = 0;
static s_BoolArray con_stop = {NULL, 0};
static int compareHandler( p_cb_data cb_data_p )    /*compare the event at the end of time step */
{
    struct event* ptr = top;
    int flag_stop=1; 
    int i;
    if(con_stop.data == NULL){
        BoolArray_init(&con_stop, CON_NUM+1);
    }
    /*flag control if drop this simulation at the end of time step*/
    vpiHandle systf = vpi_handle(vpiSysTfCall, NULL);
    static s_vpi_time time_s = { vpiScaledRealTime,{0} };
    static s_vpi_time time_int = { vpiSimTime ,{0}};
    vpi_get_time(systf, &time_int );
    vpi_get_time(systf, &time_s );
/*    printf("Compare at%ld:%ld:\n", time_s.high, time_s.low );
    printEventList(top);
    DBG_VDIFF(( "Compare at %ld:%ld:\n", time_s.high, time_s.low ));
*/
    while ( ptr )
    {
        if ( ptr->vexp == 0 ) // no expected event at this time step , because or it won't be "0" for char*
        {
            char* lexp;
            lexp = (char*)lookup( ptr->mark, &lexpHash);
            for(i=0 ; i<CON_NUM+1 ; i++){
                if(con_stop.data[i]) continue;
                if(ptr->vact[i] != 0){
                    if((lexp != NULL) && (compare(lexp, ptr->vact[i]))) continue;
                    p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );
                    char* name = node ? FullName( node->refn->refn ) : "<noname>";
                    if(i==0) vpi_printf( "*** DUT:: Unexpected <%s> event on <%s(%s)> at %lf\n",
                         ptr->vact[i], name, ptr->mark,  time_s.real );
                    else vpi_printf( "*** CON_%d:: Unexpected <%s> event on <%s(%s)> at %lf\n",
                         i, ptr->vact[i], name, ptr->mark, time_s.real );
                    if(!checkStringList(&nostop_list,name)){
                        con_stop.data[i] = 1;
                    }
                    if(checkStringList(&checker_list,name)) {
                        if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
                        flag_checker=1;
                        strcpy(status_checker[i], "Detect");
                    }
                    if(checkStringList(&functional_list,name)) {
                        if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
                        flag_functional=1;
                        strcpy(status_functional[i], "Detect");
                    }

                }
            }
//            p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );
//
//            char* name = node ? FullName( node->refn->refn ) : "<noname>";
//
//            vpi_printf( "*** Unexpected <%s> event on <%s(%s)> at %ld:%ld\n",
//                         ptr->vact, name, ptr->mark, time_int.high, time_int.low );
//            //vpi_printf( "*** Unexpected <%s> event on <%s(%s)> at %lf\n",
//            //             ptr->vact, name, ptr->mark, time_s.real );
//
//            triggerOnDiff( node->refn );
////            if(!checkStringList(&nostop_list,name))flag_stop=1;
////            if(checkStringList(&checker_list,name)) strcpy(status_checker, "Detect");
////            if(checkStringList(&functional_list,name)) strcpy(status_functional, "Detect");
//            if(!checkStringList(&nostop_list,name))flag_stop=1;
//            if(checkStringList(&checker_list,name)) {
//                if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
//                flag_checker=1;
//                strcpy(status_checker, "Detect");
//            }
//            if(checkStringList(&functional_list,name)) {
//                if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
//                flag_functional=1;
//                strcpy(status_functional, "Detect");
//            }
        }
        else {
            hashInsert(ptr->mark, ptr->vexp, &lexpHash);
            //vpi_printf("compare%d, %d\n",atoi(ptr->vexp),atoi(ptr->vact[0]));
            for(i=0;i<CON_NUM+1 ;i++){
                if(con_stop.data[i]) continue;
                if ( ptr->vact[i] == 0 ){
                    p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );
                    char* name = node ? FullName( node->refn->refn ) : "<noname>";
                    if(i==0) vpi_printf( "*** DUT::Missing <%s> event on <%s(%s)> at %lf\n",
                                 ptr->vexp, name, ptr->mark, time_s.real );

                    else vpi_printf( "*** CON_%d::Missing <%s> event on <%s(%s)> at %lf\n",
                                 i,ptr->vexp, name, ptr->mark, time_s.real );
                    triggerOnDiff( node->refn );
                    if(!checkStringList(&nostop_list,name)){
                        con_stop.data[i]=1;
                    }
                    if(checkStringList(&checker_list,name)) {
                        if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
                        flag_checker=1;
                        strcpy(status_checker[i], "Detect");
                    }
                    if(checkStringList(&functional_list,name)) {
                        if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
                        flag_functional=1;
                        strcpy(status_functional[i], "Detect");
                    }
                }
                else if(!compare(ptr->vexp, ptr->vact[i])){
                    p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );
                    char* name = node ? FullName(node->refn->refn) : "<noname>";
                    if(i==0) vpi_printf( "*** DUT:: Mismatch on <%s(%s)>: exp=<%s>, act=<%s> at %lf\n",
                                  name, ptr->mark, ptr->vexp, ptr->vact[i], time_s.real );
                    else vpi_printf( "*** CON_%d:: Mismatch on <%s(%s)>: exp=<%s>, act=<%s> at %lf\n",
                                 i, name, ptr->mark, ptr->vexp, ptr->vact[i], time_s.real );
                    //printf("%s\n",name);
                    if(!checkStringList(&nostop_list,name)){
                        con_stop.data[i]=1;
                    }
                    if(checkStringList(&checker_list,name)) {
                        if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
                        flag_checker=1;
                        strcpy(status_checker[i], "Detect");
                        //printf("%s\n",status_checker[i]);
                        }
                    if(checkStringList(&functional_list,name)) {
                        if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
                        flag_functional=1;
                        strcpy(status_functional[i], "Detect");
                        //printf("%s\n",status_functional[i]);
                    }
                }
            }//for end
        }
        //else if ( ptr->vact == 0 )
        //{
        //    p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

        //    char* name = node ? FullName( node->refn->refn ) : "<noname>";

        //    vpi_printf( "*** Missing <%s> event on <%s(%s)> at %lf\n",
        //                 ptr->vexp, name, ptr->mark, time_s.real );

        //    triggerOnDiff( node->refn );
        //    if(!checkStringList(&nostop_list,name))flag_stop=1;
        //    if(checkStringList(&checker_list,name)) {
        //        if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
        //        flag_checker=1;
        //        strcpy(status_checker, "Detect");
        //    }
        //    if(checkStringList(&functional_list,name)) {
        //        if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
        //        flag_functional=1;
        //        strcpy(status_functional, "Detect");
        //    }
        //}
        //else if ( strcmp( ptr->vexp, ptr->vact ) )
        //{
        //    p_vdiff_node node = ( p_vdiff_node )lookup( ptr->mark, &vcdHash );

        //    char* name = node ? FullName( node->refn->refn ) : "<noname>";

        //    vpi_printf( "*** Mismatch on <%s(%s)>: exp=<%s>, act=<%s> at %lf\n",
        //                 name, ptr->mark, ptr->vexp, ptr->vact, time_s.real );

        //    if(checkStringList(&checker_list,name)) {
        //        if(!flag_checker) sprintf(CHECKER_TIME, "%lf", time_s.real);
        //        flag_checker=1;
        //        strcpy(status_checker, "Detect");
        //    }
        //    if(checkStringList(&functional_list,name)) {
        //        if(!flag_functional) sprintf(FUNCTIONAL_TIME, "%lf", time_s.real);
        //        flag_functional=1;
        //        strcpy(status_functional, "Detect");
        //    }

        //    triggerOnDiff( node->refn );
        //}
        ptr = ptr->next;
    }
    compareCallback = 0; /* clear the callback handle */

    top = ( struct event* )0; /* manhole -- fix memory leak */
    for(i = 0; i < con_stop.capacity ; i++)
        if(!con_stop.data[i]) flag_stop = 0;
    if(flag_stop&&!flag_continue){
        flag_continue = 1;
  /*      printf("Strobe Mode is %s\n",strobe_mode);
        if (strcmp(strobe_mode, "Single") == 0) printf("the classificaiton of the inject fault is :%s\n",status_checker);
        else printf("the classificaiton of the inject fault is :\nFunctional:%s,\nChecker:%s\n",status_functional,status_checker);
       */
        freeStringList(&fault_target);
        freeStringList(&fault_exclude);
        freeStringList(&fault_tw_str);
        freeStringList(&checker_list);
        freeStringList(&functional_list);
        freeStringList(&nostop_list);
        BoolArray_free(&con_stop);
        vpi_control(vpiStop,1);
        //vpi_control(vpiFinish,1);

        return(0);

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

static void setTimeCallback( int time, void* ptr )
{   
    uint64_t time_64 = (uint64_t) time;
    uint32_t high = (uint32_t)(time_64 >> 32)&(0xFFFFFFFFFFFFFFFF);
    uint32_t low = (uint32_t)(time_64 & 0xFFFFFFFF);
    //static s_vpi_time time_s = { vpiScaledRealTime };
    static s_vpi_time time_s = { vpiSimTime };
   // s_cb_data callbackData = { cbAtStartOfSimTime, timeHandler, 0, &time_s, 0 };

    s_cb_data callbackData = { cbAtStartOfSimTime, timeHandler, 0, &time_s, 0 };

    callbackData.time->high = high;
    callbackData.time->low  = low;
  //  callbackData.time->real  = time;
    //vpi_printf("++++++DEBUG:TIMEHANDLER_TIME:%d:%d++++++++++++++\n",callbackData.time->high,callbackData.time->low);
    callbackData.user_data = ( char* )ptr; /* VCD handle */

    //DBG_VDIFF(( "Next wakeup call at %lf\n", callbackData.time->real));

    vpi_register_cb( &callbackData );
}

/*
 *  Callback for each event on tracked signals
 */
int vcdCompareEventHandler( p_vdiff_node this, p_cb_data cb_data_p ,int vact_count )
{
    int i;
    DBG_VDIFF(( "Event: <%s> = %s\n", this->mark, cb_data_p->value->value.str ));
    //printf("ACTEVENT: <%s> = %s\n", this->mark, cb_data_p->value->value.str );
    //for(i=0;i<CON_NUM;i++)setCompareCallback( actualEvent( this->mark, cb_data_p->value->value.str, i ) );
    
    //vpi_printf("\nDEBUG::CON_NUM==%d,i==%d in vcdCompareEventHandler, mark:%s, value:%s\n",CON_NUM,vact_count,this->mark,cb_data_p->value->value.str);
    setCompareCallback( actualEvent( this->mark, cb_data_p->value->value.str,  vact_count ) );
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
    int i;
    //vpi_printf("&&&&&&CON_NUM==%d,name==%s&&&&&&&&&&&\n",CON_NUM,name);
    vpiHandle obj = vpi_handle_by_name( name, scope );
    p_cback_data node = setEventCallback( obj, 0 );

    node->dnod = newVdiffNode( node, mark );

    /* also enter the VCD hash code into a lookup table */

   /* hashInsert( mark, ( void* )( node->dnod ), &vcdHash );*/
    p_vdiff_node hashreturn = hashInsert( mark, ( void* )( node->dnod ), &vcdHash );
    if(hashreturn) {fprintf(stderr,"strobe config error: %s and %s here are points with Equivalence\n",FullName(hashreturn->refn->refn),name);
    exit(1);}

    if(CON_NUM>0){
        for(i=1;i<CON_NUM+1;i++) {
            //printf("\n+++++++++i==%d,name==%s+++++++++\n",i,name);
            p_cback_data node = setEventCallback( obj, i );
            node->dnod = newVdiffNode( node, mark );
        }
       
    }
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
    int i;
   
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
           vpi_printf("\n 0ns bgein here to read vcd\n");
            readVcdLine( ptr );
            while ( strcmp( str, "$end" ) ){
                //printf("%s\n",str);
                char *valu = (char *)malloc(strlen(str) + 1);
                char *spacePos = strchr(str, ' ');
                if (spacePos != NULL) {
                    *spacePos = '\0';   /*this branch to deal with vetocr */
                    strcpy(valu, str+1); /*value = bxx*/
                    //printf("EXPECTEVENT: <%s> = %s\n", str, valu );
                    setCompareCallback(expectedEvent(spacePos + 1, valu));
                    for(i=0;i<CON_NUM+1;i++) setCompareCallback(actualEvent(spacePos+1, valu, i));
                    //setCompareCallback(actualEvent(spacePos + 1, valu)); /*fix the bug of obeserver point X at 0*/
                } else {
                    *valu = *str;
                    valu[1] = '\0';
                    //printf("EXPECTEVENT: <%s> = %s\n", str, valu );
                    setCompareCallback(expectedEvent(str+1, valu));
                    for(i=0;i<CON_NUM+1;i++) setCompareCallback(actualEvent(str+1, valu, i));
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
            if ( atol( str + 1 ) )
            {
                str = str + 1;
                //vpi_printf("%d - %d \n",atoi(str),last_time);
                setTimeCallback(atol(str), ptr );
                //vpi_printf("2:%d\n",last_time);
                return; 
            }
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
    //char* path = tf_getcstringp( 1 ); //irun doesn't support this function
    //char* step = tf_getcstringp( 2 );
    vpiHandle systf_h, arg_itr, arg_h;
    s_vpi_value value_s;
    char FI_PATH[100];
    char FS_PATH[100];
    systf_h = vpi_handle(vpiSysTfCall, NULL);
    arg_itr = vpi_iterate(vpiArgument, systf_h);
    arg_h = vpi_scan(arg_itr);
    value_s.format = vpiStringVal;
    vpi_get_value(arg_h, &value_s);
    strcpy(FI_PATH, value_s.value.str);
    strcpy(FS_PATH, value_s.value.str);
    arg_h = vpi_scan(arg_itr);
    vpi_get_value(arg_h, &value_s);
    strcat(FI_PATH,"/FI.xml");
    strcat(FS_PATH,"/fault.set");
    vpi_free_object(arg_itr); /* free iterator -- did not scan to null */
    initializeStringList(&fault_target);
    initializeStringList(&fault_exclude);
    initializeStringList(&fault_tw_str);
    initializeStringList(&checker_list);
    initializeStringList(&functional_list);
    initializeStringList(&nostop_list);
    parseXML(FI_PATH);
    fault_type = atoi(fault_type_str); ////ADDED
    fault_tw[0] = atoi(fault_tw_str.strings[0]);
    fault_tw[1] = atoi(fault_tw_str.strings[1]);
    if (strcmp(value_s.value.str, "good_sim") == 0) 
        fault_modeling_check(&fault_target,&fault_exclude,&fault_tw,fault_type,set_hold_time);  /////ADDED
}

/*
 *  PLI call function for $vcdCompare
 */
void vcdCompareCall( )
{
    //char* path = tf_getcstringp( 1 );//xrun doesn't support this function
    //char* step = tf_getcstringp( 2 );
    vpiHandle systf_h, arg_itr, arg_h;
    s_vpi_value value_h;
    char str_fir[100]; 
    char str_sec[100];
    char filename[100];
    char FI_PATH[100];
    char FS_PATH[100];
    char TIME_PATH[100];
    char PORT_PATH[100];

    systf_h = vpi_handle(vpiSysTfCall, NULL);
    arg_itr = vpi_iterate(vpiArgument, systf_h);
    arg_h = vpi_scan(arg_itr);
    value_h.format = vpiStringVal;
    vpi_get_value(arg_h, &value_h);
    strcpy(str_fir, value_h.value.str);
    arg_h = vpi_scan(arg_itr);
    vpi_get_value(arg_h, &value_h);
    strcpy(str_sec, value_h.value.str);
    vpi_free_object(arg_itr); /* free iterator -- did not scan to null */
    vpi_printf("path = %s\n",str_fir);
    strcpy(FS_PATH, str_fir);
    strcat(FS_PATH,"/fault.set");
    strcpy(FI_PATH, str_fir);
    strcat(FI_PATH,"/FI.xml");
    initializeStringList(&fault_target);
    initializeStringList(&fault_exclude);
    initializeStringList(&fault_tw_str);
    initializeStringList(&checker_list);
    initializeStringList(&functional_list);
    initializeStringList(&nostop_list);
    if (strcmp(str_sec, "good_sim") == 0) {
        random_process(FS_PATH);
        parseXML(FI_PATH);
        if(strcmp(iso_mode, "ENA") == 0){
            port_alias(&fault_target,&port_list);
            printList(&port_list, "port.log");
        }
        addEosCallback( timeRecordEosHandler );
        //timeCheck("/home/ICer/fusa_vpi/autosoc-development/Simulation/fault.time");
    }
    else {
        strcpy(filename, str_fir);
        strcat(filename,"/golden.vcd");
        strcpy(TIME_PATH, str_fir);
        strcat(TIME_PATH,"/golden.time");
        vpi_printf( "vcdCompare: reading <%s>\n", filename );
        /////*parseXML("FI.xml", &checker_list);*/
        FaultData *faults = random_process(FS_PATH);
        parse_injectXML("./fault.xml");//为了适配批量注入脚本
        parseXML(FI_PATH);
        printf("FAULT_ID:%s\n",FAULT_ID);
        int id = atoi(FAULT_ID)-1;
        if(strcmp(iso_mode, "ENA") == 0){
            strcpy(PORT_PATH, str_fir);
            strcat(PORT_PATH, "/port.log");
            readList(&port_list, PORT_PATH);
        }
        printf("checker strobe list:\n");
        printStringList(&checker_list);
        printf("functional strobe list:\n");
        printStringList(&functional_list);
        printf("nostop strobe list:\n");
        printStringList(&nostop_list);
        if(FAULT_LOCATION==NULL||strlen(FAULT_LOCATION) == 0 )
        {
            //printf("**********DEBUG%s\n%d\n",faults[id].location,CON_NUM);
            int i;
            for(i=0;i<CON_NUM+1;i++){
                fault_array[i].fault_node_name = strdup(faults[id + i].location);
                fault_array[i].injection_time = atoi(faults[id+i].time);
                //vpi_printf("%s\n",faults[id+i].type);
                if(strcmp("SEU", faults[id+i].type) == 0)
                    fault_array[i].fault_type = SEU;  /////ADDED
                else if(strcmp("SET", faults[id+i].type) == 0)
                    fault_array[i].fault_type = SET; /////ADDED
                else if(strcmp("SA0", faults[id+i].type) == 0)
                    fault_array[i].fault_type = SA0;   ///////ADDED
                else if(strcmp("SA1", faults[id+i].type) == 0)
                    fault_array[i].fault_type = SA1;   ///////ADDED
                fault_array[i].SET_return_time = atoi(faults[id+i].SET_return_time);////ADDED
            }
        }
        else {
            CON_NUM=0;
            if(strcmp("SEU", FAULT_TYPE) == 0)
                fault_array[0].fault_type = SEU; ////ADDED
            else if(strcmp("SET", FAULT_TYPE) == 0)
                fault_array[0].fault_type = SET;   ///////ADDED
            else if(strcmp("SA0", FAULT_TYPE) == 0)
                fault_array[0].fault_type = SA0;   //////ADDED
            else if(strcmp("SA1", FAULT_TYPE) == 0)
                fault_array[0].fault_type = SA1;    /////ADDED
            fault_array[0].fault_node_name =FAULT_LOCATION;
            fault_array[0].injection_time = atoi(FAULT_TIME);
            fault_array[0].SET_return_time = atoi(SET_RETURN_TIME);
            //printf("++++DEBUG::fault_array[i].name=%s++++\n",fault_array[0].fault_node_name);
        }
    }
    if (strcmp(str_sec, "good_sim") == 0) {
        addEosCallback( timeRecordEosHandler );
        //iso_gen("test_new.test_ins.sub_inst.a",&iso_inst_list);
        if(strcmp(iso_mode, "ENA") == 0){
            iso_itr(&port_list,&iso_inst_list);
            vpi_printf("\n****instrumenting the isolation in DUT****\n");
        }
        //vpi_printf("CON_NUM in good_sim is %d\n", CON_NUM);
        concur_gen(CON_NUM,DUT_NAME);
        //vpi_printf("debug\n");
        //timeCheck("/home/ICer/fusa_vpi/autosoc-development/Simulation/fault.time");
        return;
    }
    else {
        if(strcmp(iso_mode, "ENA") == 0){
            if(CON_NUM != 0){
                vpi_printf("\nFault Isolation only can be used when CON = 0\n");
                vpi_printf("\nFault Isolation is closed automatically\n");
            }
            else{
                fault_array[0].fault_node_name = check_alias(fault_array[0].fault_node_name,&port_list);
                vpi_printf("\nFault Isolation has been Enable\n");
                vpi_printf("because of iso, inject node is %s\n",fault_array[0].fault_node_name);
            }
        }
    }
    hashInitialize( &vcdHash, 200 );
    hashInitialize( &lexpHash, 100 );
    addEosCallback( FaultClassEosHandler );
    addEosCallback( vcdCompareEosHandler );
    //timeCheck("/home/ICer/fusa_vpi/autosoc-development/Simulation/fault.time");
    timeCheck(TIME_PATH);
    processVcd( readVcdHeader( filename ) );

    //fault_injector_check(&fault);
    int i;
    //printf("***********DEBUG: CON_NUM:%d*************\n",CON_NUM);
    for(i=0;i<CON_NUM+1;i++) fault_injector_check(&fault_array[i],i);
    /*
    double time_d = 22644900000.00000;
    uint64_t time_64 = (uint64_t)time_d;
    uint32_t high = (uint32_t)(time_64 >> 32); 
    uint32_t low = (uint32_t)(time_64 & 0xFFFFFFFF); 
    printf("+++++++++++++DEBUG%ld:%ld+++++++++++++++++=",high,low);
    */
    static s_vpi_time time_test = { vpiSimTime };
//    freeStringList(&fault_target);
//    freeStringList(&checker_list);
//    freeStringList(&functional_list);
//    freeStringList(&nostop_list);
    //time_test
}

/*
 *  PLI misc function for $vcdCompare
 */
void vcdCompareMisc( int data, int reason )
{
    if ( reason == reason_finish ) dummyEosHandler( );
}
//static void setTimeoutCallback( int time )
//{
//    static s_vpi_time time_s = { vpiSimTime };
//    //s_cb_data callbackData = { cbAtStartOfSimTime, timeoutHandler, 0, &time_s, 0 };
//
//    s_cb_data callbackData = { cbReadOnlySynch, timeoutHandler, 0, &time_s, 0 };
//
//    callbackData.time->high = 0;
//    callbackData.time->low  = time;
//    vpi_register_cb( &callbackData );
//}
static void setTimeoutCallback(uint64_t time) {
    //static s_vpi_time time_s = { vpiScaledRealTime };
    static s_vpi_time time_s = { vpiSimTime };
    s_cb_data callbackData = { cbReadOnlySynch, timeoutHandler, 0, &time_s, 0 };
    // 将 double 类型的时间值分解为 high 和 low
    //uint64_t time_ns = (uint64_t)(time * 1e9); // 将时间转换为纳秒（假设 time 是以秒为单位的双精度浮点数）
    callbackData.time->high = (uint32_t)(time >> 32); // 高32位
    callbackData.time->low  = (uint32_t)(time & 0xFFFFFFFF); // 低32位
    //printf("++++++++++DEBUG%lf++++++++++++",callbackData.time->real);
    //printf("++++++++++DEBUG_add_time_out_cb%lf++++++++++++",callbackData.time->real);
    vpi_register_cb(&callbackData);
}
static int timeoutHandler(p_cb_data cb_data_p)
{
    if (cb_data_p == NULL) {
        printf("Error: cb_data_p is NULL\n");
        return -1; // 或者其他适当的错误处理
    }

    uint64_t current = (cb_data_p->time->high << 32)|cb_data_p->time->low;
    uint64_t golden = current - tolerant_time;
    //strcpy(status_functional, "Detect");
    printf("****Time out while fault simulation*****\n");
    printf("golden time is %llu, current time is %llu\n", golden, current);

    //free(cb_data_p);
    cb_data_p = NULL; // 避免重复释放
    freeStringList(&fault_target);
    freeStringList(&fault_exclude);
    freeStringList(&fault_tw_str);
    freeStringList(&checker_list);
    freeStringList(&functional_list);
    freeStringList(&nostop_list);
    BoolArray_free(&con_stop);
    vpi_control(vpiStop, 1);
    return(0);
}

//static int timeoutHandler( p_cb_data cb_data_p )
//{   
//    int current=(int)cb_data_p->time->low;
//    int golden = current-tolerant_time;
//    strcpy(status_functional, "Detect");
//    printf("****Time out while fault simulation*****\n");
//    printf("golden time is %d, current time is %d",golden,current);
//    //vpi_control(vpiStop,1);
//    free(cb_data_p);
//    cb_data_p = NULL;
//    return(vpi_control(vpiFinish,1));
//}
void timeCheck(const char* filename){
    uint64_t golden_time;
    uint64_t stop_time;
    FILE *file;


    // 打开文件golden.time
    file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return EXIT_FAILURE;
    }
    if (fscanf(file, "%llu", &golden_time) != 1) {
        perror("Error reading integer from file");
        fclose(file);
        return EXIT_FAILURE;
    }
    fclose(file);
    //vpi_printf("timeis%llu\n",golden_time);
    stop_time=golden_time+tolerant_time;
    setTimeoutCallback(stop_time);
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
        if (xmlStrcmp(node->name, (const xmlChar*)"FAULT_TARGET") == 0){
            xmlChar* content = xmlNodeGetContent(node);
           // strcpy(fault_target,content);
            fault_target.strings[fault_target.count++] = strdup((const char*)content);
            vpi_printf("fault_target:%s\n",fault_target.strings[fault_target.count-1]);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"FAULT_EXCLUDE") == 0){
            xmlChar* content = xmlNodeGetContent(node);
            fault_exclude.strings[fault_exclude.count++] = strdup((const char*)content);
            vpi_printf("fault_exclude:%s\n",fault_exclude.strings[fault_exclude.count-1]);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"FAULT_TYPE") == 0){          //////////////ADDED
            xmlChar* content = xmlNodeGetContent(node);                                  ///////////////ADDED
            fault_type_str = strdup((const char*)content);                                     //////////////////ADDED 
            vpi_printf("fault_type:%s\n",fault_type_str);                                              ///////////////ADDED 
            xmlFree(content);                                   /////////////ADDED
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"FAULT_TW_START") == 0){
            xmlChar* content = xmlNodeGetContent(node);
            fault_tw_str.strings[0] = strdup((const char*)content);
            vpi_printf("fault_tw_str[0]:%s\n",fault_tw_str.strings[0]);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"FAULT_TW_END") == 0){
            xmlChar* content = xmlNodeGetContent(node);
            fault_tw_str.strings[1] = strdup((const char*)content);
            vpi_printf("fault_tw_str[1]:%s\n",fault_tw_str.strings[1]);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"SET_HOLD_TIME") == 0){          //////////////ADDED
            xmlChar* content = xmlNodeGetContent(node);                                  ///////////////ADDED
            set_hold_time = atoi((const char*)content);                                     //////////////////ADDED 
            vpi_printf("set_hold_time:%d\n",set_hold_time);                                              ///////////////ADDED 
            xmlFree(content);                                   /////////////ADDED
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"ISO_MODE") == 0){
            xmlChar* content = xmlNodeGetContent(node);
            strcpy(iso_mode,content);
            vpi_printf("isolation mode:%s\n",iso_mode);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar*)"CON") == 0){
            xmlChar* content = xmlNodeGetContent(node);
            CON_NUM = atoi(content);
            //printf("%d %d %d\n",CON_NUM,atoi(FAULT_ID),num_lines);
            if(CON_NUM+atoi(FAULT_ID)>num_lines) CON_NUM= num_lines-atoi(FAULT_ID);
            vpi_printf("Concurrent num:%d\n",CON_NUM);
            //status_checker    = (char (*)[10])malloc((CON_NUM+1) * sizeof(char[10]));
            //status_functional = (char (*)[10])malloc((CON_NUM+1) * sizeof(char[10]));
            status_checker    = (char **)malloc((CON_NUM+1) * sizeof(char*));
            status_functional = (char **)malloc((CON_NUM+1) * sizeof(char*));
            fault_array = (struct Fault *)malloc((CON_NUM+1) * sizeof(struct Fault));
            int i;
            for (i = 0; i < CON_NUM+1; i++) {
                fault_array[i].fault_node_name = (PLI_INT32 *)malloc(100 * sizeof(PLI_INT32));
                //fault_array[i].fault_node_name = NULL;  
                fault_array[i].fault_type = i;          
                fault_array[i].injection_time = i;
                //printf("______DEBUG:TIME::%d_______\n",fault_array[i].injection_time );
            }
            for (i = 0; i < CON_NUM+1; i++) {
                status_checker[i] = (char *)malloc(9*sizeof(char));
                status_functional[i] = (char *)malloc(9*sizeof(char));
                strcpy(status_checker[i], "Undetect");
                strcpy(status_functional[i], "Undetect");
            }
            xmlFree(content);
        }
    }
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
        if (xmlStrcmp(node->name, (const xmlChar *)"TESTBENCH_NAME") == 0)
        {  
            xmlChar* content = xmlNodeGetContent(node);
            //strcpy(TESTBENCH_NAME, (char *)xmlNodeGetContent(node));
            strcpy(TESTBENCH_NAME, (char*)content);
            xmlFree(content);
        }
        if (xmlStrcmp(node->name, (const xmlChar *)"DUT_NAME") == 0)
        {  
            xmlChar* content = xmlNodeGetContent(node);
            //strcpy(TESTBENCH_NAME, (char *)xmlNodeGetContent(node));
            strcpy(DUT_NAME, (char*)content);
            xmlFree(content);
            printf("DUT_NAME is :%s\n",DUT_NAME);

        }

    }
    if (functional_list.count==0) strcpy(strobe_mode, "Single");
    xmlFreeDoc(doc);
}
void parse_injectXML(const char* filename) {
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
            if (xmlStrcmp(node->name, (const xmlChar *)"ID") == 0) {
                strcpy(FAULT_ID, (char *)xmlNodeGetContent(node));
            } else if (xmlStrcmp(node->name, (const xmlChar *)"LOCATION") == 0) {
                strcpy(FAULT_LOCATION, (char *)xmlNodeGetContent(node));
            } else if (xmlStrcmp(node->name, (const xmlChar *)"TYPE") == 0) {
                strcpy(FAULT_TYPE, (char *)xmlNodeGetContent(node));
            } else if (xmlStrcmp(node->name, (const xmlChar *)"TIME") == 0) {
                strcpy(FAULT_TIME, (char *)xmlNodeGetContent(node));
            } else if (xmlStrcmp(node->name, (const xmlChar *)"SET_RETURN_TIME") == 0) {        /////////////ADDED
                strcpy(SET_RETURN_TIME, (char *)xmlNodeGetContent(node));                       //////////ADDED
            }
        }
    xmlFreeDoc(doc);
}
static int fault_classification( p_cb_data cb_data_p )
{
    char **result = (char **)malloc((CON_NUM + 1) * sizeof(char *));

    int i;


    for(i=0;i<CON_NUM+1;i++){
        result[i] = (char *)malloc(3 * sizeof(char));
        result[i][0] = status_functional[i][0];
        result[i][1] = status_checker[i][0];
        result[i][2] = '\0';
    }
    vpi_printf("Strobe Mode is %s\n",strobe_mode);
    if (strcmp(strobe_mode, "Single") == 0){
        vpi_printf("the classificaiton of the inject fault is :%s\n",status_checker[0]);
        generateXML("NULL","NULL",status_checker,FAULT_TYPE,CON_NUM);
    }
    else { 
        vpi_printf("the classificaiton of the inject fault is :\nFunctional:%s,\nChecker:%s\n",status_functional[0],status_checker[0]);
        generateXML(FAULT_ID,FAULT_LOCATION,result,FAULT_TYPE,CON_NUM); 
    }
    for (i = 0; i < CON_NUM + 1; i++) {
        free(result[i]);
        free(status_functional[i]);
        free(status_checker[i]);
    }
    free(status_functional);
    free(status_checker);
    free(fault_array);
    //free(result);
}

static void FaultClassEosHandler( p_cb_data data )
{
    fault_classification( data );
}
void generateXML(const char* idValue, const char* locationValue, const char** statusValue,const char* typeValue,int vact_num) {
    FILE *fp;
    int i;
    char **type = (char **)malloc((CON_NUM + 1) * sizeof(char *));
    for(i=0;i<CON_NUM+1;i++){
        if(fault_array[i].fault_type==SEU) type[i]="SEU";
        if(fault_array[i].fault_type==SET) type[i]="SET";
        if(fault_array[i].fault_type==SA0) type[i]="SA0";
        if(fault_array[i].fault_type==SA1) type[i]="SA1";    }
    fp = fopen("result.xml", "w");
    if (fp == NULL) {
        printf("Error opening file.\n");
        return;
    }
    fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n");
    for(i=0;i<vact_num+1;i++){
    fprintf(fp, "<RESULT>\n");
    fprintf(fp, "    <ID>%d</ID>\n", atoi(idValue)+i);
    fprintf(fp, "    <LOCATION>%s</LOCATION>\n", fault_array[i].fault_node_name);
    fprintf(fp, "    <TYPE>%s</TYPE>\n", type[i]);
    fprintf(fp, "    <TIME>%d</TIME>\n",fault_array[i].injection_time);
    fprintf(fp, "    <SET_RETURN_TIME>%d</SET_RETURN_TIME>\n",fault_array[i].SET_return_time);
    //fprintf(fp, "    <CHECKER_TIME>%d</CHECKER_TIME>\n",atoi(CHECKER_TIME));
    //fprintf(fp, "    <FUNCTIONAL_TIME>%d</FUNCTIONAL_TIME>\n",atoi(FUNCTIONAL_TIME));
    fprintf(fp, "    <STATUS>%s</STATUS>\n", statusValue[i]);
    fprintf(fp, "</RESULT>\n");
    }
    fclose(fp);
    //free(statusValue);

    free(type);
    printf("XML file generated successfully.\n");
}
void SAInject(const char* fault_location, const char* fault_time, const char* fault_type){
    vpiHandle location_handle;
    s_vpi_value value_s;
    int value;
    if(strcmp(fault_type,"SA0")==0) value = 0;
    else value = 1;
   // printf(fault_location);
    location_handle = vpi_handle_by_name(fault_location,0);
    value_s.format = vpiIntVal;
    value_s.value.integer = value;
    printf("Inject Fault at:%s ,Fault type is %s\n",vpi_get_str(vpiFullName,location_handle),fault_type);
    vpi_put_value(location_handle,&value_s,NULL,vpiForceFlag);
}

/*
void vcd_vpi_register(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$vcdCompare";
    tf_data.calltf=vcdCompareCall;
    tf_data.compiletf=vcdCompareCheck;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}
*/

extern void vpit_RegisterTfs( void )
{
    s_vpi_systf_data systf_data_list[] = {
        {vpiSysTask, 0, "$vcdCompare", vcdCompareCall, vcdCompareCheck, 0, 0},
        {vpiSysTask, 0, "$clear_mem", vpi_clear_memory_calltf, 0, 0, 0},
        {vpiSysTask, 0, "$file_init_mem", vpi_init_from_file_calltf, 0, 0, 0},
        {vpiSysTask, 0, "$xml_init_mem", vpi_init_from_xml_calltf, 0, 0, 0},
        {0}
    };

    int i;
    for (i = 0; systf_data_list[i].type != 0; ++i){
        vpi_register_systf( &systf_data_list[i] );
    }
}
#ifdef SHARE_LIB

#else
void(*vlog_startup_routines[])()={
    vpit_RegisterTfs,
    0
};

#endif


