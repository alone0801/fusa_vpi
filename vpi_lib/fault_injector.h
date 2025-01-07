//#include "vcsuser.h"
#include "vpi_user.h"

#define SA_FAULT 0
#define SEU_FAULT 1

struct Fault{
    PLI_INT32 *fault_node_name;
    PLI_INT32 fault_type;
    PLI_INT32 fault_value;
    double injection_time;
}fault,*fault_p;

char TESTBENCH_NAME[100];
