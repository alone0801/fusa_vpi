#include "random.h"

FaultData *random_process() {
    FILE *fp;
    char line[256];
    int num_lines = 0;

    fp = fopen("fault.set", "r");
    if (fp == NULL) {
        perror("Error opening file");
        return NULL;
    }

    while (fgets(line, sizeof(line), fp)) {
        num_lines++;
    }

    fclose(fp);

    FaultData *faults = malloc(num_lines * sizeof(FaultData));
    if (faults == NULL) {
        perror("Error allocating memory");
        return NULL;
    }

    fp = fopen("fault.set", "r");
    if (fp == NULL) {
        perror("Error opening file");
        return NULL;
    }

    int index = 0;
    while (fgets(line, sizeof(line), fp)) {
        if (sscanf(line, "%*d %19s { %*d \"%99[^\"]\" }",
                   faults[index].fault_time, faults[index].fault_location) == 2) {
            index++;
        }
    }

    fclose(fp);

    return faults;
}
