import re

def convert_file(input_filename, output_filename):
    with open(input_filename, 'r') as infile, open(output_filename, 'w') as outfile:
        outfile.write("<LOCATION> <TYPE> <TIME> <RESULT>\n")

        for line in infile:
            if re.match(r'^\d+', line):  # Check if the line starts with a number
                match = re.match(r'(\d+) (\d+)fs \{ (\d+) "([^"]+)" \}', line)
                if match:
                    location = match.group(4)
                    #type_ = "SA0"
                    time = match.group(2)  # Extract only the number part
                    result = "UU"
                    outfile.write(f"{location} SA0 {time} {result}\n")
                    outfile.write(f"{location} SA1 {time} {result}\n")


if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python script_name.py <input_filename> <output_filename>")
    else:
        input_filename = sys.argv[1]
        output_filename = sys.argv[2]
        convert_file(input_filename, output_filename)
        print(f"File '{input_filename}' has been converted and saved as '{output_filename}'")
