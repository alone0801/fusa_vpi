#include "random.h"
int num_lines = 0;
FaultData *random_process(const char* filename) {
    FILE *fp;
    char line[256];
    num_lines = 0;
    
    fp = fopen(filename, "r");
    if (fp == NULL) {
        perror("Error opening file");
        return NULL;
    }

    while (fgets(line, sizeof(line), fp)) {
        num_lines++;
    }
    num_lines = num_lines-1;
    //printf("num_lines:%d\n", num_lines);
    fclose(fp);

    FaultData *faults = malloc(num_lines * sizeof(FaultData));
    if (faults == NULL) {
        perror("Error allocating memory");
        return NULL;
    }

    fp = fopen(filename, "r");
    if (fp == NULL) {
        perror("Error opening file");
        return NULL;
    }
    if (fgets(line, sizeof(line), fp) == NULL) {
        perror("Error reading first line");
        fclose(fp);
        free(faults);
        return NULL;
    }
    //int index = 0;
    //while (fgets(line, sizeof(line), fp)) {
    //    if (sscanf(line, "%*d %19s { %*d \"%199[^\"]\" }",
    //               faults[index].fault_time, faults[index].fault_location) == 2) {
 // //          printf("++++++DEBUG%s++++++++++++=",faults[index].fault_location);
    //        index++;
    //    }
    //}
    //printf("++++++DEBUG:HERE IS RANDOM++++++++++++=");
    int index = 0;
    while (fgets(line, sizeof(line), fp)) {
        if (sscanf(line, "%255s %15s %25s %25s %15s",
                   faults[index].location,
                   faults[index].type,
                   faults[index].time,
                   faults[index].SET_return_time,
                   faults[index].result) == 5) {
            //printf("++++++DEBUG:HEREINBRANCH++++");
            //printf("++++++DEBUG%s++++++++++++=",faults[index].location);
            //printf("+++RANDOM::TIME:%s++++\n",faults[index].time);
            //vpi_printf("%s %s %s %s %s %s\n", faults[index].location,faults[index].type,faults[index].value,faults[index].time,faults[index].SET_return_time,faults[index].result);
            index++;
        }
        else {
            printf("Failed to parse line: %s", line);
            return 0 ;
        }
    }


//    for (index = 0; index < 4; index++) {
//        printf("faults[%d].time = \"%s\" (length = %zu)\n", index, faults[index].time, strlen(faults[index].time));
//        int a = atoi(faults[index].time);
//        printf("+++a==%d+++++\n", a);
//    }
    fclose(fp);

    return faults;
}
