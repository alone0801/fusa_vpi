#include "port_alias.h"


PortInfoNode* portInfoList = NULL;  // 全局变量用于存储端口信息链表
PortInfoNode* createNode(const char* internalName, const char* externalName);
void appendNode(PortInfoNode** head, const char* internalName, const char* externalName);
void freeList(PortInfoNode* head);
void printList(PortInfoNode **head);


// 创建一个新节点
PortInfoNode* createNode(const char* internalName, const char* externalName) {
    PortInfoNode* newNode = (PortInfoNode*)malloc(sizeof(PortInfoNode));
    if (newNode != NULL) {
        strcpy(newNode->internalName, internalName);
        strcpy(newNode->externalName, externalName);
        newNode->alias = 1;
        newNode->root  = 0;
        newNode->map_name = NULL;
        newNode->next = NULL;
    }
    return newNode;
}

// 将节点追加到链表末尾
void appendNode(PortInfoNode** head, const char* internalName, const char* externalName) {
    PortInfoNode* newNode = createNode(internalName, externalName);
    if (newNode == NULL) {
        fprintf(stderr, "Memory allocation error.\n");
        exit(EXIT_FAILURE);
    }
    if (*head == NULL) {
        // 链表为空，将新节点作为头节点
        *head = newNode;
    } else {
        // 找到链表末尾，并将新节点连接到末尾
        PortInfoNode* current = *head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newNode;
    }
    // printf(internalName);
    // printf("\n");
}

void printList(PortInfoNode **head) {
    PortInfoNode *current = *head;
    PortInfoNode *current_log = *head;
    // while (current != NULL) {
    //     vpi_printf("Internal: %s, External: %s\n", current->internalName, current->externalName);
    //     current = current->next;
    // }
    FILE *logfile = fopen("port.log", "w");
    if (logfile == NULL) {
        vpi_printf("ERROR: Could not open port.log for writing\n");
        return 0;
    }
    while (current_log != NULL) {
    fprintf(logfile, "port_name: %s, port_driver: %s, alias_type: %d, root: %d\n", current_log->internalName, current_log->externalName,current_log->alias,current_log->root);
    current_log = current_log->next;
    }
    fclose(logfile);

}


void port_tranverse(vpiHandle mod_h, int top,PortInfoNode** head)
{
    vpiHandle   port_itr, port_h, lowconn_h, highconn_h, portbit_handle, pbiter_handle,sub_iterater,sub_handle;
    int is_vector;
    int direction;
    char* Highconn;
    // mod_h = vpi_handle_by_name("test.dut_inst.mem2_i", 0);
    // 获取端口迭代器
    port_itr = vpi_iterate(vpiPort, mod_h);
    if (!port_itr) {
        return 0;
    }
    // 遍历端口
    while (port_h = vpi_scan(port_itr)) {
        is_vector = vpi_get(vpiVector, port_h);
        direction = vpi_get(vpiDirection, port_h);
        if(direction!=vpiInput)continue;
        if (is_vector) {
            // 处理矢量端口
            pbiter_handle = vpi_iterate(vpiRegBit, port_h);
            if (pbiter_handle) {
                portbit_handle = vpi_scan(pbiter_handle);
//                while (portbit_handle) {
//                    lowconn_h = vpi_handle(vpiLowConn, portbit_handle);
//                    highconn_h = vpi_handle(vpiHighConn, portbit_handle);
                    // 将端口信息添加到链表
                    // printf(vpi_get_str(vpiFullName, lowconn_h));
                    // printf("\n");
//                    if (top) {
//                        appendNode(head, strdup(vpi_get_str(vpiFullName, lowconn_h)), "NULL");
//                    }
//                    else {
                        //HighConn=vpi_get_str(vpiFullName, highconn_h);
//                        if(!vpi_get_str(vpiFullName, highconn_h)) appendNode(head, strdup(vpi_get_str(vpiFullName, lowconn_h)), "NULL");
//                        else appendNode(head, strdup(vpi_get_str(vpiFullName, lowconn_h)), strdup(vpi_get_str(vpiFullName, highconn_h)));
//                    }
//                    portbit_handle = vpi_scan(pbiter_handle);
//                }
                // vpi_free_object(pbiter_handle);
            }
        } else {
            // 处理标量端口
//            lowconn_h = vpi_handle(vpiLowConn, port_h);
//            highconn_h = vpi_handle(vpiHighConn, port_h);
//            if (top || !vpi_get_str(vpiFullName, highconn_h)) appendNode(head, strdup(vpi_get_str(vpiFullName, lowconn_h)), "NULL");
//            else appendNode(head, strdup(vpi_get_str(vpiFullName, lowconn_h)), strdup(vpi_get_str(vpiFullName, highconn_h)));
        }
    }
  sub_iterater = vpi_iterate(vpiModule, mod_h);
  if (sub_iterater != NULL)
  while ( (sub_handle = vpi_scan(sub_iterater)) != NULL ){
    port_tranverse(sub_handle , 0 , head);
  }
  // if (sub_iterater == NULL) printList(&portInfoList);
}

