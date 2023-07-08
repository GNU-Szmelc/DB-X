import xml.etree.ElementTree as ET

def convert_xml_to_txt(xml_file, txt_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    # Find the sheet with the desired name
    ns = {'ss': 'urn:schemas-microsoft-com:office:spreadsheet'}
    sheet = root.find('.//ss:Worksheet[@ss:Name="Sheet1"]', ns)

    with open(txt_file, 'w') as output_file:
        for row in sheet.findall('ss:Table/ss:Row', ns):
            row_data = [cell.find('ss:Data', ns).text if cell.find('ss:Data', ns) is not None else '' for cell in row.findall('ss:Cell', ns)]
            row_text = '\t'.join(row_data)
            output_file.write(row_text + '\n')

    print(f"Conversion complete. Result saved to '{txt_file}'")

# Usage example
convert_xml_to_txt('input.xml', 'output.txt')
