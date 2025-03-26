# -*- coding:utf-8 -*-
import pickle
import os
import copy
import xml.etree.ElementTree as ET
class Node:
    def __init__(self, name, type):
        self.name = name        # 节点名称
        self.type = type
        self.father = []     # 邻居节点（入边）[father,condition]
        
    def add_father(self, father, condition):
        self.father.append(father)
        self.father.append(condition)

class DAG:
    def __init__(self):
        self.nodes = []         # 存储图中的所有节点
        self.node_map = {}      # 存储节点名称与节点对象的映射
        
    def add_node(self, node):
        self.nodes.append(node)
        self.node_map[node.name] = node
    
    def add_edge(self, from_node, to_node, condition):
        #from_node = self.node_map.get(from_node_name)
        #to_node = self.node_map.get(to_node_name) 
        if from_node and to_node:
            to_node.add_father(from_node, condition)
        else:
            raise ValueError("节点名称无效")
        
def CFG_gene(CFG_dag, father, condition,result, cnt):
    if(result[cnt][0] == 'Always'):
        start = Node('start','start')
        CFG_dag.add_node(start)
        cnt = CFG_gene(CFG_dag, start, None, result, cnt+1)
    elif(result[cnt][0] == 'always'):
        stop = Node('stop','stop')
        CFG_dag.add_node(stop)
        CFG_dag.add_edge(father, stop, condition)
        cnt = cnt + 1#跳到下一个always块的Always is found
    elif(result[cnt][0] == 'Assignment'):
        name = 'AS' + result[cnt][1]
        node = Node(name,'AS')
        CFG_dag.add_node(node)
        CFG_dag.add_edge(father, node, condition)
        cnt = CFG_gene(CFG_dag, node, None, result, cnt+1)
    elif(result[cnt][0] == 'If'):
        name = 'IF' + result[cnt][1]
        node = Node(name,'IF')
        CFG_dag.add_node(node)
        CFG_dag.add_edge(father, node, condition)
        cnt = cnt + 1 #跳到True path var :
        #True path
        cnt = CFG_gene(CFG_dag, node, None, result, cnt+1)
        cnt = cnt + 1#跳到False path var :
        if(result[cnt][0] == 'False'):
            #False path
            cnt = CFG_gene(CFG_dag, node, None, result, cnt+1)
            cnt = cnt + 1#跳到if x end
        cnt = CFG_gene(CFG_dag, father, None, result, cnt+1)
    elif(result[cnt][0] == 'Case'):
        name = 'CS' + result[cnt][1]
        node = Node(name,'CS')
        CFG_dag.add_node(node)
        CFG_dag.add_edge(father, node, condition)
        while(result[cnt+1][0] != 'case'):
            item_con = set()
            cnt = cnt + 3 #跳到caseitem var:的下一行
            while(result[cnt][0] != 'end'):
                item_con.add(result[cnt][0])
                cnt = cnt + 1#跳到下一行
            cnt = cnt + 1#跳到Itempath var
            cnt = CFG_gene(CFG_dag, node, list(item_con), result, cnt+1)
        cnt = cnt + 1#跳到case x end
        cnt = CFG_gene(CFG_dag, father, condition, result, cnt+1)
    return cnt 

#var：用大写开头 end:用小写开头 多个always要有编号，要有总体的always end
#考虑有多个if case并列 或if在赋值语句之后，不用考虑if case的汇聚 并列结构直接在if case分支处的节点继续分支
#if和赋值语句并列且赋值语句后置时从赋值语句向上回溯会错误记录条件语句的条件，应该通过并列分支和子分支将其分开
def CFG_set_gene(result):#生成字典 always块 -> CFG         
    CFG_dag_set = {}
    cnt = 0
    always_cnt = 0
    while(cnt != len(result)):
        CFG_dag = DAG()
        CFG_dag_set['AL'+ str(always_cnt)] = CFG_dag
        cnt = CFG_gene(CFG_dag, None, None, result, cnt)
        always_cnt = always_cnt + 1
    return CFG_dag_set
