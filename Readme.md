# Fusa_vpi Fault Injection Platform

## What is Fusa_vpi?
**Fusa_vpi** is an extension of the standard Verilog simulator that introduces fault injection capabilities to verify the effectiveness of the safety mechanisms (SM) in a target circuit. This platform is specifically designed for functional safety verification of automotive chips, helping developers meet the requirements of ISO 26262 and achieve the appropriate Automotive Safety Integrity Level (ASIL).

## Features of Fusa_vpi

1. **Fault Injection:**
   Fusa_vpi supports three basic types of fault injection:
   - **SA0** (Stuck-at 0)
   - **SA1** (Stuck-at 1)
   - **SEU** (Single Event Upset)

   These fault types cover most scenarios required for functional safety testing.

2. **Fault Classification:**
   After injecting faults into the circuit, it is crucial to classify them accurately and efficiently. Fusa_vpi supports two modes for fault classification:
   - **Single Observation Point Mode**
   - **Dual Observation Point Mode**

   For the dual observation point mode, you can define two observation points: the functional point and the diagnostic point. The platform classifies faults by monitoring these points, with categories such as:
   - **DD** (Function Point Detected, Diagnostic Point Detected)
   - **DU** (Function Point Detected, Diagnostic Point Undetected)
   - **UD** (Function Point Undetected, Diagnostic Point Detected)
   - **UU** (Function Point Undetected, Diagnostic Point Undetected)
   
   As long as you get these fault types for all faults,you can compute the disagnostic coverage of your target circuit.
3. **Support simulator:**
Every Simulator with VPI could directly use this platform to enable fault injection and report ,such as vcs , xcelium , icarus verilog.At present, this platform is developed and adapted based on VCS.In the future, the adaptation of each emulator will be improved.However, some emulators may have incomplete support for VPI libraries, such as iverilog, which can lead to the emasculation of some features, such as fault isolation.
4. **Fault Space Generation and Optimation:**
As a full-process platform,you can use fusa_vpi to generate a fault list for your circuit to know every faultable node . You need this list in later flow of funcitonal safety verificaiton.This platform can generate the fault space and optimze it to accelerate the fault inject campaign.
5. **Fault isolation:**
This platform build a system based on Verilog Procedual Interface(VPI),using a technique of non-intrusive fault injeciton.Therefore this will introduce a promblem of fault backword-propagation.This platform has proposed a method to automatically isolate the fault propagation.
## 
## Quick Start: Fault Injection Campaign

1. Source the setup file:
   ```bash
   source setup.sh
   cd crc_demo  
   make good_sim 
   make fualt_sim
   sh fault.csh
2. Build your own fault inject campaign:
   
   1.config your fault inject compaign in FI.xml:
    <FI_CONFIG>
        <FAULT_TARGET>test.dut_inst.mem1_i</FAULT_TARGET>
        <!--<FAULT_TARGET>test.dut_inst.mem2_i</FAULT_TARGET>-->
        <TESTBENCH_NAME>test</TESTBENCH_NAME>
        <OBSERVATION_POINTS>
        <CHECKER_STROBE>test.dut_inst.mem1_err_detected</CHECKER_STROBE>
        <CHECKER_STROBE>test.dut_inst.mem2_err_detected</CHECKER_STROBE>
        <FUNCTIONAL_STROBE>test.dut_inst.mem1_data_out</FUNCTIONAL_STROBE>
        <FUNCTIONAL_STROBE>test.dut_inst.mem2_data_out</FUNCTIONAL_STROBE>
        <!--<FUNCTIONAL_STROBE>test.dut_inst.mem2_i.crc_gen_wr_i.d</FUNCTIONAL_STROBE>-->
        <!--<FUNCTIONAL_STROBE>test.dut_inst.mem2_i.crc_chk_i.rst_n</FUNCTIONAL_STROBE>-->
        <NOSTOP_STROBE>test.dut_inst.mem1_data_out</NOSTOP_STROBE>
        <NOSTOP_STROBE>test.dut_inst.mem2_data_out</NOSTOP_STROBE>
        <!--<NOSTOP_STROBE>test.dut_inst.mem2_i.crc_gen_wr_i.d</NOSTOP_STROBE>-->
        <!--<NOSTOP_STROBE>test.dut_inst.mem2_data_out</NOSTOP_STROBE>-->
        </OBSERVATION_POINTS>
        <ISO_MODE>ENA</ISO_MODE>
    </FI_CONFIG>
    
    2.choose your fault inject node and fault type in fault.xml:
    <INJECT>
        <ID>1</ID>
        <LOCATION>test.dut_inst.mem2_i.crc_chk_i.crc_gen_i.d</LOCATION>
        <TYPE>SA1</TYPE>
        <TIME>0</TIME>
    </INJECT>

3. For a more complex demo , refer to the diectory of AutoSoc to learn.