import xml.etree.ElementTree as ET
import os
import sys
current_path =  os.getcwd()
print("PWD", current_path)
external_vars = ['TESTBENCH_NAME', 'INJECT_TIME', 'FAULT_TYPE', 'FAULT_LOCATION', 'CHECKER_STROBE', 'FUNCTIONAL_STROBE']
def extract_params(element, params):
    if element.tag in external_vars:
        if element.tag in params:
            if isinstance(params[element.tag], list):
                params[element.tag].append(element.text)
            else:
                params[element.tag] = [params[element.tag], element.text]
        else:
            params[element.tag] = element.text
    for child in element:
        extract_params(child, params)
# ReadXML
tree = ET.parse('FI.xml')
root = tree.getroot()

# Extract from xml
external_params = {}
extract_params(root, external_params)

# generate wrapper
verilog_code = """
`define SA0 0
module fi_wrapper();
    // generate strobe signal in wave.vcd while golden simualtion
    initial begin
    `ifdef good_sim
        $dumpfile("{current_path}/golden.vcd");
{dumpvars_checker}
{dumpvars_functional}
    `else
        $vcdCompare("{current_path}");
        $dumpfile("fault.vcd");
        $dumpvars(2);
        #{INJECT_TIME};
        force {FAULT_LOCATION} =`{FAULT_TYPE};
    `endif
    end
endmodule
"""

# use the xml_config to replace
dumpvars_functional = ''
dumpvars_checker = ''
if 'FUNCTIONAL_STROBE' in external_params:
    if isinstance(external_params['FUNCTIONAL_STROBE'], list):
        dumpvars_functional = '\n'.join(['\t\t$dumpvars(0, {});'.format(var) for var in external_params["FUNCTIONAL_STROBE"]])
    else:
        dumpvars_functional = '\t\t$dumpvars(0, {});'.format(external_params["FUNCTIONAL_STROBE"])

if 'CHECKER_STROBE' in external_params:
    if isinstance(external_params['CHECKER_STROBE'], list):
        dumpvars_checker = '\n'.join(['\t\t$dumpvars(0, {});'.format(var) for var in external_params["CHECKER_STROBE"]])
    else:
        dumpvars_checker = '\t\t$dumpvars(0, {});'.format(external_params["CHECKER_STROBE"])
verilog_code = verilog_code.format(current_path=current_path,dumpvars_checker=dumpvars_checker, dumpvars_functional=dumpvars_functional,**external_params)


# write to file
with open('fi_wrapper.v', 'w') as file:
    file.write(verilog_code)
print(external_params    ["CHECKER_STROBE"]);
print("Verilog code generate in fi_wrapper.v")

