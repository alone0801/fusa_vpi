#include "iso.h"
void iso_gen(char* port_name, Module** head){
    vpiHandle signal_h,scope_h,module_h,port_itr,port_h,l_range_h,r_range_h,HighConn,LowConn;
    char* inst_name ;    //char buffer[256];
    signal_h = vpi_handle_by_name(port_name,0);
    FILE *fp=fopen("fi_wrapper.sv", "a");
    if (fp == NULL) {
        printf("Error opening file.\n");
        return;
    }
    //redirect_stdout_to_file("fi_wrapper.sv");
    scope_h = vpi_handle(vpiScope,signal_h);
    LowConn = vpi_handle(vpiLowConn, signal_h);
    
    //snprintf(buffer, sizeof(buffer), "%s_iso.%s.%s",vpi_get_str(vpiFullName,scope_h) ,vpi_get_str(vpiName,scope_h) ,vpi_get_str(vpiName, signal_h) );
    //printf("Stored string: %s\n", buffer);
    const char* fullName = vpi_get_str(vpiFullName, scope_h);
    const char* scopeName = vpi_get_str(vpiName, scope_h);
    const char* signalName = vpi_get_str(vpiName, signal_h);
    size_t total_length = strlen(fullName) + strlen("_iso.") + strlen(scopeName) + strlen(".") + strlen(signalName) + 1;
    char* iso_name = (char*)malloc(total_length);
    iso_name[0] = '\0';
    strcat(iso_name, fullName);
    strcat(iso_name, "_iso.");
    strcat(iso_name, scopeName);
    strcat(iso_name, ".");
    strcat(iso_name, signalName);
    //vpi_printf("+++++++++++DEBUG_ISO:%s+++++++++++++\n",iso_name);
    module_h = vpi_handle(vpiScope,scope_h);
    inst_name = vpi_get_str(vpiFullName,scope_h);
    if(check_name_in_list(head,inst_name)) return;
    else add_module(head, inst_name);
    port_itr = vpi_iterate(vpiPort,scope_h);
    fprintf(fp,"module %s_iso(",vpi_get_str(vpiName,scope_h));
    port_itr = vpi_iterate(vpiPort,scope_h);
    int first_port = 1; // 用于标记第一个端口
    while (port_h = vpi_scan(port_itr)) {
        HighConn = vpi_handle(vpiHighConn, port_h);
        LowConn = vpi_handle(vpiLowConn, port_h);
        
        if (!first_port) {
            fprintf(fp,", ");
        } else {
            first_port = 0;
        }
        if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"%s",vpi_get_str(vpiName,parent_h));
                }
        else if(vpi_get(vpiType, HighConn)==vpiConstant) {
                  vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                  s_vpi_value val = {vpiDecStrVal};
                  //s_vpi_value val = {vpiStringVal}; 
                  vpi_get_value(HighConn,&val);
                  //fprintf(fp,"%s",vpi_get_str(vpiName,parent_h));
                  //fprintf(fp,"VALUE::%s",val.value.str);
                  //fprintf(fp,"TYPE::%d",vpi_get(vpiConstType, HighConn));
                  //fprintf(fp,"Decompile::%s",vpi_get_str(vpiDecompile, HighConn));
                  first_port=1;// avoid ,  ,
                }
    
        else fprintf(fp,"%s", vpi_get_str(vpiName, HighConn));

    }
    fprintf(fp,");\n");
    int port_num=0;
    port_itr = vpi_iterate(vpiPort,scope_h);
    while(port_h=vpi_scan(port_itr)){
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        switch(vpi_get(vpiDirection,port_h)){
            case vpiInput: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"input logic [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,parent_h));
                }
                else if(vpi_get(vpiType, HighConn)==vpiConstant) ;
                else fprintf(fp,"input  logic [%d:%d] %s;\n",getExprValue(lowConn,vpiLeftRange),getExprValue(lowConn,vpiRightRange),vpi_get_str(vpiName,HighConn));
                port_num++;
                break;
            }
            case vpiOutput: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"output logic [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,parent_h));
                }
                else fprintf(fp,"output logic [%d:%d] %s;\n",getExprValue(lowConn,vpiLeftRange),getExprValue(lowConn,vpiRightRange),vpi_get_str(vpiName,HighConn));
                port_num++;
                break;
            }
            case vpiInout: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"inout wire [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,parent_h));
                }
                else fprintf(fp,"inout  wire  [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiFullName,HighConn));
                port_num++;
                break;
            }
        }
    //vpi_printf("%s  %s",vpi_get_str(vpiDefName,scope_h),vpi_get_str(vpiName,scope_h));
    }
    fprintf(fp,"%s  %s(",vpi_get_str(vpiDefName,scope_h),vpi_get_str(vpiName,scope_h));
    int i;
    port_itr = vpi_iterate(vpiPort,scope_h);
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        char* high_port = vpi_get_str(vpiName,HighConn);
        if (vpi_get(vpiType, HighConn)==vpiConstant) high_port=vpi_get_str(vpiDecompile, HighConn);
        if(i<port_num-1)fprintf(fp,".%s(%s),",vpi_get_str(vpiName,lowConn),high_port);
        else fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,lowConn),high_port);
    }
    fprintf(fp,"initial begin\n");
    port_itr = vpi_iterate(vpiPort,scope_h);
    while(port_h=vpi_scan(port_itr)){
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        switch(vpi_get(vpiDirection,port_h)){
            case vpiInput: 
            {
                break;
            }
            case vpiOutput: 
            {
                fprintf(fp,"force %s = %s ; \n", vpi_get_str(vpiFullName,HighConn),vpi_get_str(vpiName,HighConn));
                break;
            }
            case vpiInout: 
            {
                fprintf(fp,"This version don't support");
                break;
            }
        }
    }
    fprintf(fp,"end\n");
    fprintf(fp,"endmodule\n");
    fprintf(fp,"bind  %s %s_iso %s_iso(",vpi_get_str(vpiFullName,module_h),vpi_get_str(vpiName,scope_h),vpi_get_str(vpiName,scope_h)); 
    port_itr = vpi_iterate(vpiPort,scope_h);
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        if(vpi_get(vpiType, HighConn)!=vpiConstant){
          if(i<port_num-1)fprintf(fp,".%s(%s),",vpi_get_str(vpiName,HighConn),vpi_get_str(vpiName,HighConn));
          else fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,HighConn),vpi_get_str(vpiName,HighConn));
        }
    }