void port_isolate(vpiHandle mod_h,PortInfoNode** head)
{
    port_tranverse(mod_h, 1,head);
}

void alias_opt(PortInfoNode** head) {
    PortInfoNode *current = *head;
    while (current != NULL) {
        PortInfoNode *other = *head;
        if (current->root == 1){
            current = current->next;  //如果此节点已经到达驱动顶层
            continue;
        }
        while (other != NULL) {
            // 检查是否是不同的节点且 externalName 与其他节点的 internalName 相等
            if (current != other && strcmp(current->externalName, other->internalName) == 0 ) {
                if (other->root == 1&& other->alias==0) {
                  strcpy(current->externalName, other->internalName); //root = 1 alias = 0 ---> prime port ,end
                  current->root  = 1;
                  } //到达顶端要标识 否则会进入无限循环
                else if (other->root == 1&& other->alias==1) {
                    strcpy(current->externalName, other->externalName); //root = 1 alias = 1 ---> alias port but end , end too
                    current->root  = 1;
                   }
                else if (other->root == 0&& other->alias==1) {
                     strcpy(current->externalName, other->externalName); //root = 0 alias = 1 ---> alias port not end , do not end
                    }
            break;
                // printf(current->externalName);
                // printf("\n");
            }
            
            other = other->next;
        }

        current = current->next;
    }
}

void process_aliases(PortInfoNode** head) {
    int hasUnprocessedNodes;
    do {
        hasUnprocessedNodes = 0;
        PortInfoNode *current = *head;
        while (current != NULL) {
            if (current->root == 0) {
                hasUnprocessedNodes = 1;
                break;
            }
            current = current->next;
            printf(hasUnprocessedNodes);
        }

        if (hasUnprocessedNodes) {
            alias_opt(head);
        }
        else break;
    } while (hasUnprocessedNodes);
}


