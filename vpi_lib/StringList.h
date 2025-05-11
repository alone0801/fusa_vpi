#ifndef STRINGLIST_H
#define STRINGLIST_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct StringList {
    char** strings;
    int count;
    int capacity;
}StringList;

void initializeStringList(struct StringList* list);
void addString(struct StringList* list, const char* str);
void printStringList(struct StringList* list);
void freeStringList(struct StringList* list);
int checkStringList(const struct StringList* list, const char* str);
#endif /* STRINGLIST_H */
