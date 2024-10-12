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
    scope_h = vpi_handle(vpiModule,signal_h);
    //scope_h = vpi_handle(vpiScope,signal_h);
    LowConn = vpi_handle(vpiLowConn, signal_h);
    
    //snprintf(buffer, sizeof(buffer), "%s_iso.%s.%s",vpi_get_str(vpiFullName,scope_h) ,vpi_get_str(vpiName,scope_h) ,vpi_get_str(vpiName, signal_h) );
    //printf("Stored string: %s\n", buffer);
    //vpi_printf("+++++++++++DEBUG_ISO:%s+++++++++++++\n",iso_name);
    int inst_num;
    module_h = vpi_handle(vpiScope,scope_h);
    if(check_name_in_list(head,vpi_get_str(vpiFullName,scope_h)))return;
    else inst_num=add_module(head, vpi_get_str(vpiFullName,scope_h));
    port_itr = vpi_iterate(vpiPort,scope_h);
    //fprintf(fp,"module %s_iso(",gen_scope_generate(vpi_get_str(vpiName,scope_h)));
    fprintf(fp,"module %s_iso_%d(",gen_scope_generate(vpi_get_str(vpiName,scope_h)),inst_num);
    //vpiHandle assignpara_itr=vpi_iterate(vpiParamAssign,scope_h);
    //vpiHandle assign_h;
    //while(assign_h=vpi_scan(assignpara_itr)){
    //  vpiHandle Lhs_h = vpi_handle(vpiLhs,assign_h);
    //  vpiHandle Rhs_h = vpi_handle(vpiRhs,assign_h);
    //  fprintf(fp,"\nDEBUG:: %s = %s(",vpi_get_str(vpiName,Lhs_h),vpi_get_str(vpiDecompile,Rhs_h));
    //}
    //vpiHandle gen_h = vpi_handle(vpiScope,scope_h);
    //vpiHandle scope_itr = vpi_iterate(vpiInternalScope,gen_h);
    //vpiHandle scope_ih;
    //while(scope_ih  = vpi_scan(scope_itr)){
    //    fprintf(fp,"DEBUG::ITR::%s",vpi_get_str(vpiType,scope_h));
    //}
    //if(gen_h!=NULL) fprintf(fp,"DEBUG:: %s",vpi_get_str(vpiType,scope_h));
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
        //if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
        //            vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
        //            fprintf(fp,"%s",vpi_get_str(vpiName,parent_h));
        //        }
        //else if(vpi_get(vpiType, HighConn)==vpiConstant) {
        //          vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
        //          s_vpi_value val = {vpiDecStrVal};
        //          //s_vpi_value val = {vpiStringVal}; 
        //          vpi_get_value(HighConn,&val);
        //          //fprintf(fp,"%s",vpi_get_str(vpiName,parent_h));
        //          //fprintf(fp,"VALUE::%s",val.value.str);
        //          //fprintf(fp,"TYPE::%d",vpi_get(vpiConstType, HighConn));
        //          //fprintf(fp,"Decompile::%s",vpi_get_str(vpiDecompile, HighConn));
        //          first_port=1;// avoid ,  ,
        //        }
        fprintf(fp,"%s", vpi_get_str(vpiName, LowConn));

    }
    fprintf(fp,");\n");
    int port_num=0;
    int str_param=0;
    port_itr = vpi_iterate(vpiPort,scope_h);
    while(port_h=vpi_scan(port_itr)){
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        switch(vpi_get(vpiDirection,port_h)){
            case vpiInput: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"input logic [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,lowConn));//parent_h
                }
                //else if(vpi_get(vpiType, HighConn)==vpiConstant) ;
                else fprintf(fp,"input  logic [%d:%d] %s;\n",getExprValue(lowConn,vpiLeftRange),getExprValue(lowConn,vpiRightRange),vpi_get_str(vpiName,lowConn));
                port_num++;
                break;
            }
            case vpiOutput: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"output logic [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,lowConn));
                }
                else fprintf(fp,"output logic [%d:%d] %s;\n",getExprValue(lowConn,vpiLeftRange),getExprValue(lowConn,vpiRightRange),vpi_get_str(vpiName,lowConn));
                port_num++;
                break;
            }
            case vpiInout: 
            {
                if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                    vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                    fprintf(fp,"inout wire [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,lowConn));
                }
                else fprintf(fp,"inout  wire  [%d:%d] %s;\n",getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiFullName,lowConn));
                port_num++;
                break;
            }
        }
    //vpi_printf("%s  %s",vpi_get_str(vpiDefName,scope_h),vpi_get_str(vpiName,scope_h));
    }
    fprintf(fp,"%s",vpi_get_str(vpiDefName,scope_h));
    vpiHandle param_itr = vpi_iterate(vpiParameter,scope_h);
    vpiHandle param_h=vpi_scan(param_itr);
    if(param_h) fprintf(fp,"#(",vpi_get_str(vpiDefName,scope_h));
    while(param_h){
      str_param=0;
      s_vpi_value val = {vpiDecStrVal};
      //s_vpi_value val = {vpiStringVal};
      //val.format = vpi_get(vpiConstType,param_h);
      if(vpi_get(vpiConstType,param_h)==vpiStringConst) val.format = vpiStringVal;
      vpi_get_value(param_h,&val);
      //fprintf(fp,"DEBUG::%d",atoi(val.value.str));
      char* param_char = (char*)malloc(strlen(val.value.str)+3);
      if(vpi_get(vpiConstType,param_h)!=vpiStringConst&&atoi(val.value.str)==1297108037){
        val.format = vpiStringVal;
        vpi_get_value(param_h,&val);
        blank_cut(val.value.str);
        str_param=1;
      }
      
      if(vpi_get(vpiConstType,param_h)==vpiStringConst||str_param) sprintf(param_char,"\"%s\"",val.value.str);//sprintf pass char to first p point mem 
      else param_char = val.value.str;
      fprintf(fp,".%s(%s)",vpi_get_str(vpiName,param_h),param_char);

      //fprintf(fp,"FullName::%s,Name::%s\n",vpi_get_str(vpiName,param_h),vpi_get_str(vpiDecompile,param_h));
      //fprintf(fp,"Decompile:%s\n",vpi_get_str(vpiDecompile,param_h));
      //fprintf(fp,"TYPE::%s;VALUE::%s\n",vpi_get_str(vpiConstType,param_h),val.value.str);
      param_h=vpi_scan(param_itr);
      if(param_h!=NULL) fprintf(fp,",");
      else fprintf(fp,")");
    }
    fprintf(fp,"  %s(",gen_scope_generate(vpi_get_str(vpiName,scope_h)));
    int i;
    port_itr = vpi_iterate(vpiPort,scope_h);
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        char* high_port = vpi_get_str(vpiName,lowConn);
        //if (vpi_get(vpiType, HighConn)==vpiConstant) high_port=vpi_get_str(vpiDecompile, HighConn);
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
              if(vpi_get(vpiType, HighConn)==vpiPartSelect) {
                          vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                          fprintf(fp,"force %s[%d:%d] = %s;\n",vpi_get_str(vpiFullName,parent_h),getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange),vpi_get_str(vpiName,lowConn));
              }
              else fprintf(fp,"force %s = %s ; \n", vpi_get_str(vpiFullName,HighConn),vpi_get_str(vpiName,lowConn));
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
    fprintf(fp,"bind  %s %s_iso_%d %s_iso(",vpi_get_str(vpiFullName,module_h),gen_scope_generate(vpi_get_str(vpiName,scope_h)),inst_num,gen_scope_generate(vpi_get_str(vpiName,scope_h))); 
    port_itr = vpi_iterate(vpiPort,scope_h);
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        vpiHandle lowConn  = vpi_handle(vpiLowConn, port_h);
        vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
        char* bind_port = vpi_get_str(vpiName,HighConn);
        if(vpi_get(vpiDirection,port_h)==vpiOutput) sprintf(bind_port," ");
        if(vpi_get(vpiType, HighConn)==vpiConstant) bind_port = vpi_get_str(vpiDecompile,HighConn);
        else if(vpi_get(vpiType, HighConn)==vpiPartSelect) sprintf(bind_port,"%s[%d:%d]",vpi_get_str(vpiFullName,parent_h),getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange));
        if(i<port_num-1)fprintf(fp,".%s(%s),",vpi_get_str(vpiName,lowConn),bind_port);
        else fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,lowConn),bind_port);
    }
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
    new_module->name     = strdup(name); // 复制字符串
    new_module->map_name = (char*)malloc(strlen(name)+5);
    
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
        //printf("%s",current->name);
        //printf("%s",input_name);
        if (strcmp(current->name, input_name) == 0) {
            return 1; // 找到匹配的名字
        }
        current = current->next;
    }
    return 0; // 未找到匹配的名字
}

