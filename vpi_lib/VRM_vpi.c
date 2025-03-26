#include "vpi_user.h"
#include <stdlib.h>
#include <string.h>

typedef struct
{
    int PAS_cnt;//port_assignment,处理模块例化之间的端口映射
    int CAS_cnt;
    int AS_cnt;
    int IF_cnt;
    int Case_cnt;
} stmt_cnt;
//2025.1.7 Index中变量的提取有问题，第一级的漏提取 第二级的提取不出来，
//已解决，改用iterator 并且填充了regbit partial bit这几类的代码
void print_operand(vpiHandle expr_handle)
{
    int expr_type = vpi_get(vpiType, expr_handle);
    vpiHandle operand_iterator, operand_handle;
    //vpi_printf("%d\n", expr_type);
    if(expr_type == vpiOperation){
        //vpi_printf("vpiOperation\n");
        operand_iterator = vpi_iterate(vpiOperand, expr_handle);
        if(operand_iterator != NULL){
            while((operand_handle = vpi_scan(operand_iterator)) != NULL){
                print_operand(operand_handle);
            }
            //vpi_free_object(operand_iterator);
        }
    }
    else if((expr_type == vpiNet) || (expr_type == vpiReg)){//忽略了常量和parameter 考虑了reg wire 数组 索引是信号的情况
        //vpi_printf("vpiOperand\n");
        //vpi_printf("%d\n", expr_type);
        char *name = vpi_get_str(vpiFullName, expr_handle);
        vpiHandle parent, index_iterator, index;
        int index_type;
        parent = vpi_handle(vpiParent, expr_handle);
        if(parent != NULL){
            index_iterator = vpi_iterate(vpiIndex, expr_handle);
            while((index = vpi_scan(index_iterator)) != NULL){
                index_type = vpi_get(vpiType, index);
                //vpi_printf("%d\n", index_type);
                if(index_type != NULL){
                    if((index_type != vpiConstant) && (index_type != vpiIntegerVar) && (index_type != vpiParameter)){
                        //name = vpi_get_str(vpiFullName, index);
                        //vpi_printf("%s\n", name);
                        print_operand(index);
                    }
                }
            }
            name = vpi_get_str(vpiFullName, parent);
            vpi_printf("%s\n", name);
        }
        else
            vpi_printf("%s\n", name);
    }
    else if(expr_type == vpiPartSelect || expr_type == vpiIndexedPartSelect){
        vpiHandle index_iterator, index;
        int index_type;
        index_iterator = vpi_iterate(vpiIndex, expr_handle);
        while((index = vpi_scan(index_iterator)) != NULL){
            index_type = vpi_get(vpiType, index);
            //vpi_printf("%d\n", index_type);
            if(index_type != NULL){
                if((index_type != vpiConstant) && (index_type != vpiIntegerVar) && (index_type != vpiParameter)){
                    //name = vpi_get_str(vpiFullName, index);
                    //vpi_printf("%s\n", name);
                    print_operand(index);
                }
            }
        }
        //vpi_printf("%d\n", expr_type);
        vpiHandle parent;
        parent = vpi_handle(vpiParent, expr_handle);
        print_operand(parent);
        /*
        leftrange = vpi_handle(vpiLeftRange, expr_handle);
        rightrange = vpi_handle(vpiRightRange, expr_handle);
        s_vpi_value left_value, right_value;
        left_value.format = vpiIntVal;
        right_value.format = vpiIntVal;
        vpi_get_value(leftrange, &left_value);
        vpi_get_value(rightrange, &right_value);
        vpi_printf("%d\n", left_value.value.integer);
        vpi_printf("%d\n", right_value.value.integer);
        */
    }
    else if((expr_type == vpiNetBit) || (expr_type == vpiRegBit)){
        vpiHandle index;
        int index_type;
        index = vpi_handle(vpiIndex, expr_handle);
        index_type = vpi_get(vpiType, index);
        //vpi_printf("%d\n", index_type);
        if(index_type != NULL){
            if((index_type != vpiConstant) && (index_type != vpiIntegerVar) && (index_type != vpiParameter)){
                //name = vpi_get_str(vpiFullName, index);
                //vpi_printf("%s\n", name);
                print_operand(index);
            }
        }
        vpiHandle parent;
        parent = vpi_handle(vpiParent, expr_handle);
        print_operand(parent);
    }
    else if(expr_type == vpiBitSelect){
        vpiHandle index;
        int index_type;
        index = vpi_handle(vpiIndex, expr_handle);
        index_type = vpi_get(vpiType, index);
        //vpi_printf("%d\n", index_type);
        if(index_type != NULL){
            if((index_type != vpiConstant) && (index_type != vpiIntegerVar) && (index_type != vpiParameter)){
                //name = vpi_get_str(vpiFullName, index);
                //vpi_printf("%s\n", name);
                print_operand(index);
            }
        }
        vpiHandle parent;
        parent = vpi_handle(vpiParent, expr_handle);
        print_operand(parent);
    }
}

