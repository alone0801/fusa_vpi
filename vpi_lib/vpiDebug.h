#include "vcsuser.h"
#include "vpi_user.h"

#include <stdio.h>
#include <strings.h>
#include <malloc.h>

#define USE_NODES

#include "hash.h"

/*
 *  Debug output (flags defined in vpiDebug.c)
 */
extern int DbgCback;  /* debug event callback installation */
extern int DbgEvent;  /* debug event callback handling     */
extern int DbgTrace;  /* debug netlist back-trace          */
extern int DbgVdiff;  /* debug on-the-fly vcdiff algorithm */
extern int DbgOscil;  /* debug oscillation detection tool  */

#define DBG_CBACK( a ) if ( DbgCback ) vpi_printf a
#define DBG_EVENT( a ) if ( DbgEvent ) vpi_printf a
#define DBG_TRACE( a ) if ( DbgTrace ) vpi_printf a
#define DBG_VDIFF( a ) if ( DbgVdiff ) vpi_printf a
#define DBG_OSCIL( a ) if ( DbgOscil ) vpi_printf a

/*
 *  Trap possibly null string pointers for printing
 */
static char* _safe_t_;

#define SAFE( str ) ( ( _safe_t_ = str ) ? _safe_t_ : "<null>" )

/*
 *  Fetch the fullname of any VPI object
 */
#define FullName( obj ) ( SAFE( vpi_get_str( vpi_get( vpiType, obj ) == vpiPort ? vpiName : vpiFullName, obj ) ) )

/*
 *  Flag bits for triggering information dumps
 */
#define FLG_TRACE_ON_EVNT 0x01
#define FLG_TRACE_ON_DIFF 0x02
#define FLG_TRACE_ON_LOOP 0x04
#define FLG_TRACE_ON_LAST 0x08

/*
 *  The user_data structure used for event callbacks
 */
typedef struct t_cback_data
{
    vpiHandle            refn;
 
    /* last value (before callback) */

    char*                last;

    /* pointer to associated trace_node (unique) */
 
    struct t_trace_node* tree;
 
    /* pointer to associated vdiff_node */
 
    struct t_vdiff_node* dnod;
 
    /* pointer to assiciated oscil_node */

    struct t_oscil_node* oscp;

    /* pointer to assiciated exmod_node */

    struct t_exmod_node* eptr;

#ifdef USE_LASTSEEN

    /* doubly-linked list of last seen events */
 
    struct t_cback_data* next;
    struct t_cback_data* prev;
 
#endif

} s_cback_data, *p_cback_data;

/*
 *  Value change callback user data (and, ultimately, the database
 *    of all objects with callbacks installed)
 */
typedef struct t_trace_node
{
    struct t_cback_data* refn;

    /* last known value (this will go away) */

    char*                valu;

    /* time of last event on this node (this will go away) */

    PLI_UINT32           t_hi;
    PLI_UINT32           t_lo;

    /* flag to detect loops in the graph */

    int                  loop;

    /* flags for triggering information dumps */

    int                  dump;

    /* singly-linked list of "drivers" of this node */

    struct t_trace_link* back;

    /* experimental event trace support */

    struct t_event_node* last;

} s_trace_node, *p_trace_node;

typedef struct t_trace_link
{
    /* pointers forward and backward in the netlist */

    struct t_trace_node* forw;
    struct t_trace_node* back;

    /* singly-linked list of "drivers" of this node */

    struct t_trace_link* next;

} s_trace_link, *p_trace_link;

/*
 *  The basic "event node" for the new tracing manager
 */
typedef struct t_event_node
{
    /* pointer to parent callback trace_node and refn count */

    struct t_trace_node* refn;
    int                  rcnt;

    /* flag to detect loops in the graph */

    int                  loop;

    /* value of current and previous event on node */

    char*                last;
    char*                valu;

    /* time of last event on this node */

    PLI_UINT32           t_hi;
    PLI_UINT32           t_lo;

    /* pointer to causal event list */

    struct t_event_link* back;

    /* pointer to next in free pool */

    struct t_event_node* next;

} s_event_node, *p_event_node;