int add_module(Module** head, const char* name) {
    int iso_num=0;
    Module* new_module = create_mod(name);
    if (*head == NULL) {
        // 如果链表为空，设置新模块为头节点
        //vpi_printf("BEFORE::Added module to the end: %s\n", (*head)->name);
        *head = new_module;
    } else {
        iso_num=1;
        // 遍历链表找到最后一个节点
        Module* current = *head;
        while (current->next != NULL) {
            current = current->next;
            iso_num=iso_num+1;
        }
        current->next = new_module;
    }
    //vpiHandle ins_h = vpi_handle_by_name(name);
    //snprintf(new_module->map_name,"%s_%d",vpi_get_str(vpiName,ins_h),iso_num);
    return iso_num;
}

void iso_itr(PortInfoNode**  port_list_head,Module** iso_inst_head){
    PortInfoNode* current = *port_list_head;
    while (current != NULL) {
        if (current->alias == 1) iso_gen(current->internalName,iso_inst_head);
        current = current->next;
    }

}

char* iso_exchange(char* singal_name){
    vpiHandle signal_h,scope_h,mod_h;
    signal_h=vpi_handle_by_name(singal_name,0);
    mod_h   = vpi_handle(vpiScope,signal_h);
    scope_h =vpi_handle(vpiScope,mod_h);

    const char* scopeName = vpi_get_str(vpiFullName, scope_h);
    const char* modName = gen_scope_generate(vpi_get_str(vpiName, mod_h));
    const char* signalName = vpi_get_str(vpiName, signal_h);
    size_t total_length = 2*strlen(modName) + strlen("_iso.") + strlen(scopeName) + 2*strlen(".") + strlen(signalName) + 1;
    char* iso_name = (char*)malloc(total_length);
    iso_name[0] = '\0';
    strcat(iso_name, scopeName);
    //vpi_printf("DEBUG::%s\n",scopeName);
    strcat(iso_name, ".");
    strcat(iso_name, modName);
    strcat(iso_name, "_iso.");
    strcat(iso_name, modName);
    //vpi_printf("DEBUG::%s\n",modName);
    strcat(iso_name, ".");
    strcat(iso_name, signalName);
    //vpi_printf("DEBUG::%s\n",signalName);
    return iso_name;
}

