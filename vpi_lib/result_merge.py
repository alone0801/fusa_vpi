import os
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict

def parse_result_xml(elem):
    result = {}
    for subelem in elem:
        if subelem.text is not None:
            result[subelem.tag] = subelem.text.strip()
        else:  result[subelem.tag] = None
    return result

def aggregate_results(root_dir):
    results = []
    for subdir in os.listdir(root_dir):
        subdir_path = os.path.join(root_dir, subdir)
        if os.path.isdir(subdir_path):
            result_xml_path = os.path.join(subdir_path, 'result.xml')
            if os.path.exists(result_xml_path):
                with open(result_xml_path, 'r', encoding='utf-8') as file:
                    xml_content = file.read()
                num = xml_content.index('\n')
                xml_content_with_root = xml_content[:num+1]+'<root>\n'+ xml_content[num+1:] + '</root>'
                tree = ET.ElementTree(ET.fromstring(xml_content_with_root))
                root = tree.getroot()
                for elem in root:
                    result_data = parse_result_xml(elem)
                    results.append(result_data)
    return results

def result_output(results, output_file):
    # Write aggregated results to the specified output file
    with open(output_file, 'w') as f:
        f.write("<LOCATION> <TYPE> <TIME> <SET_RETURN_TIME> <RESULT>\n")
        for idx, result in enumerate(results, 1):
            if result['LOCATION'] is not None:
                line = f"{result['LOCATION']}  {result['TYPE']}  {result['TIME']}  {result['SET_RETURN_TIME']}  {result['STATUS']}\n"
                f.write(line)

def parse_FI_xml(elem):
    # 处理当前节点的子节点
    results = defaultdict(list)
    for child in elem:
        child_dict = parse_FI_xml(child) if len(child) else child.text.strip() if child.text else None
        results[child.tag].append(child_dict)
    return results

def summary_output(results, output_file, good_sim_log, FI_file, time_file):
    UU = 0
    UD = 0
    DU = 0
    DD = 0
    for result in results:
        if result['LOCATION'] is not None:
            fault_result = result['STATUS']
            if fault_result == 'UU':
                UU = UU + 1
            elif fault_result == 'UD':
                UD = UD + 1
            elif fault_result == 'DU':
                DU = DU + 1
            else:
                DD = DD + 1
    with open(output_file, 'w') as f:
        f.write("Fault Injection Summary\n")
#Design hierarchy summary
        with open(good_sim_log, 'r') as f1:
            comp_results = []
            in_section = False
            for line in f1:
                if not in_section:
                    if "Design hierarchy summary" in line:
                        in_section = True
                        comp_results.append(line)
                else:
                    if "Writing initial simulation" in line:
                        break
                    comp_results.append(line)
        for result in comp_results:
            f.write(result)
#FI configuration
        with open(FI_file, 'r', encoding='utf-8') as f2:
            xml_content = f2.read()
        xml_tree = ET.ElementTree(ET.fromstring(xml_content))
        root = xml_tree.getroot()
        FI_result = parse_FI_xml(root)
        FAULT_TARGET = FI_result['FAULT_TARGET']
        FAULT_EXCLUDE = FI_result['FAULT_EXCLUDE']
        TB_NAME = FI_result['TESTBENCH_NAME']
        DUT_NAME = FI_result['DUT_NAME']
        CHECKER_STROBE = FI_result['OBSERVATION_POINTS'][0]['CHECKER_STROBE']
        FUNCTIONAL_STROBE = FI_result['OBSERVATION_POINTS'][0]['FUNCTIONAL_STROBE']
        NOSTOP_STROBE = FI_result['OBSERVATION_POINTS'][0]['NOSTOP_STROBE']
        ISO_MODE = FI_result['ISO_MODE']
        CON = FI_result['CON']
        f.write("\tTestbench Name:\n")
        if TB_NAME != None:
            for tb_name in TB_NAME:
                f.write("\t\t{}\n".format(tb_name))
        f.write("\tDut Name:\n")
        if DUT_NAME != None:
            for dut_name in DUT_NAME:
                f.write("\t\t{}\n".format(dut_name))
        f.write("\tFault Target:\n")
        if FAULT_TARGET != None:
            for fault_target in FAULT_TARGET:
                f.write("\t\t{}\n".format(fault_target))
        f.write("\tFault Exclude:\n")
        if FAULT_EXCLUDE != None:
            for fault_exclude in FAULT_EXCLUDE:
                f.write("\t\t{}\n".format(fault_exclude))
        f.write("\tChecker Strobe:\n")
        if CHECKER_STROBE != None:
            for checker_strobe in CHECKER_STROBE:
                f.write("\t\t{}\n".format(checker_strobe))
        f.write("\tFunctional Strobe:\n")
        if FUNCTIONAL_STROBE != None:
            for functional_strobe in FUNCTIONAL_STROBE:
                f.write("\t\t{}\n".format(functional_strobe))
        f.write("\tNostop Strobe:\n")
        if NOSTOP_STROBE != None:
            for nostop_strobe in NOSTOP_STROBE:
                f.write("\t\t{}\n".format(nostop_strobe))
        if ISO_MODE != None:
            for iso_mode in ISO_MODE:
                f.write("\tIsolation mode: {}\n".format(iso_mode))
        if CON != None:
            for con in CON:
                f.write("\tConcurreny number: {}\n".format(con))
#Fault Classification Result
        f.write("\tFault Classification Result:\n")
        f.write("\t\tUU: {}\n\t\tUD: {}\n\t\tDU: {}\n\t\tDD: {}\n".format(UU, UD, DU, DD))
        FC = (UD + DD)/(UD + DU + DD)*100
        f.write("\t\tFault Coverage: {:.2f}%\n".format(FC))
#CPU Run Time
        with open(time_file, 'r') as f3:
            run_time = f3.read().strip()
        f.write("\tCPU Run Time: {}s\n".format(run_time))
if __name__ == "__main__":
    if len(sys.argv) != 7:
        print("Usage: python script_name.py directory_path output_file")
        sys.exit(1)
    result = []
    input_dir = sys.argv[1]
    result_file = sys.argv[2]
    summary_file = sys.argv[3]
    good_sim_log = sys.argv[4]
    FI_file = sys.argv[5]
    time_file = sys.argv[6]
    results = aggregate_results(input_dir)
    result_output(results, result_file)
    summary_output(results, summary_file, good_sim_log, FI_file, time_file)