typedef struct t_event_link
{
    /* pointers forward and backward in the netlist */

    struct t_event_node* forw;
    struct t_event_node* back;

    /* singly-linked list of "drivers" of this node */

    struct t_event_link* next;

} s_event_link, *p_event_link;

/*
 *  Data structure for VCD comparison function
 */
typedef struct t_vdiff_node
{
    struct t_cback_data* refn;
    char*                mark;
 
} s_vdiff_node, *p_vdiff_node;

/*
 *  Global data structure for oscillation detection
 */
typedef struct t_oscil_data
{
    int                  stop;
    int                  maxt;
 
    /* global detect flag (and pointer to time-advance callback) */

    vpiHandle            wait;

    /* linked-list of X-forced nodes */

    struct t_oscil_node* head;

} s_oscil_data, *p_oscil_data;

/*
 *  Per-net data structure for oscillation detection
 */
typedef struct t_oscil_node
{
    struct t_cback_data* refn;

    struct t_oscil_data* data;

    /* time of last event on this node (manhole -- merge this into t_cback_data) */
 
    PLI_UINT32           t_hi;
    PLI_UINT32           t_lo;

    /* event count */

    int                  tcnt;

    /* linked-list of X-forced nodes */

    struct t_oscil_node* next;

} s_oscil_node, *p_oscil_node;

/*
 *  Per-net data structure for module extraction
 */
typedef struct t_exmod_node
{
    struct t_cback_data* refn;

    /* the multi-channel descriptor for this extraction */

    int                  file;

    /* debug flags */

    int                  dbug;
    char*                name;

} s_exmod_node, *p_exmod_node;

/*
 *  The "callback" functions used to control back-tracing
 */
typedef struct t_trace_data
{
    int   ( *fnCheckForLoop )( vpiHandle, char* );
    void* ( *fnLoopDetected )( vpiHandle, char*, void* );
    void* ( *fnInstallTrace )( vpiHandle, char*, void* );

    /*
     *  Put all other defines after the function pointers
     */
    int      maxLevels; /* forces back-trace to truncate search */

} s_trace_data, *p_trace_data;

/*
 *  Generic list of named objects (used to pass object from "check" to "call" functions)
 */
typedef struct t_object_list
{
  vpiHandle             refn;
  char*                 name;
  struct t_object_list* next;
 
} s_object_list, *p_object_list;

/*
 *  Routine definitions
 */
char*        objectName( vpiHandle );                               /* in util.c        */
char*        operationName( vpiHandle );
char*        gateName( vpiHandle );

char*        makeSpace( int );
int          nodeTimeCompare( p_trace_node, p_trace_node );
void         addNewObject( p_object_list*, vpiHandle, char* );

void*        readVcdHeader( char* );                                /* in vcdReader.c   */
char*        readVcdLine( void* );

void         causalTrace( p_trace_node, char* );                    /* in eventTrace.c  */

void         backTrace( int, p_trace_data, void*, vpiHandle );      /* in backTrace.c   */

void         hierTrace( int, vpiHandle, int ( * )( ), void* );      /* in hierTrace.c   */
void         hierTraceCont( int, vpiHandle, int ( * )( ), void* );

void         generateCausalTree( vpiHandle );                       /* in traceSignal.c */

void         dumpCausalTree( int, p_trace_node );                   /* in causalTree.c  */

bool         hasEventCallback( vpiHandle );                         /* in evCallback.c  */
p_cback_data getEventCallback( vpiHandle );
p_cback_data setEventCallback( vpiHandle );
p_cback_data getLastEvent( );

void         triggerOnEvent( p_cback_data );
void         triggerOnDiff( p_cback_data );
void         triggerOnLoop( p_cback_data );

void         addEosCallback( void ( * )( p_cb_data ) );             /* in eosCallback.c */
void         dummyEosHandler( );
