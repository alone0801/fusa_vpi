import os
import xml.etree.ElementTree as ET

def parse_result_xml(xml_path):
    tree = ET.parse(xml_path)
    root = tree.getroot()
    result = {}
    for elem in root:
        result[elem.tag] = elem.text.strip()
    return result

def aggregate_results(root_dir):
    results = []
    for subdir in os.listdir(root_dir):
        subdir_path = os.path.join(root_dir, subdir)
        if os.path.isdir(subdir_path):
            result_xml_path = os.path.join(subdir_path, 'result.xml')
            if os.path.exists(result_xml_path):
                result_data = parse_result_xml(result_xml_path)
                results.append(result_data)

    # Write aggregated results to a new file
    with open('aggregated_results.txt', 'w') as f:
        f.write("<ID> <LOCATION> <RESULT>\n")
        for idx, result in enumerate(results, 1):
            line = f"{idx}   {result['LOCATION']}  {result['STATUS']}\n"
            f.write(line)

if __name__ == "__main__":
    current_dir = os.getcwd()
    fault_dir = os.path.join(current_dir, "fault_dir")
    aggregate_results(fault_dir)