#2024.12.29 lhs信号有多个的情况，一般是索引是信号，应当将其放到rhs中
def stmt_info_gene(result):#生成字典 stmt_name -> [type, lhs, rhs, condition_var/direction]
    stmt_info_set = {}#存储语句包括type lhs rhs condition_var/directon
    cnt = 0
    while(cnt != len(result)):
        if(result[cnt][0] == 'ContAssignment'):
            stmt_info = []
            key_name = 'CA'+result[cnt][1]
            stmt_info_set[key_name] = stmt_info
            #获取type
            stmt_info.append('CA')
            #获取lhs
            result.pop(cnt)#删掉CA的名称
            result.pop(cnt)#删掉Lhs_Operand :
            rhs_var = set()
            while(result[cnt][0] != 'end'):
                if(result[cnt+1][0] != 'end'):#Lhs除了最后一个都算在Rhs上 
                    rhs_var.add(result[cnt][0])
                    result.pop(cnt)#删Lhs
                else:
                    stmt_info.append(result[cnt][0])
                    result.pop(cnt)#删最后一个Lhs
            result.pop(cnt)#删掉end
            #获取rhs
            result.pop(cnt)#删掉Rhs_Operand :
            while(result[cnt][0] != 'end'):
                rhs_var.add(result[cnt][0])
                result.pop(cnt)#删掉Rhs
            if(len(rhs_var) != 0):
                stmt_info.append(list(rhs_var))
            else:
                del stmt_info_set[key_name]
            result.pop(cnt)#删掉end
            #获取condition_var
            stmt_info.append(None)
        elif(result[cnt][0] == 'PortAssignment'):
            stmt_info = []
            key_name = 'PA'+result[cnt][1]
            stmt_info_set[key_name] = stmt_info
            #获取type
            stmt_info.append('PA')
            #获取lhs
            result.pop(cnt)#删掉PA的名称
            result.pop(cnt)#删掉Lhs_Operand :
            rhs_var = set()
            while(result[cnt][0] != 'end'):
                if(result[cnt+1][0] != 'end'):#Lhs除了最后一个都算在Rhs上 
                    rhs_var.add(result[cnt][0])
                    result.pop(cnt)#删Lhs
                else:
                    stmt_info.append(result[cnt][0])
                    result.pop(cnt)#删最后一个Lhs
            result.pop(cnt)#删掉end
            #获取rhs
            result.pop(cnt)#删掉Rhs_Operand :
            while(result[cnt][0] != 'end'):
                rhs_var.add(result[cnt][0])
                result.pop(cnt)#删掉Rhs
            if(len(rhs_var) != 0):
                stmt_info.append(list(rhs_var))
            else:
                del stmt_info_set[key_name]
            result.pop(cnt)#删掉end
            #获取condition_var/这里是借用到direction
            result.pop(cnt)#删掉direction :
            stmt_info.append(result[cnt][0])
            result.pop(cnt)#删掉input/output
        elif(result[cnt][0] == 'If'):
            stmt_info = []
            key_name = 'IF'+result[cnt][1]
            stmt_info_set[key_name] = stmt_info
            #获取type
            stmt_info.append('IF')
            #获取lhs
            stmt_info.append(None)
            #获取rhs
            stmt_info.append(None)
            #获取condition_var
            condition_var = set()
            cnt = cnt + 1
            result.pop(cnt)#删掉condition var :
            while(result[cnt][0] != 'end'):
                condition_var.add(result[cnt][0])
                result.pop(cnt)#删掉condition var
            result.pop(cnt)#删掉end
            if(len(condition_var) != 0):
                stmt_info.append(list(condition_var))
            else:
                stmt_info.append(None)
        elif(result[cnt][0] == 'Case'):
            stmt_info = []
            key_name = 'CS'+result[cnt][1]
            stmt_info_set[key_name] = stmt_info
            #获取type
            stmt_info.append('CS')
            #获取lhs
            stmt_info.append(None)
            #获取rhs
            stmt_info.append(None)
            #获取condition_var
            condition_var = set()
            cnt = cnt + 1
            result.pop(cnt)#删掉condition var :
            while(result[cnt][0] != 'end'):
                condition_var.add(result[cnt][0])
                result.pop(cnt)#删掉condition var
            result.pop(cnt)#删掉end
            if(len(condition_var) != 0):
                stmt_info.append(list(condition_var))
            else:
                stmt_info.append(None)
        elif(result[cnt][0] == 'Assignment'):
            stmt_info = []
            key_name = 'AS'+result[cnt][1]
            stmt_info_set[key_name] = stmt_info
            #获取type
            stmt_info.append('AS')
            #获取lhs
            cnt = cnt + 1
            result.pop(cnt)#删掉Lhs_Operand :
            rhs_var = set()
            while(result[cnt][0] != 'end'):
                if(result[cnt+1][0] != 'end'):#Lhs除了最后一个都算在Rhs上 
                    rhs_var.add(result[cnt][0])
                    result.pop(cnt)#删Lhs
                else:
                    stmt_info.append(result[cnt][0])
                    result.pop(cnt)#删最后一个Lhs
            result.pop(cnt)#删掉end
            #获取rhs
            result.pop(cnt)#删掉Rhs_Operand :
            while(result[cnt][0] != 'end'):
                rhs_var.add(result[cnt][0])
                result.pop(cnt)#删掉Rhs
            if(len(rhs_var) != 0):
                stmt_info.append(list(rhs_var))
            else:
                stmt_info.append(None)
            result.pop(cnt)#删掉end
            #获取condition_var
            stmt_info.append(None)
        else:
            cnt = cnt + 1
    return stmt_info_set
