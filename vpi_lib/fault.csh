#!/bin/bash
fault_dir=$1
rm -rf $fault_dir
EXE_PATH=$(pwd)
num_faults=$(cat fault.set | wc -l)
num_faults=$(($num_faults-1))
echo "The number of lines in fault.set is: $num_faults"
mkdir $fault_dir
cd $fault_dir
#mkdir $test_dir1
#cd test_dir1
for ((i = 1; i <= num_faults; i++)); do
    dir_name="fault_sim_$i"
    mkdir "$dir_name"
    cd "$dir_name" || exit

    # 创建并写入 XML 文件
    echo '<?xml version="1.0" encoding="utf-8" ?>' > fault.xml
    echo '<INJECT>' >> fault.xml
    echo "    <ID>$i</ID>" >> fault.xml
    echo '</INJECT>' >> fault.xml
    $EXE_PATH/simv -l fault_sim.log   +elf_load=$SW_dir/Baremetal/sample_apps/hello.elf +clear_ram  
    #-ucli -i $fusa_lib/ucli.tcl
    cd .. || exit
done
