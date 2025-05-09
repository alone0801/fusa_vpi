import os
from collections import defaultdict
from openpyxl import Workbook
from xml.etree import ElementTree as ET

def count_fault_types(file_path):
    """统计FM_x.txt中各种故障类型的数量"""
    counts = defaultdict(int)
    
    try:
        with open(file_path, 'r') as f:
            for line in f:
                if not line.strip() or line.startswith('#'):
                    continue
                
                parts = line.strip().split()
                if len(parts) >= 4:
                    fault_type = parts[3]
                    if fault_type in ['UU', 'UD', 'DU', 'DD']:
                        counts[fault_type] += 1
    
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
    
    return counts

def calculate_dcp(ud, du, dd):
    """计算DCp值"""
    try:
        ud_val = float(ud)
        du_val = float(du)
        dd_val = float(dd)
        denominator = ud_val + du_val + dd_val
        return (ud_val + dd_val) / denominator * 100 if denominator != 0 else 0.0
    except (ValueError, ZeroDivisionError):
        return 0.0

def calculate_spf(fit, fmd, dcp):
    """计算SPF值"""
    try:
        fit_val = float(fit)
        fmd_val = float(fmd)
        dcp_val = float(dcp)
        return fit_val * fmd_val * (1 - dcp_val / 100)
    except (ValueError, ZeroDivisionError):
        return 0.0

def calculate_spfm(fm_data, root):
    """计算SPFM值：1 - Σ(SPF/FIT)"""
    try:
        total_ratio = 0.0
        for element in root.findall('FM'):
            fm_id = element.find('FM_ID').text
            if fm_id not in fm_data:
                continue
                
            # 获取当前FM的SPF和FIT值
            spf_element = element.find('SPF')
            fit_element = element.find('FIT')
            
            if spf_element is None or fit_element is None:
                continue
                
            try:
                spf = float(spf_element.text)
                fit = float(fit_element.text)
                if fit != 0:
                    total_ratio += spf / fit
            except (ValueError, ZeroDivisionError):
                continue
        
        return 1 - total_ratio
    except Exception as e:
        print(f"Error calculating SPFM: {e}")
        return 0.0

def read_fm_values(fm_id, data_path):
    """从FM_x.txt文件中统计UU/UD/DU/DD数量"""
    file_path = os.path.join(data_path, f"{fm_id}.xml")
    if not os.path.exists(file_path):
        return 0, 0, 0, 0
    
    counts = count_fault_types(file_path)
    return counts['UU'], counts['UD'], counts['DU'], counts['DD']

def update_main_xml(xml_file, fm_data):
    """更新主XML文件中的值"""
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # 更新每个FM的字段
        for element in root.findall('FM'):
            fm_id = element.find('FM_ID').text
            if fm_id not in fm_data:
                continue
                
            uu, ud, du, dd, dcp, fit = fm_data[fm_id]
            
            # 更新现有字段
            if element.find('UU') is not None:
                element.find('UU').text = str(uu)
            if element.find('UD') is not None:
                element.find('UD').text = str(ud)
            if element.find('DU') is not None:
                element.find('DU').text = str(du)
            if element.find('DD') is not None:
                element.find('DD').text = str(dd)
            if element.find('DCp') is not None:
                element.find('DCp').text = f"{dcp:.2f}"
            
            # 添加或更新FMD字段
            fmd_element = element.find('FMD')
            if fmd_element is None:
                fmd_element = ET.SubElement(element, 'FMD')
            current_sum = uu + ud + du + dd
            fmd_value = current_sum / sum(sum(values[:4]) for values in fm_data.values()) if sum(sum(values[:4]) for values in fm_data.values()) != 0 else 0.0
            fmd_element.text = f"{fmd_value:.4f}"
            
            # 添加或更新SPF字段
            spf_element = element.find('SPF')
            if spf_element is None:
                spf_element = ET.SubElement(element, 'SPF')
            spf_value = calculate_spf(fit, fmd_value, dcp)
            spf_element.text = f"{spf_value:.6f}"
        
        # 计算并添加SPFM
        spfm_value = calculate_spfm(fm_data, root)
        spfm_element = root.find('SPFM')
        if spfm_element is None:
            spfm_element = ET.SubElement(root, 'SPFM')
        spfm_element.text = f"{spfm_value:.6f}"
        
        # 保存更新后的XML
        tree.write(xml_file, encoding='utf-8', xml_declaration=True)
    except Exception as e:
        print(f"Error updating main XML: {e}")

def parse_fmeda_xml(xml_file, data_path):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    data = []
    fm_data = {}  # 存储每个FM的数据用于后续计算总和
    
    # 第一遍：收集所有FM的基本数据
    for element in root.findall('FM'):
        fm_id = element.find('FM_ID').text
        uu, ud, du, dd = read_fm_values(fm_id, data_path)
        dcp = calculate_dcp(ud, du, dd)
        fit = element.find('FIT').text if element.find('FIT') is not None else "0"
        fm_data[fm_id] = (uu, ud, du, dd, dcp, fit)
    
    # 第二遍：计算FMD、SPF和SPFM并更新XML
    update_main_xml(xml_file, fm_data)
    
    # 准备Excel数据
    for element in root.findall('FM'):
        fm_id = element.find('FM_ID').text
        if fm_id not in fm_data:
            continue
            
        uu, ud, du, dd, dcp, fit = fm_data[fm_id]
        fmd = element.find('FMD').text if element.find('FMD') is not None else "0"
        spf = element.find('SPF').text if element.find('SPF') is not None else "0"
        
        part = element.find('Part').text if element.find('Part') is not None else ""
        subpart = element.find('Subpart').text if element.find('Subpart') is not None else ""
        failure_mode = element.find('Failure_Mode').text if element.find('Failure_Mode') is not None else ""
        sm = element.find('SM').text if element.find('SM') is not None else ""
        
        data.append([fm_id, part, subpart, failure_mode, fit, sm, 
                     uu, ud, du, dd, f"{dcp:.2f}%", fmd, spf])
    
    # 添加SPFM到Excel数据
    spfm = root.find('SPFM').text if root.find('SPFM') is not None else "0"
    data.append(["SPFM", "", "", "", "", "", "", "", "", "", "", "", f"SPFM={spfm}"])
    
    return data

def generate_fmeda_excel(data, output_file):
    wb = Workbook()
    ws = wb.active
    
    headers = ["FM_ID", "Part", "Subpart", "Failure Mode", "FIT", "SM", 
               "UU", "UD", "DU", "DD", "DCp %", "FMD", "SPF"]
    ws.append(headers)
    
    for row in data:
        ws.append(row)
    
    wb.save(output_file)

if __name__ == "__main__":
    xml_file = 'fmeda.xml'  
    output_file = 'fmeda.xlsx'
    data_path = 'fm_data'  # 存放FM_x.txt文件的目录
    
    if not os.path.exists(data_path):
        os.makedirs(data_path)
        print(f"Created directory {data_path}. Please place your FM_x.txt files there.")
    
    data = parse_fmeda_xml(xml_file, data_path)
    generate_fmeda_excel(data, output_file)
    
    print("FMEDA generated and updated successfully with FMD, SPF, and SPFM values")
