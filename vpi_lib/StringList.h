#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct StringList {
    char** strings;
    int count;
    int capacity;
};

void initializeStringList(struct StringList* list);
void addString(struct StringList* list, const char* str);
void printStringList(struct StringList* list);
void freeStringList(struct StringList* list);

