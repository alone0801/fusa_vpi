# Fusa_vpi Fault Injection Platform

## What is Fusa_vpi?

**Fusa_vpi** is an extension of the standard Verilog simulator that introduces fault injection capabilities to verify the effectiveness of the safety mechanisms (SM) in a target circuit. This platform is specifically designed for functional safety verification of automotive chips, helping developers meet the requirements of **ISO 26262** and achieve the appropriate **Automotive Safety Integrity Level (ASIL)**.

## Features of Fusa_vpi

### 1. Fault Injection
Fusa_vpi supports three basic types of fault injection:

- **SA0** (Stuck-at 0)
- **SA1** (Stuck-at 1)
- **SEU** (Single Event Upset)

These fault types cover most scenarios required for functional safety testing.

### 2. Fault Classification
After injecting faults into the circuit, it's essential to classify them accurately and efficiently. Fusa_vpi supports two modes for fault classification:

- **Single Observation Point Mode**
- **Dual Observation Point Mode**

For dual observation mode, two observation points can be defined: the **functional point** and the **diagnostic point**. Faults are classified by monitoring these points into the following categories:

- **DD** (Function Point Detected, Diagnostic Point Detected)
- **DU** (Function Point Detected, Diagnostic Point Undetected)
- **UD** (Function Point Undetected, Diagnostic Point Detected)
- **UU** (Function Point Undetected, Diagnostic Point Undetected)

With these classifications, you can compute the diagnostic coverage of your target circuit.

### 3. Simulator Support
Fusa_vpi can be integrated with any simulator that supports VPI, including:

- **VCS**
- **Xcelium**
- **Icarus Verilog**

Currently, the platform is optimized for **VCS**, and future updates will enhance compatibility with other simulators. Note that some simulators, such as **Icarus Verilog**, may have incomplete VPI library support, potentially limiting certain features (e.g., fault isolation).

### 4. Fault Space Generation and Optimization
Fusa_vpi offers full-process fault injection capabilities, allowing you to:

- Generate a **fault list** for your circuit to identify all faultable nodes.
- Optimize the fault space to accelerate the fault injection campaign.

### 5. Fault Isolation
Fusa_vpi uses the **Verilog Procedural Interface (VPI)** to perform **non-intrusive fault injection**, minimizing backward-propagation of faults. It also includes an automatic method to isolate fault propagation.

---

## Quick Start: Fault Injection Campaign

Follow these steps to quickly get started with fault injection using Fusa_vpi:

### Step 1: Source the setup file
Run the following commands to begin the simulation:

```bash
source setup.sh
cd crc_demo  
make good_sim 
make fault_sim
sh fault.csh
```
### Step 2: Build Your Own Fault Injection Campaign
1. Configure your fault injection campaign in `FI.xml`:

```xml
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
```
2.choose your fault inject node and fault type in fault.xml:

```xml
<INJECT>
    <ID>1</ID>
    <LOCATION>test.dut_inst.mem2_i.crc_chk_i.crc_gen_i.d</LOCATION>
    <TYPE>SA1</TYPE>
    <TIME>0</TIME>
</INJECT>
```
### Step 3: Explore More Complex Demos
For more advanced usage, refer to the AutoSoc directory to explore more complex fault injection demos

Fusa_vpi provides a robust platform for functional safety verification, offering advanced features like fault classification, isolation, and space optimization to help developers meet the strict demands of automotive safety standards.