def depend_dic_gene(stmt_info_set):#生成字典 var -> 以var为赋值对象的赋值语句集合
    depend_dic = {}
    for stmt_name in stmt_info_set:
        if(stmt_info_set[stmt_name][0] == 'CA' or stmt_info_set[stmt_name][0] == 'AS' or stmt_info_set[stmt_name][0] == 'PA'):
            var = stmt_info_set[stmt_name][1]
            if(var in depend_dic):
                depend_dic[var].append(stmt_name)
            else:
                depend_dic[var] = [stmt_name]
    return depend_dic
def always_dic_gene(CFG_dag_set):#生成字典 stmt_name -> 赋值语句所在的always块
    always_dic = {}
    for key in CFG_dag_set:
        CFG_dag = CFG_dag_set[key]
        for node in CFG_dag.nodes:
            if(node.type == 'AS'):
                always_dic[node.name] = key
    return always_dic
def CFG_trace_back(var_checked, CF_checked, target_related, CFG, stmt_info_set, stmt_name, stmt_set):
    node = CFG.node_map.get(stmt_name)
    while(node.type != 'start'):
        father_node = node.father[0]
        if(father_node.type == 'IF' or father_node.type == 'CS'):
            edge_cond = node.father[1]
            if(edge_cond != None):
                for cond_var in edge_cond:
                    if(cond_var in var_checked):
                        continue
                    else:
                        target_related.append(cond_var)
                        var_checked.append(cond_var)
            if(father_node.name in CF_checked):
                break
            else:
                stmt_set.append(father_node.name)
                CF_checked.append(father_node.name)
                condition = stmt_info_set[father_node.name][3]
                if(condition != None):
                    for cond_var in condition:
                        if(cond_var in var_checked):
                            continue
                        else:
                            target_related.append(cond_var)
                            var_checked.append(cond_var)
        node = node.father[0]
