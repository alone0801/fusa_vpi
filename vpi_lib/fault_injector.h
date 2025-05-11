#include "veriuser.h"
#include "vpi_user.h"

#define SA_FAULT 0
#define SEU_FAULT 1

struct Fault{
    PLI_INT32 *fault_node_name;
    PLI_INT32 fault_type;
    PLI_INT32 fault_value;
    int injection_time;
}fault,*fault_p;

struct cb_Userdata{
    vpiHandle module_handle;
    PLI_INT32 vact_num;
    struct Fault *fault_p;
}cb_userdata,*cb_userdata_p;
char TESTBENCH_NAME[100];
