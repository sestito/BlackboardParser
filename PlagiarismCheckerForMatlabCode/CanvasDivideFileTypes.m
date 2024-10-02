clear


current_directory = pwd;
directory_files_to_grade = uigetdir(current_directory, 'Student Files Directory');

filetype = '*.m';

% Get locatin to put all files for plagerism check
directory_copy_location = strcat(directory_files_to_grade, '/../', 'PlagerismCheck');
mkdir(directory_copy_location)

%%
% Get a list of all the files in student files directory
files_struct = dir(strcat(directory_files_to_grade, '/', filetype));
files = {files_struct.name}; % Can access using files{i}
[~, n] = size(files); % n is number of files

% Get all the names of the files
files_temp = cell(n,1); % Create temperary cell array. We know there can't be more than n students
num_names = 0; % This iterator will track actual number of students
for i = 1:n
    f = files{i}; %Get the current file
    data = split(f,'_'); % Splits into {assignment, username, attempt, data, name}
    
    % Catch the '.' and '..' cases
    if length(data) == 1
        continue
    end
    name = data{end}; % Get the username of the student

    % Check for - at the end of the files. Like hw1-1.m
    name_split = split(name,'-');
    if length(name_split) > 1
        first = name_split{1};
        name_split_again = split(name_split{end}, '.');
        last = name_split_again{end};
        name = strcat(first, '.', last);
    end
    
    if ~any(strcmp(files_temp,name)) % See if name is currently been found
        % Name not found, add it.
        num_names = num_names + 1;
        files_temp{num_names} = name;
    end
end
% Copy names into new cell array
file_names = cell(num_names,1);
for i = 1:num_names
    file_names{i} = files_temp{i};
end
clear files_temp %Cleanup variable

%%

for student_count = 1:num_names
    student = file_names{student_count};
    student_dir = [directory_copy_location,'/',student,'/'];
    student_dir = join(student_dir);
    mkdir(student_dir);
    
    % Copy all files for a student to temp and rename
    for i = 1:n
        f = files{i}; % Get current file
        data = split(f,'_');
        if length(data) == 1
            continue
        end
        student_check = data{end};
        
        % Check for - at the end of the files. Like hw1-1.m
        name_split = split(student_check,'-');
        if length(name_split) > 1
            first = name_split{1};
            name_split_again = split(name_split{end}, '.');
            last = name_split_again{end};
            student_check = strcat(first, '.', last);
        end


        if strcmp(student, student_check) % This is one of the student's files
            s_name = data{1};

            name = strcat(s_name,'-',strip(student_check));
            

            source = [directory_files_to_grade, '/', f];
            source = join(source);
            destination = [student_dir, '/', strip(name)];
            destination = join(destination);
            
            copyfile(source,destination);
        end
    end
end