def port_checked_gene(stmt_info_set):#生成列表，里面为因为端口映射多余的端口模块
    port_checked = []
    for stmt_name in stmt_info_set:
        if(stmt_info_set[stmt_name][0] == 'PA'):
            lhs = stmt_info_set[stmt_name][1]
            rhs = stmt_info_set[stmt_name][2]
            if(stmt_info_set[stmt_name][3] == 'input'):
                if(lhs not in port_checked):
                    port_checked.append(lhs)
            else:
                for var in rhs:
                    if(var not in port_checked):
                        port_checked.append(var)
    return port_checked
#port_checked标记PAS的rhs变量，无需将其送入result,以防端口映射中两个实际上相同的变量重复输出
# 但由于目前信号粒度害没有到位bit,因此存在某个信号的某一比特用于端口例化时但其他位与target有关联时
# 会将整个信号进行限制，无法输出
def var_depend_search(target, stmt_info_set, CFG_dag_set, depend_dic, always_dic, port_checked):
    target_related = copy.deepcopy(target)#与target相关的变量    
    result = []#输出
    var_checked = copy.deepcopy(target)#标记已经寻找到的变量
    CF_checked = []#标记已经寻找到的控制语句
    #target_related.append(target)
    stmt_set = []#debug用，记录所有相关变量所在的语句名
    while(len(target_related) != 0):
        var = copy.deepcopy(target_related[0])
        if((var not in port_checked) and (var not in target)):
            result.append(var)
        target_related.pop(0)
        if(var in depend_dic):
            for stmt_name in depend_dic[var]:
                stmt_set.append(stmt_name)
                if(stmt_info_set[stmt_name][2] != None):
                    for rhs_var in stmt_info_set[stmt_name][2]:
                        if(rhs_var in var_checked):
                            continue
                        else:
                            target_related.append(rhs_var)
                            var_checked.append(rhs_var)
                if(stmt_info_set[stmt_name][0] == 'AS'):
                    always_name = always_dic[stmt_name]
                    CFG = CFG_dag_set[always_name]
                    CFG_trace_back(var_checked, CF_checked, target_related, CFG, stmt_info_set, stmt_name, stmt_set)
        else:
            continue
    #num = 1
    #name = 'stmt_set'
    #while(os.path.exists(name+'_'+str(num))):
    #    num = num + 1
    #file_name = name+'_'+str(num)
    #with open(file_name,'w') as file:
    #    for stmt in stmt_set:
    #        file.write(stmt)
    #        file.write('\n')

    return result
#PA应该增加direction以区分Input output，input时候存在外部输入是同一个的情况，因此应该输出外部输入而不是内部输入
def signal_info_gene(result):#生成信号列表 signal_name -> [array_size,size]
    signal_info = {}
    while(result[0][0] != 'end'):
        signal_name = result[0][0]
        array_size = result[0][1]
        size = result[0][2]
        signal_info[signal_name] = [array_size,size]
        result.pop(0)
    result.pop(0)
    return signal_info

def fault_list_gene(top_module, signal_set, signal_info_set):
    fault_list_name = 'fault.set'
    with open(fault_list_name, 'w') as file:
        file.write('<LOCATION> <TYPE> <TIME> <RESULT>\n')
        for signal_name in signal_set:
#            if(signal_name[-3:] == 'mem'):
#               continue
            signal_info = signal_info_set[signal_name]
            array_size = int(signal_info[0])
            size = int(signal_info[1])
            if(array_size != 1):
                for array_cnt in range(array_size):
                    if(size != 1):
                        for cnt in range(size):
                            file.write('{0}[{1}][{2}]  SA0  0  UU\n'.format(signal_name,array_cnt,cnt))
                            file.write('{0}[{1}][{2}]  SA1  0  UU\n'.format(signal_name,array_cnt,cnt))
                    else:
                        file.write('{0}[{1}]  SA0  0  UU\n'.format(signal_name,array_cnt))
                        file.write('{0}[{1}]  SA1  0  UU\n'.format(signal_name,array_cnt))
            else:
                if(size != 1):
                    for cnt in range(size):
                        file.write('{0}[{1}]  SA0  0  UU\n'.format(signal_name,cnt))
                        file.write('{0}[{1}]  SA1  0  UU\n'.format(signal_name,cnt))
                else:
                    file.write('{0}  SA0  0  UU\n'.format(signal_name))
                    file.write('{0}  SA1  0  UU\n'.format(signal_name))