//char* gen_scope_generate(const char* mod_name) {
//    const char* dot_position = strchr(mod_name, '.');
//    if (dot_position == NULL) {
//        return strdup(mod_name); // 复制原字符串并返回
//    }
//    //vpi_printf("DEBUG::%s",strdup(dot_position + 1));
//    // 返回符号 . 之后的内容
//    return strdup(dot_position + 1);
//}

char* gen_scope_generate(const char* mod_name) {
    // 计算输入字符串的长度
    size_t length = strlen(mod_name);
    // 为新字符串分配内存，长度加1以包含终止符
    char* new_string = (char*)malloc(length + 1);
    if (new_string == NULL) {
        fprintf(stderr, "内存分配失败\n");
        exit(1);
    }
    size_t i;
    // 复制并替换字符
    for ( i = 0; i < length; ++i) {
        if (mod_name[i] == '.'|| mod_name[i]=='['||mod_name[i]==']') {
            new_string[i] = '_'; // 将 '.' 替换为 '_'
        } 
        else{
            new_string[i] = mod_name[i];
        }
    }
    new_string[length] = '\0'; // 确保字符串以 '\0' 结束

    return new_string;
}


void blank_cut(char* p) {
    char* start = p; // 保存原始指针
    char* trimmed_start = p; // 用于寻找第一个非空格字符

    // 跳过所有空格
    while (*trimmed_start && isspace((unsigned char)*trimmed_start)) {
        trimmed_start++;
    }

    // 将去掉前导空格后的内容移动到字符串的开头
    if (trimmed_start != start) {
        while (*trimmed_start) {
            *start++ = *trimmed_start++;
        }
        *start = '\0'; // 添加字符串结束符
    }
}

void hierarchy_replace(char* p) {
    while (*p != '\0') { // 当字符串没有结束时
        if (*p == '.') { // 如果当前字符是'.'
            *p = '_'; // 将其替换为'_'
        }
        p++; // 移动到下一个字符
    }
}
