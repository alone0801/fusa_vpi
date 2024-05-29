#!/bin/bash

# 提取关键字，并转义特殊字符，写入临时文件
grep -oP '(?<=fault_exclude ").*(?=")' faultTarget.spec   > patterns.txt

# 使用 grep -f 进行筛选
grep -v -f patterns.txt flt_target_dbg.list > fault.list

# 删除临时文件
#rm patterns.txt