current_path =  os.getcwd()
print("PWD", current_path)
external_vars = ['TESTBENCH_NAME', 'INJECT_TIME', 'FAULT_TYPE', 'FAULT_LOCATION', 'CHECKER_STROBE', 'FUNCTIONAL_STROBE']
def extract_params(element, params):
    if element.tag in external_vars:
        if element.tag in params:
            if isinstance(params[element.tag], list):
                params[element.tag].append(element.text)
            else:
                params[element.tag] = [params[element.tag], element.text]
        else:
            params[element.tag] = element.text
    for child in element:
        extract_params(child, params)
# ReadXML
tree = ET.parse('FI.xml')
root = tree.getroot()
# Extract from xml
external_params = {}
extract_params(root, external_params)               
result = []
top_module = external_params['TESTBENCH_NAME']
if 'FUNCTIONAL_STROBE' in external_params:
	if isinstance(external_params['FUNCTIONAL_STROBE'], list):
		target_name = external_params['FUNCTIONAL_STROBE']
	else:
		target_name = [external_params['FUNCTIONAL_STROBE']]
input_file_name = 'fault_pruning.log'
signal_info_name = 'fault_pruning_dir/'+top_module+'_signal.pkl'
stmt_name = 'fault_pruning_dir/'+top_module+'_stmt.pkl'
depend_name = 'fault_pruning_dir/'+top_module+'_depend.pkl'
CFG_name  = 'fault_pruning_dir/'+top_module+'_CFG.pkl'
always_name = 'fault_pruning_dir/'+top_module+'_always.pkl'
port_name = 'fault_pruning_dir/'+top_module+'_port.pkl'

with open(input_file_name,'r') as file:
    for line in file:
        result.append(line.strip().split(' '))
result = result[8:-11]
if os.path.exists(signal_info_name):
    with open(signal_info_name, 'rb') as file:
        signal_info_set = pickle.load(file)
else:
    signal_info_set = signal_info_gene(result)#存储signal的信息
    with open(signal_info_name, 'wb') as file:
        pickle.dump(signal_info_set,file)

if os.path.exists(stmt_name):
    with open(stmt_name, 'rb') as file:
        stmt_info_set = pickle.load(file)
else:
    stmt_info_set = stmt_info_gene(result)#存储语句包括type lhs rhs condition_var
    with open(stmt_name, 'wb') as file:
        pickle.dump(stmt_info_set,file)

if os.path.exists(depend_name):
    with open(depend_name, 'rb') as file:
        depend_dic = pickle.load(file)
else:
    depend_dic = depend_dic_gene(stmt_info_set)
    with open(depend_name, 'wb') as file:
        pickle.dump(depend_dic,file)

if os.path.exists(CFG_name):
    with open(CFG_name, 'rb') as file:
        CFG_dag_set = pickle.load(file)
else:
    CFG_dag_set = CFG_set_gene(result)
    with open(CFG_name, 'wb') as file:
        pickle.dump(CFG_dag_set,file)

if os.path.exists(always_name):
    with open(always_name, 'rb') as file:
        always_dic = pickle.load(file)
else:
    always_dic = always_dic_gene(CFG_dag_set)
    with open(always_name, 'wb') as file:
        pickle.dump(always_dic,file)

if os.path.exists(port_name):
    with open(port_name, 'rb') as file:
        port_checked = pickle.load(file)
else:
    port_checked = port_checked_gene(stmt_info_set)
    with open(port_name, 'wb') as file:
        pickle.dump(port_checked,file)

outcome = var_depend_search(target_name, stmt_info_set, CFG_dag_set, depend_dic, always_dic, port_checked)
signal = list(signal_info_set.keys())
fault_list_gene(top_module,outcome,signal_info_set)