stmt_cnt Traverse_Assign_stmt(vpiHandle module_handle, stmt_cnt cnt)
{
    vpiHandle assign_iterator, assign_handle;
    
    assign_iterator = vpi_iterate(vpiContAssign, module_handle);
    if(assign_iterator != NULL){
        vpiHandle Lhs_handle;
        vpiHandle Rhs_handle;
        while ((assign_handle = vpi_scan(assign_iterator)) != NULL){
            Lhs_handle = vpi_handle(vpiLhs, assign_handle);
            Rhs_handle = vpi_handle(vpiRhs, assign_handle);
            vpi_printf("ContAssignment %d :\n", cnt.CAS_cnt);
            vpi_printf("Lhs_Operand :\n");
            print_operand(Lhs_handle);
            vpi_printf("end\n");
            vpi_printf("Rhs_Operand :\n");
            print_operand(Rhs_handle);
            vpi_printf("end\n");
            cnt.CAS_cnt = cnt.CAS_cnt + 1;
        }
        //vpi_free_object(assign_iterator);
    }
    return cnt;
}
//2025.1.8 always comb块内integer赋值会导致lhs也是空的，修复——与rhs一样末尾加入end表示结束
stmt_cnt Traverse_Always_stmt(vpiHandle stmt_handle, stmt_cnt cnt)
{
    int PAS_cnt = cnt.PAS_cnt, CAS_cnt = cnt.CAS_cnt, AS_cnt = cnt.AS_cnt, IF_cnt = cnt.IF_cnt, Case_cnt = cnt.Case_cnt;
    if(stmt_handle != NULL){
        int stmt_type = vpi_get(vpiType, stmt_handle);
        //vpi_printf("%d\n",stmt_type);
        stmt_cnt start_cnt, half_cnt, stop_cnt;
        vpiHandle Lhs_handle, Rhs_handle;//Assign
        vpiHandle cond_handle;//if
        vpiHandle case_item_iter, case_item_handle;//case
        vpiHandle item_iter, item_handle;
        vpiHandle begstmt_iterator, begstmt_handle;//begin
        vpiHandle ECstmt_handle;//Event_Control

        switch(stmt_type){
            case vpiAssignment:
                vpi_printf("Assignment %d :\n", cnt.AS_cnt);
                Lhs_handle = vpi_handle(vpiLhs, stmt_handle);
                Rhs_handle = vpi_handle(vpiRhs, stmt_handle);
                vpi_printf("Lhs_Operand :\n");
                print_operand(Lhs_handle);
                vpi_printf("end\n");
                vpi_printf("Rhs_Operand :\n");
                print_operand(Rhs_handle);
                vpi_printf("end\n");
                AS_cnt += 1;
                break;
            case vpiIf:
                start_cnt.AS_cnt = AS_cnt;
                start_cnt.IF_cnt = IF_cnt + 1;
                start_cnt.Case_cnt = Case_cnt;
                vpi_printf("If %d :\n", cnt.IF_cnt);
                vpi_printf("condition var :\n");
                cond_handle = vpi_handle(vpiCondition, stmt_handle);
                print_operand(cond_handle);
                vpi_printf("end\n");
                vpi_printf("True path var :\n");
                stop_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, stmt_handle), start_cnt);
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                vpi_printf("true path end\n");
                vpi_printf("if %d end\n", cnt.IF_cnt);
                break;
            case vpiIfElse:
                start_cnt.AS_cnt = AS_cnt;
                start_cnt.IF_cnt = IF_cnt + 1;
                start_cnt.Case_cnt = Case_cnt;
                vpi_printf("If %d :\n", cnt.IF_cnt);
                vpi_printf("condition var :\n");
                cond_handle = vpi_handle(vpiCondition, stmt_handle);
                print_operand(cond_handle);
                vpi_printf("end\n");
                vpi_printf("True path var :\n");
                half_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, stmt_handle), start_cnt);
                vpi_printf("true path end\n");
                vpi_printf("False path var :\n");
                stop_cnt = Traverse_Always_stmt(vpi_handle(vpiElseStmt, stmt_handle), half_cnt);
                vpi_printf("false path end\n");
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                vpi_printf("if %d end\n", cnt.IF_cnt);
                break;
            case vpiCase:
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt + 1;
                vpi_printf("Case %d :\n", cnt.Case_cnt);
                vpi_printf("condition var :\n");
                cond_handle = vpi_handle(vpiCondition, stmt_handle);
                print_operand(cond_handle);
                vpi_printf("end\n");
                case_item_iter = vpi_iterate(vpiCaseItem, stmt_handle);
                int item_cnt = 0;
                while((case_item_handle = vpi_scan(case_item_iter)) != NULL){
                    item_iter = vpi_iterate(vpiExpr, case_item_handle);
                    vpi_printf("item %d :\n", item_cnt);
                    vpi_printf("caseitem var :\n");
                    while((item_handle = vpi_scan(item_iter)) != NULL)
                        print_operand(item_handle);
                    vpi_printf("end\n");
                    vpi_printf("Itempath var :\n");
                    stop_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, case_item_handle), stop_cnt);
                    vpi_printf("itempath end\n");
                    item_cnt += 1;
                }
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                vpi_printf("case %d end\n", cnt.Case_cnt);
                break;
            case vpiBegin:
                //vpi_printf("stmt_handle is Begin\n");
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt;
                begstmt_iterator = vpi_iterate(vpiStmt, stmt_handle);
                while((begstmt_handle = vpi_scan(begstmt_iterator)) != NULL){
                    stop_cnt = Traverse_Always_stmt(begstmt_handle, stop_cnt);
                }
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                break;
            case vpiNamedBegin:
                //vpi_printf("stmt_handle is Begin\n");
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt;
                begstmt_iterator = vpi_iterate(vpiStmt, stmt_handle);
                while((begstmt_handle = vpi_scan(begstmt_iterator)) != NULL){
                    stop_cnt = Traverse_Always_stmt(begstmt_handle, stop_cnt);
                }
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                break;
            case vpiEventControl:
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt;
                stop_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, stmt_handle), stop_cnt);
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                break;
            case vpiDelayControl:
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt;
                stop_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, stmt_handle), stop_cnt);
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                break;
            case vpiFor:
                stop_cnt.AS_cnt = AS_cnt;
                stop_cnt.IF_cnt = IF_cnt;
                stop_cnt.Case_cnt = Case_cnt;
                stop_cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, stmt_handle), stop_cnt);
                AS_cnt = stop_cnt.AS_cnt;
                IF_cnt = stop_cnt.IF_cnt;
                Case_cnt = stop_cnt.Case_cnt;
                break;
            default:
                //vpi_printf("stmt_handle is NULL\n");
                //vpi_printf("%d\n",stmt_type);
                break;
        }
    }
    stmt_cnt result_cnt = {PAS_cnt,CAS_cnt,AS_cnt,IF_cnt,Case_cnt};
    return result_cnt;
}

