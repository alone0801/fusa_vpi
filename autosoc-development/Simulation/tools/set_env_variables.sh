#!/bin/sh

###########################################
## SETUP CONFIGURATION VARIABLES         ##
###########################################

# Name of the folder with the configurations of the desired Simulation
# Default is RTL
export SIM_FOLDER=basicSafeConfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/fusa_vpi/vpi_lib/
# Name of the script to be executed for fault injection campaigns
# The script should be located inside of folder SIM_FOLDER
export FAULT_SCRIPT=fault_inj_control.csh

###########################################
## VARIABLES BELOW SHOULD NOT BE CHANGED ##
###########################################

# Simulation Directory Absolute Path
export SIM_DIR=`pwd`

# Hardware Source Code Location
export HW_DIR=`echo $SIM_DIR | sed s/Simulation/Hardware/g`

# Software Elf Location
export SW_DIR=`echo $SIM_DIR | sed s/Simulation/Software/g`

# Set Location of Files to be Simulated
export FILES_DIR=$SIM_DIR/$SIM_FOLDER

# Read Simulation Parameters from xrunPlusArgs.f File
export PLUS_ARGS=`cat $FILES_DIR/xrunPlusArgs.f`
