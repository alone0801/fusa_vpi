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

- Generate a **fault.set** for your circuit to identify all faultable nodes, this function can only run with VCS.
- Optimize the fault space to accelerate the fault injection campaign.

### 5. Fault Isolation
Fusa_vpi uses the **Verilog Procedural Interface (VPI)** to perform **non-intrusive fault injection**, minimizing backward-propagation of faults. It also includes an automatic method to isolate fault propagation.
Fault Isolation can only run when CON = 0.

---
## Quick Start: Fault Injection Campaign

Follow these steps to quickly get started with fault injection using Fusa_vpi:

### Step 0: Preparation
You need to install libxml2 by running the following commands:
Take CentOS for example

```bash
sudo yum install libxml2-devel
sudo ln -s /usr/include/libxml2/libxml /usr/include/libxml
sudo ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
sudo yum install libxml2
```

Then you need to replace the VPI library header file path in ./vpi_lib/Makefile with the corresponding path on your system, and run the following commands:

```bash
cd ./vpi_lib
make
```

### Step 1: Source the setup file
Run the following commands to begin the simulation:

```bash
source setup.sh
cd vpi_lib
make all
cd ..
cd crc_demo  
make good_sim_vcs/irun 
make fault_sim_vcs/irun
sh fault.csh <CON>
make merge
```
the result and summary are showed in result.xml and summary.xml

### Step 2: Build Your Own Fault Injection Campaign
1. Configure your fault injection campaign in `FI.xml`:

```xml
<FI_CONFIG>
    <FAULT_TARGET>test.dut_inst.mem1_i.mem_with_crc_i</FAULT_TARGET>
    <!--<FAULT_TARGET>test.dut_inst.mem2_i</FAULT_TARGET>-->
    <FAULT_EXCLUDE></FAULT_EXCLUDE>
    <TESTBENCH_NAME>test</TESTBENCH_NAME>
    <DUT_NAME>test.dut_inst</DUT_NAME>
    <!--FAULT_TYPE has 7 option: 1(SA0), 2(SA1), 3(SA), 4(SEU), 5(SET), 6(SE), 7(ALL)
    SA refers to all types of stuck-at fault
    SE refers to all types of soft error
    ALL refers to all types of fault
    Please specify the FAULT_TYPE option with number-->
    <FAULT_TYPE>3</FAULT_TYPE>
    <FAULT_TW_START>100</FAULT_TW_START>
    <FAULT_TW_END>200</FAULT_TW_END>
    <OBSERVATION_POINTS>
    <CHECKER_STROBE>test.dut_inst.mem1_err_detected</CHECKER_STROBE>
    <CHECKER_STROBE>test.dut_inst.mem2_err_detected</CHECKER_STROBE>
    <FUNCTIONAL_STROBE>test.dut_inst.mem1_data_out</FUNCTIONAL_STROBE>
    <FUNCTIONAL_STROBE>test.dut_inst.mem2_data_out</FUNCTIONAL_STROBE>
    <NOSTOP_STROBE>test.dut_inst.mem1_data_out</NOSTOP_STROBE>
    <NOSTOP_STROBE>test.dut_inst.mem2_data_out</NOSTOP_STROBE>
    </OBSERVATION_POINTS>
    <ISO_MODE>ENA</ISO_MODE>
    <CON>0</CON>
</FI_CONFIG>
```
2.choose your fault inject node and fault type in fault.set:
2.1 you can choose by yourself in fault.set
```fault.set
LOCATION> <TYPE> <VALUE> <TIME> <SET_RETURN_TIME> <RESULT>
test.dut_inst.mem1_i.mem_with_crc_i.clk  SA0  0  132  0  UU
.......
```
2.2 you also can generate fault.set adutomatically according to FI.xml
this function is only realized in VCS
```bash
cd crc_men
make good_sim_vcs
```

If fault.set is too big, Fault pruning can reduce the fault space according to the FUNCTIONAL STROBE based on the signal dependencies, this will remove all faults which are independent of FUNCTIONAL STROBE

```bash
cd crc_mem
make fault_prunning_vcs
make fault_gene
```
3. run the fault inject simulation
```bash
make fault_sim
sh fault.csh <CON>
make merge
```
the result and summary are showed in result.xml and summary.xml

4. you can replace source code with your design in SRC and run your fault inject simulation
according to the step 1 to 3

### Step 3: Explore More Complex Demos
For more advanced usage, refer to the AutoSoc directory to explore more complex fault injection demos

Fusa_vpi provides a robust platform for functional safety verification, offering advanced features like fault classification, isolation, and space optimization to help developers meet the strict demands of automotive safety standards.
