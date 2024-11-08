#!/bin/bash 

# ���벽��
# pbs_sim FM_TEST hello.elf
#make vcs_good MACRO=$2
#make vcs_fault MACRO=$2

start_time=$(date +%s)
# ��ʼ������
cd autoSOC_fusa
fault_dir=$1
rm -rf "$fault_dir"
EXE_PATH=$(pwd)
num_faults=$(($(cat fault.set | wc -l) - 1))
echo "The number of faults in batch inject compaign: $num_faults"
mkdir "$fault_dir"
cd "$fault_dir"

# �������������������
MAX_CONCURRENT_JOBS=20
PBS_SCRIPT="fault_inject.pbs"

# ����PBS�ű�ģ��
cat <<EOF > $PBS_SCRIPT
#!/bin/bash
#PBS -N fault_inject
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -j oe
#PBS -o /dev/null
#PBS -e /dev/null

# �л�������Ŀ¼
cd \$PBS_O_WORKDIR

# ����EXE_PATH
EXE_PATH=$EXE_PATH

# ����Ŀ¼��fault.xml
dir_name="fault_sim_\$FOO"
mkdir "\$dir_name"
cd "\$dir_name" || exit

# ���� XML �ļ�
echo '<?xml version="1.0" encoding="utf-8" ?>' > fault.xml
echo '<INJECT>' >> fault.xml
echo "    <ID>\$FOO</ID>" >> fault.xml
echo '</INJECT>' >> fault.xml

# ����ģ��
\$EXE_PATH/simv -l fault_sim.log +elf_load=\$SW_dir/Baremetal/sample_apps/hello.elf +clear_ram
EOF

# �ύPBS���񣬲����Ʋ�������
for ((i = 1; i <= num_faults; i++)); do
    echo "FUSA_VPI::fault inject compaign num_$i submit"
    # ��鵱ǰ�����е��������������� MAX_CONCURRENT_JOBS ����
    while (( $(qstat  | grep -c "fault_inject") >= MAX_CONCURRENT_JOBS )); do
        sleep 10  # �ȴ�10���ټ��һ��
    done

    # �ύ����
    qsub -v FOO=$i $PBS_SCRIPT
done
end_time=$(date +%s)
echo "PBS Batch simulation time: $(($end_time - $start_time)) seconds"
