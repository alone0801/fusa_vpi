#include "iso.h"

void concur_gen(int con_num, char* dut_full_name ){
    vpiHandle tb_h,dut_h,HighConn,lowConn,parent_h,port_itr,port_h;
    int i,j;
    int str_param=0;
    FILE *fp=fopen("fi_wrapper.sv", "a");
    dut_h = vpi_handle_by_name(dut_full_name,0);
    //printf("----------------DEBUG--------------:dut_name:%s ---------------\n",dut_full_name);
    if(dut_h==NULL) {
        printf("didn't specify correct full hiearchy of dut instation in FI.xml , concurrent simulation off\n");
        return;
    }
    /*
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
               data1[i] <= data2[i]; 
        end
    end
     */
    tb_h = vpi_handle(vpiModule,dut_h);
    if (fp == NULL) {
        printf("Error opening file 'fi_wrapper' while generating iso_module,please run good_sim first .\n");
        return;
    }
    if(con_num==0) return;
    //printf("----------------DEBUGAAAAA-------------------------\n");
    for ( j = 1; j <= con_num; j++) {
        fprintf(fp,"bind  %s %s ",vpi_get_str(vpiFullName,tb_h),vpi_get_str(vpiDefName,dut_h));
        //pass param to dut
        vpiHandle param_itr = vpi_iterate(vpiParameter,dut_h);
        //if(param_itr == NULL)
           // printf("param_itr is NULL\n");
        if(param_itr) {
            vpiHandle param_h=vpi_scan(param_itr);
            if(param_h) fprintf(fp,"#(");
            //printf("----------------DEBUGBBBBB-------------------------\n");
            while(param_h){
                if(vpi_get(vpiLocalParam, param_h) != 1){
                    str_param=0;
                    s_vpi_value val = {vpiDecStrVal};
                    if(vpi_get(vpiConstType,param_h)==vpiStringConst) val.format = vpiStringVal;
                    vpi_get_value(param_h,&val);
                    char* param_char = (char*)malloc((strlen(val.value.str)+3)*sizeof(char));
                    if(vpi_get(vpiConstType,param_h)!=vpiStringConst&&atoi(val.value.str)==1297108037){
                        val.format = vpiStringVal;
                        vpi_get_value(param_h,&val);
                        blank_cut(val.value.str);
                        str_param=1;
                    }
                    if(vpi_get(vpiConstType,param_h)==vpiStringConst||str_param) sprintf(param_char,"\"%s\"",val.value.str); 
                    else sprintf(param_char,val.value.str);
                    fprintf(fp,".%s(%s)",vpi_get_str(vpiName,param_h),param_char);
                    //printf(".%s(%s)\n",vpi_get_str(vpiName,param_h),param_char);
                    free(param_char);
                    param_h=vpi_scan(param_itr);
                    if(param_h!=NULL){
                        if(vpi_get(vpiLocalParam, param_h) != 1)
                            fprintf(fp,",");
                    }
                    else fprintf(fp,")");
                }
                else{
                    param_h=vpi_scan(param_itr);
                    if(param_h==NULL) fprintf(fp,")");
                }
            }
        }
        //if(param_itr != NULL) vpi_free_object(param_itr);
        //printf("----------------DEBUGCCCCC-------------------------\n");
        fprintf(fp,"concur_%d( ",j);
        int port_num=0;
        port_itr = vpi_iterate(vpiPort,dut_h);
        if(port_itr != NULL){
            while(port_h=vpi_scan(port_itr)) port_num++;
        }
        //printf("port_num == %d\n",port_num);
        port_itr = vpi_iterate(vpiPort,dut_h);
        for(i=0 ; i<port_num ; i++) {
            port_h=vpi_scan(port_itr);
            vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
            vpiHandle lowConn  = vpi_handle(vpiLowConn, port_h);
            vpiHandle parent_h;
            char* bind_port;
            if(HighConn != NULL)
            {
                if(vpi_get(vpiDirection,port_h)==vpiOutput) bind_port = strdup(" ");
                else if(vpi_get(vpiType, HighConn)==vpiConstant) bind_port = strdup(vpi_get_str(vpiDecompile,HighConn));
                else if(vpi_get(vpiType, HighConn)==vpiPartSelect){
                    parent_h =vpi_handle(vpiParent,HighConn);
                    int size = 3 + strlen(vpi_get_str(vpiFullName,parent_h)) + 10 + 1;
                    bind_port = (char*)malloc(size*sizeof(char));
                    sprintf(bind_port, "%s[%d:%d]",vpi_get_str(vpiFullName,parent_h),getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange));
                }
                else
                    bind_port = strdup(vpi_get_str(vpiFullName,HighConn));
            }
            else
                bind_port = strdup(" ");
            //printf("___%s__DEBUG______%s______\n",vpi_get_str(vpiName,lowConn),bind_port);
            if(i<port_num-1)fprintf(fp,".%s(%s),",vpi_get_str(vpiName,lowConn),bind_port);
            else fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,lowConn),bind_port);
            if(bind_port != NULL) free(bind_port);
            //printf("----------------DEBUGEEEEE-------------------------\n");
        }
    }
    fclose(fp);
}

