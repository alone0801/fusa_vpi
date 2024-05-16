/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: AutoSoC Configuration Parameters
  Options are defined in the xrunPlusArgs.f in the Simulation folder

  For more information access: http://www.autosoc.org

***************************************************************************** */

`define TEST_NAME_STRING "mor1kx"

/* Set Correct CPU Option or lockstep  */
//`define MOR1KX_CPU_PIPELINE cappuccino
//`define MOR1KX_CPU_PIPELINE espresso
//`define MOR1KX_CPU_PIPELINE prontoespresso

// If lockstep is enabled MOR1KX_CPU_LOCKSTEP should be defined
// to enable the correct mapping of SoC

`ifdef LOCKSTEP
    `define MOR1KX_CPU_PIPELINE lockstep
    `define CPU_CONFIG "LOCKSTEP"
`else
    `define MOR1KX_CPU_PIPELINE cappuccino
    `define CPU_CONFIG "CAPPUCCINO"
`endif


// Set PARITY_CONFIG based on the defition of PARITY
`ifdef PARITY
    `define PARITY_CONFIG "ENABLED"
`else
    `define PARITY_CONFIG "DISABLED"
`endif

// Set CHECKPOINT_CONFIG based on the defition of CHECKPOINT
`ifdef CHECKPOINT
    `define CHECKPOINT_CONFIG "ENABLED"
`else
    `define CHECKPOINT_CONFIG "DISABLED"
`endif

// Set MEMECC_CONFIG based on the defition of MEM_ECC
`ifdef MEMECC
    `define MEMECC_CONFIG "ENABLED"
`else
    `define MEMECC_CONFIG "DISABLED"
`endif
