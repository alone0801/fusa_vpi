#!/bin/csh -f

###########################################
## SETUP CONFIGURATION VARIABLES         ##
###########################################

# Name of the folder with the configurations of the desired Simulation
# Default is RTL
setenv SIM_FOLDER autoSoC-QM
#setenv SIM_FOLDER autoSoC-SAFE
#setenv SIM_FOLDER basicSafeConfig

# Name of the script to be executed for fault injection campaigns
# The script should be located inside of folder SIM_FOLDER
setenv FAULT_SCRIPT fault_inj_control.csh

###########################################
## VARIABLES BELOW SHOULD NOT BE CHANGED ##
###########################################

# Simulation Directory Absolute Path
setenv SIM_DIR `pwd`

# Hardware Source Code Location
setenv HW_DIR `echo $SIM_DIR | sed s/Simulation/Hardware/g`

# Software Elf Location
setenv SW_DIR `echo $SIM_DIR | sed s/Simulation/Software/g`

# Set Location of Files to be Simulated
setenv FILES_DIR $SIM_DIR/$SIM_FOLDER

# Read Simulation Parameters from xrunPlusArgs.f File
setenv PLUS_ARGS `cat $FILES_DIR/xrunPlusArgs.f`