//    vpi_printf("\n###################ISO_REPORT_END##########################\n");
    //freopen("/dev/tty", "a", stdout);
    fclose(fp);
}


void redirect_stdout_to_file(const char* filename) {
    FILE* file = freopen(filename, "a", stdout);
    if (!file) {
        vpi_printf("无法打开文件 %s\n", filename);
    }
}

int getExprValue(vpiHandle conn, int r) {
    vpiHandle expr = vpi_handle(r, conn);

    s_vpi_value val = {vpiIntVal};
    vpi_get_value(expr, &val);
    return val.value.integer;
}

Module* create_mod(const char* name) {
    Module* new_module = (Module*)malloc(sizeof(Module));
    if (new_module == NULL) {
        fprintf(stderr, "Failed to allocate memory for new module.\n");
    }
    new_module->name = strdup(name); // 复制字符串
    if (new_module->name == NULL) {
        vpi_printf(stderr, "Failed to allocate memory for module name.\n");
        free(new_module);
    }
    new_module->next = NULL;
    return new_module;
}

int check_name_in_list(Module** head, const char* input_name) {
    Module* current = *head;
    while (current != NULL) {
        printf("%s",current->name);
        printf("%s",input_name);
        if (strcmp(current->name, input_name) == 0) {
            return 1; // 找到匹配的名字
        }
        current = current->next;
    }
    return 0; // 未找到匹配的名字
}

void add_module(Module** head, const char* name) {
    Module* new_module = create_mod(name);
    if (*head == NULL) {
        // 如果链表为空，设置新模块为头节点
        //vpi_printf("BEFORE::Added module to the end: %s\n", (*head)->name);
        *head = new_module;

    } else {
        // 遍历链表找到最后一个节点
        Module* current = *head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = new_module;
    }
}

void iso_itr(PortInfoNode**  port_list_head,Module** iso_inst_head){
    PortInfoNode* current = *port_list_head;
    while (current != NULL) {
        if (current->alias == 1) iso_gen(current->internalName,iso_inst_head);
        current = current->next;
    }

}

char* iso_exchange(char* singal_name){
    vpiHandle signal_h,scope_h;
    signal_h=vpi_handle_by_name(singal_name,0);
    scope_h = vpi_handle(vpiScope,signal_h);
    const char* fullName = vpi_get_str(vpiFullName, scope_h);
    const char* scopeName = vpi_get_str(vpiName, scope_h);
    const char* signalName = vpi_get_str(vpiName, signal_h);
    size_t total_length = strlen(fullName) + strlen("_iso.") + strlen(scopeName) + strlen(".") + strlen(signalName) + 1;
    char* iso_name = (char*)malloc(total_length);
    iso_name[0] = '\0';
    strcat(iso_name, fullName);
    strcat(iso_name, "_iso.");
    strcat(iso_name, scopeName);
    strcat(iso_name, ".");
    strcat(iso_name, signalName);
    return iso_name;


}