PLI_INT32 PLIbook_PortInfo_calltf(PLI_BYTE8 *user_data)
{
    vpiHandle systf_h, mod_h, test_h, use_h, itr, event_h, Stmt_h, Stmt_itr_h,group_h,
     Left_h, process_h, net_h , reg_h, var_h, op_h;
    int is_vector;
    char *prot_name,*driver_name;

    /* 获取模块句柄 */
    systf_h = vpi_handle(vpiSysTfCall, NULL);
    mod_h = vpi_handle_by_name("test_new.test_ins", 0);
    port_isolate(mod_h,&portInfoList);
    process_aliases(&portInfoList);
    printList(&portInfoList);

    test_h = vpi_handle_by_name("test_new.test_ins",0);
    printf(vpi_get_str(vpiType, test_h));
    printf("\n");
//    itr = vpi_iterate(vpiProcess,test_h);
    // Stmt_itr_h = vpi_iterate(vpiStmt,mod_h);
    // Stmt_h = vpi_scan(Stmt_itr_h);
    // itr = vpi_iterate(vpiContAssign,mod_h);
    while(process_h = vpi_scan(itr)){
      vpi_printf("process_h's type is : %s\n", vpi_get_str(vpiType, process_h));
//      Stmt_h = vpi_handle(vpiStmt, process_h);
      if(!Stmt_h) printf("no handle of Stmt_h\n");
//      Stmt_itr_h = vpi_iterate(vpiStmt,process_h);
      group_h =  vpi_scan(Stmt_itr_h);
      printf("Stmt_itr_h is %s",vpi_get_str(vpiType, Stmt_itr_h));
      printf("\n");
    }
    net_h = vpi_handle_by_name("test_new.test_ins.d",0);
//    event_h = vpi_iterate(vpiDriver,net_h);
//    use_h = vpi_scan(event_h);
    // use_h = vpi_scan(event_h);
//    op_h = vpi_handle(vpiParent, use_h);
//    var_h = vpi_handle(vpiRhs,use_h);
    printf("net driver is %s\n",vpi_get_str(vpiType ,use_h));
    traverseExpr(var_h);
    printf("\n");
    return 0;
}

 void traverseExpr(vpiHandle expr)
 {
    vpiHandle subExprI, subExprH;
//    switch (vpi_get(vpiExpr,expr))
//    {
//      case vpiOperation:
//        subExprI = vpi_iterate(vpiOperand, expr);
//        if (subExprI)
//          while (subExprH = vpi_scan(subExprI))
//            traverseExpr(subExprH);
        /* else it is of op type vpiNullOp */
//        break;
//      default:
      /* Do whatever to the leaf object. */
//      break;
    }
// }
//void port_alias(char* mod_name , PortInfoNode** head){
void port_alias(StringList* mod_names, PortInfoNode** head){
    vpiHandle mod_h;
    int i ;
    for ( i = 0; i < mod_names->count; i++) {
        mod_h = vpi_handle_by_name(mod_names->strings[i], 0);
        port_isolate(mod_h,head);
    }
    process_prime(head); 
    process_aliases(head);  
    //printList(head);
}

void process_prime(PortInfoNode** head) {
  PortInfoNode *current = *head;
    while (current != NULL) {
        PortInfoNode *other = *head;
        int meet_alias = 0;
        while (other != NULL) {
            if (current != other && strcmp(current->externalName, other->internalName) == 0 ) {
                meet_alias =  1;
                break;
            }
            other = other->next;
        }
        if (!meet_alias) {
          current->alias = 0;
          current->root  = 1;
          }
        current = current->next;
    }
}

//because of isolation module instrument , non-port var also need to be map to iso
char* check_alias(const char* node_name, PortInfoNode**  head) {
    PortInfoNode* current = *head;
    while (current != NULL) {
        if (strcmp(current->internalName, node_name) == 0) {
        //vpiHandle iso_mod_h,signal_mod_h,iso_port_h,signal_h;
        //iso_port_h = vpi_handle_by_name(current->internalName,0);
        //signal_h   = vpi_handle_by_name(node_name,0);
        //if(signal_h==NULL) return node_name;//??
        //iso_mod_h    = vpi_handle(vpiScope,iso_port_h);
        //signal_mod_h = vpi_handle(vpiScope,signal_h);
        //if (strcmp(vpi_get_str(vpiFullName,iso_mod_h),vpi_get_str(vpiFullName,signal_mod_h))==0) {
            if (current->alias == 1) {
                vpi_printf("DEBUG::THIS NODE WILL BACKWORD PROPAGATING\n");
                return iso_exchange(node_name);
            } else {
                return current->internalName;
            }
        }
        current = current->next;
    }
    printf("DEBUG_ISO:NOT_MATRCH\n");
    // If node_name does not exist in the list, return the node_name itself
    return node_name;
}

void register_port_alias(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$port_alias";
    tf_data.calltf=PLIbook_PortInfo_calltf;
    tf_data.compiletf=NULL;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_port_alias();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_port_alias,
//  NULL /*** final entry must be 0 ***/
//};
