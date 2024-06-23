#ifndef PORT_ALIAS_H
#define PORT_ALIAS_H


#include "vpi_user.h"
#include <stdio.h>
#include <stdlib.h>    /* ANSI C standard library */
#include <strings.h>
#include <malloc.h>
#include <stdio.h> 
#include "StringList.h"
typedef struct PortInfoNode {
    char internalName[150];
    char externalName[150];
    int  alias;
    int  root;  /*root = 1 alias 到顶了   root = 0  还需要继续遍历查找上一层驱动*/
    struct PortInfoNode* next;
} PortInfoNode;

char* check_alias(const char* node_name, PortInfoNode** head);
void port_alias(StringList* mod_name , PortInfoNode** head);
void process_aliases(PortInfoNode** head);
void alias_opt(PortInfoNode** head);
void port_isolate(vpiHandle mod_h,PortInfoNode** head);
PortInfoNode* createNode(const char* internalName, const char* externalName);
void port_tranverse(vpiHandle mod_h, int top,PortInfoNode** head);
void printList(PortInfoNode **head);
void appendNode(PortInfoNode** head, const char* internalName, const char* externalName);
void process_prime(PortInfoNode** head);
#endif
