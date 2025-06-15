#include "veriuser.h"
#include "vpi_user.h"
//
#define SA0 0
#define SA1 1
#define SEU 2
#define SET 3
// ADDED
struct Fault{
    PLI_INT32 *fault_node_name;
    PLI_INT32 fault_type;
    int injection_time;
    int SET_return_time; //////ADDED
};
struct cb_Userdata{
    vpiHandle module_handle;
    PLI_INT32 vact_num;
    struct Fault *fault_p;
};
char TESTBENCH_NAME[100];
int fault_SET[1000000];