void iso_gen(char* port_name, Module** head){
    vpiHandle signal_h,scope_h,parent_scope_h,port_itr,port_h,l_range_h,r_range_h,HighConn,LowConn;
    char* inst_name ;    //char buffer[256];
    signal_h = vpi_handle_by_name(port_name,0);
    FILE *fp=fopen("fi_wrapper.sv", "a");
    if (fp == NULL) {
        printf("Error opening file 'fi_wrapper' while generating iso_module,please run good_sim first .\n");
        return;
    }
    //redirect_stdout_to_file("fi_wrapper.sv");
    scope_h = vpi_handle(vpiModule,signal_h);
    //scope_h = vpi_handle(vpiScope,signal_h);
    parent_scope_h = vpi_handle(vpiModule,scope_h);
    //snprintf(buffer, sizeof(buffer), "%s_iso.%s.%s",vpi_get_str(vpiFullName,scope_h) ,vpi_get_str(vpiName,scope_h) ,vpi_get_str(vpiName, signal_h) );
    //printf("Stored string: %s\n", buffer);
    //vpi_printf("+++++++++++DEBUG_ISO:%s+++++++++++++\n",iso_name);
    int inst_num;
    //module_h = vpi_handle(vpiScope,scope_h);
    if(check_name_in_list(head,vpi_get_str(vpiFullName,scope_h)))return;
    else inst_num=add_module(head, vpi_get_str(vpiFullName,scope_h));
    port_itr = vpi_iterate(vpiPort,scope_h);
    //fprintf(fp,"module %s_iso(",gen_scope_generate(vpi_get_str(vpiName,scope_h)));
    fprintf(fp,"module %s_iso_%d(",gen_scope_generate(vpi_get_str(vpiName,scope_h)),inst_num);
    port_itr = vpi_iterate(vpiPort,scope_h);
    int first_port = 1; // 用于标记第一个端口
    if(port_itr != NULL){
        while (port_h = vpi_scan(port_itr)) {
            //vpi_printf("port_h type is %d\n", vpi_get(vpiType, port_h));
            HighConn = vpi_handle(vpiHighConn, port_h);
            LowConn = vpi_handle(vpiLowConn, port_h);
        
            if (!first_port) {
                fprintf(fp,", ");
            } else {
                first_port = 0;
            }
            fprintf(fp,"%s", vpi_get_str(vpiName, LowConn));
        }
    }
    fprintf(fp,");\n");
    int port_num=0;
    int str_param=0;
    int is_vector;
    port_itr = vpi_iterate(vpiPort,scope_h);
    if(port_itr != NULL){
    while((port_h=vpi_scan(port_itr)) != NULL){
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        //vpi_printf("lowConn name: %s, lowConn type: %d, lowConn size:%d\n",vpi_get_str(vpiName,lowConn), vpi_get(vpiType, lowConn), vpi_get(vpiSize,lowConn));
        //vpi_printf("highConn name: %s, highConn type: %d\n",vpi_get_str(vpiName,HighConn), vpi_get(vpiType, HighConn));
        is_vector = vpi_get(vpiVector, lowConn);
        switch(vpi_get(vpiDirection,port_h)){
            case vpiInput: 
            {
                if(is_vector){
                    fprintf(fp, "input logic [%d:%d] %s;\n", vpi_get(vpiSize, lowConn) - 1, 0, vpi_get_str(vpiName,lowConn));
                    fprintf(fp, "wire [%d:%d] %s_w;\n", vpi_get(vpiSize, lowConn) - 1, 0, vpi_get_str(vpiName,lowConn));
                }
                else{
                    fprintf(fp, "input logic %s;\n", vpi_get_str(vpiName, lowConn));
                    fprintf(fp, "wire %s_w;\n", vpi_get_str(vpiName, lowConn));
                }
                port_num++;
                break;
            }
            case vpiOutput: 
            {
                if(is_vector)
                    fprintf(fp, "output logic [%d:%d] %s;\n", vpi_get(vpiSize, lowConn) - 1, 0, vpi_get_str(vpiName,lowConn));
                    //fprintf(fp, "wire [%d:%d] %s_w;\n", vpi_get(vpiSize, lowConn) - 1, 0, vpi_get_str(vpiName,lowConn));

                else
                    fprintf(fp, "output logic %s;\n", vpi_get_str(vpiName, lowConn));
                    //fprintf(fp, "wire %s_w;\n", vpi_get_str(vpiName, lowConn));
                port_num++;
                break;
            }
            case vpiInout: 
            {
                if(is_vector)
                    fprintf(fp, "inout wire [%d:%d] %s;\n", vpi_get(vpiSize, lowConn) - 1, 0, vpi_get_str(vpiName,lowConn));
                else
                    fprintf(fp, "inout wire %s;\n", vpi_get_str(vpiName, lowConn));
                port_num++;
                break;
            }
        }
    }
    }

    port_itr = vpi_iterate(vpiPort,scope_h);
    if(port_itr != NULL){
    while(port_h=vpi_scan(port_itr)){
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        switch(vpi_get(vpiDirection,port_h)){
            case vpiInput: 
            {
                fprintf(fp,"assign %s_w = %s;\n", vpi_get_str(vpiName, lowConn), vpi_get_str(vpiName, lowConn));
                break;
            }
            case vpiOutput: 
            {
                //fprintf(fp,"assign %s_w = %s\n", vpi_get_str(vpiName, lowConn), vpi_get_str(vpiName, lowConn));
                break;
            }
        }
    }
    }

    //vpi_printf("debugA\n");
    fprintf(fp,"%s",vpi_get_str(vpiDefName,scope_h));
    vpiHandle param_itr = vpi_iterate(vpiParameter,scope_h);
    if(param_itr != NULL){
    vpiHandle param_h=vpi_scan(param_itr);
    fprintf(fp,"#(",vpi_get_str(vpiDefName,scope_h));
    while(param_h){
        if(vpi_get(vpiLocalParam, param_h) != 1){
            str_param=0;
            s_vpi_value val = {vpiDecStrVal};
            if(vpi_get(vpiConstType,param_h)==vpiStringConst) val.format = vpiStringVal;
            vpi_get_value(param_h,&val);
            char* param_char = (char*)malloc((strlen(val.value.str)+3) * sizeof(char));
            if(vpi_get(vpiConstType,param_h)!=vpiStringConst&&atoi(val.value.str)==1297108037){
                val.format = vpiStringVal;
                vpi_get_value(param_h,&val);
                blank_cut(val.value.str);
                str_param=1;
            }
            if(vpi_get(vpiConstType,param_h)==vpiStringConst||str_param) sprintf(param_char,"\"%s\"",val.value.str);//sprintf pass char to first p point mem 
            else strcpy(param_char, val.value.str);
            fprintf(fp,".%s(%s)",vpi_get_str(vpiName,param_h),param_char);
            free(param_char);
            param_h=vpi_scan(param_itr);
            if(param_h!=NULL){
                if(vpi_get(vpiLocalParam, param_h) != 1)
                    fprintf(fp,",");
            }
            else fprintf(fp,")");
        }
        else{
            param_h = vpi_scan(param_itr);
            if(param_h == NULL) fprintf(fp, ")");
        }
    }
    }
    fprintf(fp,"  %s(",gen_scope_generate(vpi_get_str(vpiName,scope_h)));
    int i;
    port_itr = vpi_iterate(vpiPort,scope_h);
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        vpiHandle lowConn = vpi_handle(vpiLowConn, port_h);
        //if (vpi_get(vpiType, HighConn)==vpiConstant) high_port=vpi_get_str(vpiDecompile, HighConn);
        if(i<port_num-1){
            if(vpi_get(vpiDirection, port_h) == vpiInput)
                fprintf(fp,".%s(%s_w),",vpi_get_str(vpiName,lowConn), vpi_get_str(vpiName,lowConn));
            else
                fprintf(fp,".%s(%s),",vpi_get_str(vpiName,lowConn), vpi_get_str(vpiName,lowConn));
        }
        else{
            if(vpi_get(vpiDirection, port_h) == vpiInput)
                fprintf(fp,".%s(%s_w));\n",vpi_get_str(vpiName,lowConn), vpi_get_str(vpiName,lowConn));
            else
                fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,lowConn), vpi_get_str(vpiName,lowConn));
        }
    }
    //vpi_printf("debugB\n");
    fprintf(fp,"reg flag;\n");
    fprintf(fp,"always@(flag) begin\n");
    fprintf(fp,"if(flag) begin\n");
    port_itr = vpi_iterate(vpiPort,scope_h);
    if(port_itr != NULL){
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
    }
    fprintf(fp,"end\n");
    fprintf(fp,"else begin\n");
    port_itr = vpi_iterate(vpiPort,scope_h);
    if(port_itr){
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
                    fprintf(fp,"release %s[%d:%d] ;\n",vpi_get_str(vpiFullName,parent_h),getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange));
                }
                else fprintf(fp,"release %s ; \n", vpi_get_str(vpiFullName,HighConn));
                break;
            }
            case vpiInout: 
            {
                fprintf(fp,"This version don't support");
                break;
            }
        }
    }
    }
    fprintf(fp,"end\n");
    fprintf(fp,"end\n");
    fprintf(fp,"endmodule\n");
    //vpi_printf("debugC\n");
    fprintf(fp,"bind  %s %s_iso_%d %s_iso(",vpi_get_str(vpiFullName,parent_scope_h),gen_scope_generate(vpi_get_str(vpiName,scope_h)),inst_num,gen_scope_generate(vpi_get_str(vpiFullName,scope_h))); 
    port_itr = vpi_iterate(vpiPort,scope_h);
    char* bind_port;
    for(i=0 ; i<port_num ; i++) {
        port_h=vpi_scan(port_itr);
        vpiHandle HighConn = vpi_handle(vpiHighConn, port_h);
        vpiHandle lowConn  = vpi_handle(vpiLowConn, port_h);

        if(HighConn != NULL){
            if(vpi_get(vpiDirection,port_h)==vpiOutput) bind_port = strdup(" ");
            else if(vpi_get(vpiType, HighConn)==vpiConstant) bind_port = strdup(vpi_get_str(vpiDecompile,HighConn));
            else if(vpi_get(vpiType, HighConn)==vpiPartSelect){
                vpiHandle parent_h =vpi_handle(vpiParent,HighConn);
                int size = 3 + strlen(vpi_get_str(vpiFullName, parent_h)) + 10 + 1;
                bind_port = (char*)malloc(size*sizeof(char));
                sprintf(bind_port,"%s[%d:%d]",vpi_get_str(vpiFullName,parent_h),getExprValue(HighConn,vpiLeftRange),getExprValue(HighConn,vpiRightRange));
            }
            else
                bind_port = strdup(vpi_get_str(vpiFullName, HighConn));
        }
        else
            bind_port = strdup(" ");
        if(i<port_num-1)fprintf(fp,".%s(%s),",vpi_get_str(vpiName,lowConn),bind_port);
        else fprintf(fp,".%s(%s));\n",vpi_get_str(vpiName,lowConn),bind_port);
        if(bind_port != NULL) free(bind_port);
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
    new_module->map_name = (char*)malloc((strlen(name)+5)*sizeof(char));
    
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
//add the fucntion to force the output port replacing original module while mapping fault injetion point
char* iso_exchange(char* singal_name){
    vpiHandle signal_h, signal_type, real_signal_h, scope_h,mod_h,port_itr;
    signal_h=vpi_handle_by_name(singal_name,0);
    signal_type = vpi_get(vpiType, signal_h);
    if(signal_type == vpiNetBit || signal_type == vpiRegBit || signal_type == vpiPortBit)
        real_signal_h = vpi_handle(vpiParent, signal_h);
    else
        real_signal_h = signal_h;
    mod_h   = vpi_handle(vpiModule, real_signal_h);
    scope_h = vpi_handle(vpiModule, mod_h);
    const char* scopeName = strdup(vpi_get_str(vpiFullName, scope_h));
    const char* modName = gen_scope_generate(vpi_get_str(vpiName, mod_h));
    const char* wrapperName = gen_scope_generate(vpi_get_str(vpiFullName, mod_h));
    const char* signalName = strdup(vpi_get_str(vpiName, signal_h));
    size_t total_length = strlen(wrapperName) + strlen(modName) + strlen("_iso.") + strlen(scopeName) + 2*strlen(".") + strlen(signalName) + 1;
    size_t flag_length = strlen(wrapperName) + strlen(modName) + strlen("_iso.") + strlen(scopeName) + 2*strlen(".") + 4 + 1;   

    char* iso_name = (char*)malloc(total_length*sizeof(char));
    char* flag_name = (char*)malloc(flag_length*sizeof(char));
    iso_name[0] = '\0';
    strcat(iso_name, scopeName);
    strcat(iso_name, ".");
    strcat(iso_name, wrapperName); 
    strcat(iso_name, "_iso.");
    strcat(flag_name,iso_name);
    strcat(flag_name,"flag");
    iso_flag_en(flag_name);
    strcat(iso_name, modName);
    strcat(iso_name, ".");
    strcat(iso_name, signalName);
    free(scopeName);
    free(wrapperName);
    free(signalName);
    free(flag_name);
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
    char* tmp = strdup(mod_name);
    // 为新字符串分配内存，长度加1以包含终止符
    char* new_string = (char*)malloc((length + 1)*sizeof(char));
    if (new_string == NULL) {
        fprintf(stderr, "内存分配失败\n");
        exit(1);
    }
    size_t i;
    // 复制并替换字符
    for ( i = 0; i < length; ++i) {
        if (tmp[i] == '.'|| tmp[i]=='['|| tmp[i]==']') {
            new_string[i] = '_'; // 将 '.' 替换为 '_'
        } 
        else{
            new_string[i] = tmp[i];
        }
    }
    new_string[length] = '\0'; // 确保字符串以 '\0' 结束
    free(tmp);
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

void iso_flag_en(char* p) {
    PLI_INT32 flag = vpiForceFlag; 
    vpiHandle signal_handle;
    s_vpi_value fault_value = { vpiIntVal, { 0 } };
    s_vpi_time  time_s = { vpiSimTime, 0, 0, 0.0 };
    signal_handle = vpi_handle_by_name(p,0);
        if(signal_handle == 0)
            {
                vpi_printf((PLI_BYTE8*) "FUSA_ERROR: unable to locate hdl path (%s) for iso_flag\n",p);
            }
        else
        {
            fault_value.format = vpiIntVal;
            fault_value.value.integer = 1;
            vpi_put_value(signal_handle, &fault_value, &time_s, flag);
        }
}