stmt_cnt Traverse_Always(vpiHandle module_handle, stmt_cnt cnt)
{
    vpiHandle Process_iterator, Process_handle, stmt_handle;
    int Process_type;
    Process_iterator = vpi_iterate(vpiProcess, module_handle);
    if(Process_iterator != NULL){
        while((Process_handle = vpi_scan(Process_iterator)) != NULL){
            Process_type = vpi_get(vpiType, Process_handle);
            //vpi_printf("%d\n",Process_type);
            if(Process_type == vpiAlways){
                vpi_printf("Always is found\n");
                stmt_handle = vpi_handle(vpiStmt, Process_handle);
                if(stmt_handle != NULL)
                    cnt = Traverse_Always_stmt(vpi_handle(vpiStmt, Process_handle),cnt);
                else
                    vpi_printf("Always is empty\n"); 
                vpi_printf("always end\n");
            }
            /*
            else
                vpi_printf("always isn't found\n");
            */
        }
    }
    return cnt;
}

stmt_cnt Port_Relation(vpiHandle port_iterator, stmt_cnt cnt){
    vpiHandle port_handle;
    vpiHandle highconn_handle, lowconn_handle;
    while((port_handle = vpi_scan(port_iterator)) != NULL){
        int direction_type = vpi_get(vpiDirection, port_handle);
        if(direction_type == vpiInput){
            highconn_handle = vpi_handle(vpiHighConn, port_handle);
            lowconn_handle = vpi_handle(vpiLowConn, port_handle);
            if((highconn_handle == NULL) || (lowconn_handle == NULL))
                continue;
            else{
                vpi_printf("PortAssignment %d :\n", cnt.PAS_cnt);            
                vpi_printf("Lhs_Operand :\n");
                print_operand(lowconn_handle);
                vpi_printf("end\n");
                vpi_printf("Rhs_Operand :\n");
                print_operand(highconn_handle);
                vpi_printf("end\n");
                vpi_printf("direction :\n");
                vpi_printf("input\n");    
                cnt.PAS_cnt += 1;
            }
        }
    }
    return cnt;
}

