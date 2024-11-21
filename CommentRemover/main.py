from tkinter import Tk
from tkinter.filedialog import askdirectory

import os
from os import listdir
from os.path import isfile, join

default_path = os.path.dirname(os.path.realpath(__file__))


working_directory = askdirectory(title='Select Folder', initialdir = default_path ) # shows dialog box and return the path

all_files = [f for f in listdir(working_directory) if isfile(join(working_directory, f))]
stripped_directory = "Stripped"
stripped_path = os.path.normpath(working_directory + os.sep + os.pardir)
stripped_path = os.path.join(stripped_path, stripped_directory)

if not os.path.isdir(stripped_path):
   os.makedirs(stripped_path)
else:
    raise Exception("Folder " + stripped_directory + " already exists!")


for file in all_files:
    
    file_type = file.split('.')[-1]
    parse_file = False

    match file_type:
        case 'm':
            block_comment_start = "%{"
            block_comment_end = "}"
            comment = "%"
            parse_file = True



  


        case 'py':
            block_comment_start = "'''"
            block_comment_end = "'''"
            comment = "#"
            parse_file = True


    if parse_file:
        file_path = os.path.join(working_directory, file)
        f = open(file_path, "r")
        
        

        file_text_new = ""
        file_text_new += comment + " Name: " + file.split("_")[0]
        file_text_new += "\n\n"

        block_comment = False
        for line in f:
            line_to_add = ""
            # Check for block comment
            if block_comment:
                if block_comment_end in line:
                    block_comment = False

            else:
                if block_comment_start in line:
                    split_text = line.split(block_comment_start)
                    if len(split_text) > 2:
                        raise Exception("More than one block comment in a line in " + file)
                    
                    if block_comment_end in split_text[1]:
                        pass
                    else:
                        block_comment = True

                    line_to_add += split_text[0]
                    if line_to_add != "":
                        line_to_add += '\n'
                
                # TODO: Add in something to catch % in strings
                elif comment in line:
                    split_text = line.split(comment)
                    line_to_add += split_text[0]
                    if line_to_add != "":
                        line_to_add += '\n'
                
                else:
                    line_to_add += line
                
            file_text_new += line_to_add

        f.close()

        file_name = os.path.join(stripped_path, file)
        f = open(file_name, "w")
        f.write(file_text_new)
        f.close()

    else:
        print(file)