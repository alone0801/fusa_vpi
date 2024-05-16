#!/bin/csh -f
setenv PERL5LIB `ncroot`/tools/inca/files/xfs

setenv FS_STROBE_LIST_FILE_NAME "$1"
setenv FS_EXEC_TMP fault_db
setenv FS_STROBE_NODE_HIERARCHY_FROM 
setenv FS_STROBE_NODE_HIERARCHY_TO
setenv FS_STROBE_DEFAULT_EVENT
setenv FS_CHECKPOINT_TYPE

# Generate strobe conf file inside fault db
`ncroot`/tools/inca/files/xfs/fs_generate_strobeCnf.pl

# Generate strobe Tcl file
`ncroot`/tools/inca/files/xfs/fs_g_sim_prep.pl
