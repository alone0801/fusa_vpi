#include "vpi_user.h"
#include <stdio.h>
#include "port_alias.h"
typedef struct Module {
    char* name;
    struct Module* next;
} Module;

void iso_gen(char* port_name, Module** head);
void redirect_stdout_to_file(const char* filename);
int getExprValue(vpiHandle conn, int r);
Module* create_module(const char* name);
int check_name_in_list(Module** head, const char* input_name);
void add_module(Module** head, const char* name);
void iso_itr(PortInfoNode**  port_list_head,Module** iso_inst_head);
char* iso_exchange(char* singal_name);
