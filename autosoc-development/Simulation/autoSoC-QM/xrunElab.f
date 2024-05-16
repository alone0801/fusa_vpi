
###############################################################
# List of Project Files
###############################################################
-incdir $HW_DIR/SRC/wb_bus/
$HW_DIR/SRC/wb_bus/*.v
$HW_DIR/SRC/*.v

-incdir $HW_DIR/SRC/adv_debug_sys_3.1.0/Hardware/adv_dbg_if/rtl/verilog/
$HW_DIR/SRC/adv_debug_sys_3.1.0/Hardware/adv_dbg_if/rtl/verilog/*.v

$HW_DIR/SRC/jtag_tap_1.13/tap/rtl/verilog/*.v

-incdir $HW_DIR/SRC/mor1kx_5.0-r1/rtl/verilog/
$HW_DIR/SRC/mor1kx_5.0-r1/rtl/verilog/*.v

-incdir $HW_DIR/SRC/uart16550_1.5.4/rtl/verilog/
$HW_DIR/SRC/uart16550_1.5.4/rtl/verilog/*.v

-incdir $HW_DIR/SRC/can_master/
$HW_DIR/SRC/can_master/*.v

$HW_DIR/SRC/wb_bus/wb_intercon_1.0/rtl/verilog/wb_arbiter.v
$HW_DIR/SRC/wb_bus/wb_intercon_1.0/rtl/verilog/wb_data_resize.v
$HW_DIR/SRC/wb_bus/wb_intercon_1.0/rtl/verilog/wb_mux.v
        
$HW_DIR/SRC/wb_ram_1.0/rtl/verilog/*.v

$HW_DIR/SRC/utils/verilog-arbiter_0-r1/src/*.v

-incdir $HW_DIR/SRC/wb_bus/wb_common_1.0.1/

-incdir $HW_DIR/SRC/utils/verilog_utils_0/

$HW_DIR/SRC/intgen/rtl/verilog/*.v

# Safety Mechanisms auxiliary files
$HW_DIR/SRC/parity_control/rtl/verilog/*.v
$HW_DIR/SRC/safety_monitor/rtl/verilog/*.v
$HW_DIR/SRC/checkpoint_ctrl/rtl/verilog/*.v
$HW_DIR/SRC/mor1kx_5.0-r1/rtl/verilog/lockstep_aux/*.v

# ECC Logic
-incdir $HW_DIR/SRC/ecc_bch_dec/src/rtl/univ/
$HW_DIR/SRC/ecc_bch_dec/src/rtl/univ/*.v

###############################################################
# VPI Files
###############################################################
$HW_DIR/TB/jtag_vpi_0-r2/jtag_vpi.c
$HW_DIR/TB/elf-loader_1.0.2/elf-loader.c -lelf
$HW_DIR/TB/elf-loader_1.0.2/vpi_user.c

###############################################################
# Testbench Location
###############################################################
$HW_DIR/TB/vlog_tb_utils_1.0/*.v
$HW_DIR/TB/jtag_vpi_0-r2/*.v

-incdir $HW_DIR/TB/include
$HW_DIR/TB/mor1kx_monitor.v
$HW_DIR/TB/autosoc_tb.v

###############################################################
# Other Configurations
###############################################################
-allowredefinition
-smartorder

-access +rw
-noassert
-timescale 1ns/1ns

-nowarn DSEMEL
-nowarn NCEXDEP

# Fault Parameters
-fault_file $FILES_DIR/faultTarget.spec
-fault_dbg 
-fault_iso_opts 
-fault_overwrite
-fault_top autosoc_tb
-c

