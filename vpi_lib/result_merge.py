import os
import sys
import xml.etree.ElementTree as ET

def parse_result_xml(elem):
    result = {}
    for subelem in elem:
        if subelem.text is not None:
            result[subelem.tag] = subelem.text.strip()
        else:  result[subelem.tag] = None
    return result

def aggregate_results(root_dir, output_file):
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

    # Write aggregated results to the specified output file
    with open(output_file, 'w') as f:
        f.write("<LOCATION> <TYPE> <VALUE> <TIME> <SET_RETURN_TIME> <RESULT>\n")
        for idx, result in enumerate(results, 1):
            if result['LOCATION'] is not None:
                line = f"{result['LOCATION']}  {result['TYPE']}  {result['VALUE']}  {result['TIME']}  {result['SET_RETURN_TIME']}  {result['STATUS']}\n"
                f.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script_name.py directory_path output_file")
        sys.exit(1)
    
    input_dir = sys.argv[1]
    output_file = sys.argv[2]
    aggregate_results(input_dir, output_file)