stmt_cnt Subport_Relation(vpiHandle subport_iterator, stmt_cnt cnt){
    vpiHandle subport_handle;
    vpiHandle highconn_handle, lowconn_handle;
    //这里假设子模块output信号的例化是单个信号，而不是多个信号的拼接
    while((subport_handle = vpi_scan(subport_iterator)) != NULL){
        int direction_type = vpi_get(vpiDirection, subport_handle);
        if(direction_type == vpiOutput){
            highconn_handle = vpi_handle(vpiHighConn, subport_handle);
            lowconn_handle = vpi_handle(vpiLowConn, subport_handle);
            if((highconn_handle == NULL) || (lowconn_handle == NULL))
                continue;
            else{
                vpi_printf("PortAssignment %d :\n", cnt.PAS_cnt);
                vpi_printf("Lhs_Operand :\n");
                print_operand(highconn_handle);
                vpi_printf("end\n");
                vpi_printf("Rhs_Operand :\n");
                print_operand(lowconn_handle);
                vpi_printf("end\n");
                vpi_printf("direction :\n");
                vpi_printf("output\n");
                cnt.PAS_cnt += 1;
            }
        }
    }
    return cnt;
}

stmt_cnt Traverse_Module(vpiHandle module_handle, stmt_cnt cnt)
{
    vpiHandle port_iterator = vpi_iterate(vpiPort, module_handle);
    vpiHandle submodule_iterator, submodule_handle, subport_iterator;
    submodule_iterator = vpi_iterate(vpiModule, module_handle);

    //char* name = vpi_get_str(vpiFullName, module_handle);
    //vpi_printf("Module name is :\n%s\n",name);

    cnt = Port_Relation(port_iterator, cnt);
    while((submodule_handle = vpi_scan(submodule_iterator)) != NULL){
        subport_iterator = vpi_iterate(vpiPort, submodule_handle);
        cnt = Subport_Relation(subport_iterator, cnt);
    }
    cnt = Traverse_Assign_stmt(module_handle, cnt);
    cnt = Traverse_Always(module_handle, cnt);
    submodule_iterator = vpi_iterate(vpiModule, module_handle);
    while((submodule_handle = vpi_scan(submodule_iterator)) != NULL)
        cnt = Traverse_Module(submodule_handle, cnt);
    return cnt;
}
//2025.1.11 添加了logic变量及其数组的选取 利用vpivariables类型得到，在该类型句柄中属于vpireg vpiregarray类型
void print_signal(vpiHandle module){
    vpiHandle net_iterator, net_handle;
    vpiHandle net_array_iterator, net_array_handle;
    vpiHandle reg_iterator, reg_handle;
    vpiHandle reg_array_iterator, reg_array_handle;
    vpiHandle logic_iterator, logic_handle;
    //net
    net_iterator = vpi_iterate(vpiNet, module);
    while((net_handle = vpi_scan(net_iterator)) != NULL){
        char *name = vpi_get_str(vpiFullName, net_handle);
        int size = vpi_get(vpiSize, net_handle);
        vpi_printf("%s 1 %d\n", name, size);
    }
    //net_array
    net_array_iterator = vpi_iterate(vpiNetArray, module);
    while((net_array_handle = vpi_scan(net_array_iterator)) != NULL){
        char *name = vpi_get_str(vpiFullName, net_array_handle);
        int array_size = vpi_get(vpiSize, net_array_handle);
        vpiHandle subnet_iterator, subnet_handle;
        subnet_iterator = vpi_iterate(vpiNet, net_array_handle);
        subnet_handle = vpi_scan(subnet_iterator);
        int size = vpi_get(vpiSize, subnet_handle);
        vpi_printf("%s %d %d\n", name, array_size, size);
    }
    //reg
    reg_iterator = vpi_iterate(vpiReg, module);
    while((reg_handle = vpi_scan(reg_iterator)) != NULL){
        char *name = vpi_get_str(vpiFullName, reg_handle);
        int size = vpi_get(vpiSize, reg_handle);
        vpi_printf("%s 1 %d\n", name, size);
    }
    //reg_array
    reg_array_iterator = vpi_iterate(vpiRegArray, module);
    while((reg_array_handle = vpi_scan(reg_array_iterator)) != NULL){
        char *name = vpi_get_str(vpiFullName, reg_array_handle);
        int array_size = vpi_get(vpiSize, reg_array_handle);
        vpiHandle subreg_iterator, subreg_handle;
        subreg_iterator = vpi_iterate(vpiReg, reg_array_handle);
        subreg_handle = vpi_scan(subreg_iterator);
        int size = vpi_get(vpiSize, subreg_handle);
        vpi_printf("%s %d %d\n", name, array_size, size);
    }
    //logic
    logic_iterator = vpi_iterate(vpiVariables, module);
    while((logic_handle = vpi_scan(logic_iterator)) != NULL){
        int type = vpi_get(vpiType, logic_handle);
        if(type == vpiReg){
            char *name = vpi_get_str(vpiFullName, logic_handle);
            int size = vpi_get(vpiSize, logic_handle);
            vpi_printf("%s 1 %d\n", name, size);
        }
        else if(type == vpiRegArray){
            char *name = vpi_get_str(vpiFullName, logic_handle);
            int array_size = vpi_get(vpiSize, logic_handle);
            vpiHandle sublogic_iterator, sublogic_handle;
            sublogic_iterator = vpi_iterate(vpiReg, logic_handle);
            sublogic_handle = vpi_scan(sublogic_iterator);
            int size = vpi_get(vpiSize, sublogic_handle);
            vpi_printf("%s %d %d\n", name, array_size, size);
        }
    }

    vpiHandle module_iterator, module_handle;
    module_iterator = vpi_iterate(vpiModule, module);
    while((module_handle = vpi_scan(module_iterator)) != NULL){
        print_signal(module_handle);
    }
}

