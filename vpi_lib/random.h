#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char fault_time[20];
    char fault_location[100];
} FaultData;
FaultData *random_process();
