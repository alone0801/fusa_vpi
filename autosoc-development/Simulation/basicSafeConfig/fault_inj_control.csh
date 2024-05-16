#!/bin/csh -f

########################################################################################
## - Retrieve Snapshot information from project directory
## - Run fault injection loop for all faults in fault_db
########################################################################################

# Disable glob to read special characters as text
set noglob

# Set User Name
set USER_NAME = `whoami`

# Prepare fault list for fault injection simulation
# create fault list
#xfr -fault_work fault_db -verbose
grep NOT_INJECTED fault_db/xfr_merge.out > fault_db/fault.list

echo "FAULT INJECTION VIA FAULT REGULAR LIST"
set fault_list=fault_db/fault.list

#echo "FAULT INJECTION VIA INTERNAL MEMORY BLACK BOX LIST"
#set fault_list=fault_db/fault-BlackBox.list

# Maximum number of simulations in parallel
set maxProcs=100

# Fault list Information
@ num_faults = `cat $fault_list | wc -l`


############## Execute Fault Injection Dispatch Script

# Dispatch Job
#$JOB_DISPATCH $FILES_DIR/fault_inj_dispatch.csh $fault_list $maxProcs
$FILES_DIR/fault_inj_dispatch.csh $fault_list $maxProcs
echo "Status: $status"

############## Wait until all Simulation have finished
set runningProcs = `qstat -u $USER_NAME | grep fSet2Inj | wc -l`
while ($runningProcs > 1)
    # Wait and recalculate the number of running xmsim
    sleep 5
    set runningProcs = `qstat -u $USER_NAME | grep fSet2Inj | wc -l`
end

# Display Fault Injection Results
xfr -fault_work fault_db -verbose

############## End of XFS Fault Injection
exit 0