PLI_INT32 vpit_TraverseDesign( PLI_BYTE8 *user_data )
{

    vpi_printf( "\n===========================\n" );
    vpi_printf( "Results of Design Traversal\n" );
    vpi_printf( "===========================\n" );

    vpiHandle systf_handle, arg_iterator,top_module,top_module_handle;
    vpiHandle module_iterator, module_handle, subport_iterator;
    stmt_cnt cnt;
    cnt.CAS_cnt = 0;
    cnt.AS_cnt = 0;
    cnt.Case_cnt = 0;
    cnt.IF_cnt = 0;
    cnt.PAS_cnt = 0;
    systf_handle = vpi_handle(vpiSysTfCall, NULL);
    arg_iterator = vpi_iterate(vpiArgument, systf_handle);
    top_module = vpi_scan(arg_iterator);

    char *name = vpi_get_str(vpiFullName, top_module);
    
    top_module_handle = vpi_handle_by_name(name, NULL);
    module_iterator = vpi_iterate(vpiModule, top_module_handle);
    print_signal(top_module_handle);
    vpi_printf("end\n");
    //vpi_printf("Module name is :\n%s\n",name);
    while((module_handle = vpi_scan(module_iterator)) != NULL){
        subport_iterator = vpi_iterate(vpiPort, module_handle);
        cnt = Subport_Relation(subport_iterator, cnt);
    }
    cnt = Traverse_Assign_stmt(top_module_handle, cnt);
    cnt = Traverse_Always(top_module_handle, cnt);
    module_iterator = vpi_iterate(vpiModule, top_module_handle);
    while((module_handle = vpi_scan(module_iterator)) != NULL)
        cnt = Traverse_Module(module_handle, cnt);
    return 0;
}

/*****************************************************************************
 *
 * vpit_RegisterTfs
 *
 * Registers test functions with the simulator.
 *
 *****************************************************************************/
/*
extern void vpit_RegisterTfs( void )
{
    s_vpi_systf_data systf_data;
    vpiHandle        systf_handle;

    systf_data.type        = vpiSysTask;
    systf_data.sysfunctype = 0;
    systf_data.tfname      = "$traverse";
    systf_data.calltf      = vpit_TraverseDesign;
    systf_data.compiletf   = 0;
    systf_data.sizetf      = 0;
    systf_data.user_data   = 0;
    systf_handle = vpi_register_systf( &systf_data );
    vpi_free_object( systf_handle );
}
*/
/*****************************************************************************
 *
 * Required structure for initializing VPI routines.
 *
 *****************************************************************************/
/*
void (*vlog_startup_routines[])() = {
    vpit_RegisterTfs,
    0
};
*/
/*****************************************************************************/
