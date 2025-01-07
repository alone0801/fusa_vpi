#include "vpi_user.h"

/* prototypes of the PLI registration routines */
extern void vcd_vpi_register();
extern void register_causalTree();
extern void register_dumpHier();
extern void register_dumpUpstream();
extern void register_eosCallback();
extern void register_evCallback();
extern void register_eventTree();
extern void register_extractMod();
extern void register_fault_injector();
extern void register_fault_modeling();
extern void register_iso();
extern void register_oscDetect();
extern void register_port_alias();
extern void register_StringList();
extern void register_timeRecord();
extern void register_traceSignal();
extern void register_vcdReader();
extern void register_vpiDebug();

void (*vlog_startup_routines[])() = 
{
    /*** add user entries here ***/
  vcd_vpi_register,
  register_causalTree,
  register_dumpHier,
  register_dumpUpstream,
  register_eosCallback,
  register_evCallback,
  register_eventTree,
  register_extractMod,
  register_fault_injector,
  register_fault_modeling,
  register_iso,
  register_oscDetect,
  register_port_alias,
  register_StringList,
  register_timeRecord,
  register_traceSignal,
  register_vcdReader,
  register_vpiDebug,
  NULL /*** final entry must be 0 ***/
};

