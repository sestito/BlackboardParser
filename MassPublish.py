import os
from fpdf import FPDF

from tkinter import Tk
from tkinter.filedialog import askdirectory

def convert_py_to_pdf(folder_path, output_folder):
    # Create output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for file_name in os.listdir(folder_path):
        if file_name.endswith('.py'):
            input_file = os.path.join(folder_path, file_name)
            output_file = os.path.join(output_folder, file_name.replace('.py', '.pdf'))
            
            with open(input_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            # Create a PDF object
            pdf = FPDF()
            pdf.set_auto_page_break(auto=True, margin=10)
            pdf.add_page()
            pdf.set_font("Courier", size=10)
            
            # Add lines of code to the PDF
            for line in lines:
                pdf.multi_cell(0, 6, line)
            
            # Save the PDF
            pdf.output(output_file)
            print(f"Converted {file_name} to {output_file}")


import os
from os import listdir
from os.path import isfile, join

default_path = os.path.dirname(os.path.realpath(__file__))

working_directory = askdirectory(title='Select Folder', initialdir = default_path ) # shows dialog box and return the path

stripped_directory = "PDFs"
stripped_path = os.path.normpath(working_directory + os.sep + os.pardir)
stripped_path = os.path.join(stripped_path, stripped_directory)

if not os.path.isdir(stripped_path):
   os.makedirs(stripped_path)
else:
    raise Exception("Folder " + stripped_directory + " already exists!")

# Example usage
source_folder = working_directory
output_folder = stripped_path
convert_py_to_pdf(source_folder, output_folder)
