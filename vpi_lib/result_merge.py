import os
import sys
import xml.etree.ElementTree as ET

def parse_result_xml(xml_path):
    tree = ET.parse(xml_path)
    root = tree.getroot()
    result = {}
    for elem in root:
        result[elem.tag] = elem.text.strip()
    return result

def aggregate_results(root_dir, output_file):
    results = []
    for subdir in os.listdir(root_dir):
        subdir_path = os.path.join(root_dir, subdir)
        if os.path.isdir(subdir_path):
            result_xml_path = os.path.join(subdir_path, 'result.xml')
            if os.path.exists(result_xml_path):
                result_data = parse_result_xml(result_xml_path)
                results.append(result_data)

    # Write aggregated results to the specified output file
    with open(output_file, 'w') as f:
        f.write("<LOCATION> <TYPE> <RESULT>\n")
        for idx, result in enumerate(results, 1):
            line = f"{result['LOCATION']}  {result['TYPE']}  {result['STATUS']}\n"
            f.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script_name.py directory_path output_file")
        sys.exit(1)
    
    input_dir = sys.argv[1]
    output_file = sys.argv[2]
    aggregate_results(input_dir, output_file)

