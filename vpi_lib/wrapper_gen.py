import xml.etree.ElementTree as ET

external_vars = ['TESTBENCH_NAME', 'INJECT_TIME', 'FAULT_TYPE', 'FAULT_LOCATION', 'CHECKER_STROBE', 'FUNCTIONAL_STROBE']

# ReadXML
tree = ET.parse('FI.xml')
root = tree.getroot()

# Extract from xml
external_params = {}
for elem in root.iter():
    if elem.tag in external_vars:
        external_params[elem.tag] = elem.text

# generate wrapper
verilog_code = """
`define SA0 0
module fi_wrapper();
    // fault_top instance
    {TESTBENCH_NAME} u_tb();
    // generate strobe signal in wave.vcd while golden simualtion
    initial begin
    `ifdef good_sim
        $dumpfile("golden.vcd");
{dumpvars_checker}
{dumpvars_functional}
    `else
        $vcdCompare("golden.vcd");
        $dumpfile("fault.vcd");
        $dumpvars(2);
        #{INJECT_TIME};
        force {FAULT_LOCATION} =`{FAULT_TYPE};
    `endif
    end
endmodule
"""

# use the xml_config to replace
dumpvars_functional = '\n'.join(['\t\t$dumpvars(0, {});'.format(var) for var in external_params["FUNCTIONAL_STROBE"].split(',')])
dumpvars_checker = '\n'.join(['\t\t$dumpvars(0, {});'.format(var) for var in external_params["CHECKER_STROBE"].split(',')])
verilog_code = verilog_code.format(dumpvars_checker=dumpvars_checker, dumpvars_functional=dumpvars_functional,**external_params)


# write to file
with open('fi_wrapper.v', 'w') as file:
    file.write(verilog_code)

print("Verilog code generate in fi_wrapper.v")
