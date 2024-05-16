#!/bin/csh -f

# Control Execution of Fault Injection Simulations in Parallel on a single processor
# This script is executed by the fault_injection_control.csh script

echo "Starting Fault Dispatch Script"

# Disable glob to read special characters as text
set noglob

# Set User Name
set USER_NAME = `whoami`

# SGE Reports Folder
rm -rf logs_sge
mkdir logs_sge

# Faults Log Folder
set FAULTS_CONFIG="faults"
rm -rf $FAULTS_CONFIG
mkdir $FAULTS_CONFIG

# Get Input Parameters for Fault Injection Execution
set fault_list=$argv[1]
set maxProcs=$argv[2]

# Parameter for cut command on XFS Fault list
set cutID=9

# Fault list Information
@ num_faults = `cat $fault_list | wc -l`
set i = 1

foreach line ("`cat $fault_list`")
    # Get Node name
    set AUX = `echo "$line" | cut -d '"' -f 2` 
    set NODE = `echo \"$AUX\"`

#################################################
# Fault Type should be set manually for SET (w/ fault duration) 
# and will be automatically read for SA0/SA1 and SEU
    #Get Fault type
    set TYPE = `echo "$line" | cut -d '"' -f 3 | cut -f $cutID -d " "`
    #set TYPE = "SET+20ns" 
#################################################
    #Fault Injection Time
    set TW   = '100ns'
    #Get Fault ID
    set FAULTID = `echo "$line" | cut -d '<' -f 3 | cut -d ' ' -f 1`

    # set fault inj config file
    echo "fault -stop_severity 3; fault -inject -type $TYPE -time $TW $NODE" > $FAULTS_CONFIG/$i-fault_inj_config.f

    echo "Simulating fault $i of $num_faults : $NODE $TYPE "
    
    # SGE Job dispatch command
    set JOB_DISPATCH="qsub -N fSet2Inj_$i -V -b y -cwd -l low_prio=1,os_rel=RH6 -o logs_sge/xrun_o_$i.log -e logs_sge/xrun_e_$i.log"

    $JOB_DISPATCH xrun -R -fault_max_msgs 1 -fault_sim_run -fault_timeout 500ms -run -exit -input $FAULTS_CONFIG/$i-fault_inj_config.f -licq -nostdout -l logs/xrun_fs_${TYPE}_fault_${FAULTID}.log -f $FILES_DIR/xrunPlusArgs.f

    @ i++

    # Logic to control number of Fault Injections running in Parallalel
    #set runningProcs = `qstat -u $USER_NAME | grep xrun | wc -l`
    set runningProcs = `qstat -u $USER_NAME | grep fSet2Inj | wc -l`

    while ($runningProcs > $maxProcs)
        # Wait and recalculate the number of running xmsim
        sleep 10
        #set runningProcs = `qstat -u $USER_NAME | grep xrun | wc -l`
        set runningProcs = `qstat -u $USER_NAME | grep fSet2Inj | wc -l`
    end

# foreach
end
exit 0
