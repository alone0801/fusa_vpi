#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char time[20];
    char location[200];
    char type[10];
    char result[10];
} FaultData;
FaultData *random_process(const char* filename);
