#include "StringList.h"

void initializeStringList(struct StringList* list) {
    list->strings = (char**)malloc(10 * sizeof(char*));
    list->count = 0;
    list->capacity = 10;
}

void addString(struct StringList* list, const char* str) {
    if (list->count >= list->capacity) {
        // Resize the array if needed
        list->capacity = list->capacity + 20;
        list->strings = (char**)realloc(list->strings, list->capacity * sizeof(char*));
    }
    list->strings[list->count] = strdup(str);
    list->count++;
}
int i;
void printStringList(struct StringList* list) {
    for ( i=0 ; i < list->count; i++) {
        printf("%s\n", list->strings[i]);
    }
}

void freeStringList(struct StringList* list) {
    for (i = 0; i < list->count; i++) {
        free(list->strings[i]);
    }
    free(list->strings);
}

int checkStringList(const struct StringList* list, const char* str) {
    for (i = 0; i < list->count; i++) {
        if (strcmp(list->strings[i], str) == 0) {
            return 1;
        }
    }
    return 0;  // String not found
}
