clear

%% Get directory information setup from user

current_directory = pwd;

directory_files_to_grade = uigetdir(current_directory, 'Student Files Directory');

% Setup directory at same level as files to grade directory
copy_to_name = 'parsed';
copy_to = strcat(directory_files_to_grade, '/../', copy_to_name);

% Get all the files we'd like to copy to each student's folder
[files_to_copy, solution_dir] = uigetfile(strcat(directory_files_to_grade, '/../'),...
    'Select Files to Copy to each student folder...',...
    'MultiSelect', 'on');

if ~iscell(files_to_copy)
    files_to_copy = {files_to_copy};
end


%% Get an array of all the student ids
% This assumes the file format is 
%  STUDENT_ID#_ATTMEPT_FILENAME

% Get a list of all the files in student files directory
files_struct = dir(directory_files_to_grade);
files = {files_struct.name}; % Can access using files{i}
[~, n] = size(files); % n is number of files

% Get all the names of the students
student_names_temp = cell(n,1); % Create temperary cell array. We know there can't be more than n students
num_names = 0; % This iterator will track actual number of students
for i = 1:n
    f = files{i}; %Get the current file
    data = split(f,'_'); % Splits into {assignment, username, attempt, data, name}
    
    % Catch the '.' and '..' cases
    if length(data) == 1
        continue
    end
    name = data{1}; % Get the username of the student
    
    if ~any(strcmp(student_names_temp,name)) % See if name is currently been found
        % Name not found, add it.
        num_names = num_names + 1;
        student_names_temp{num_names} = name;
    end
end
% Copy names into new cell array
student_names = cell(num_names,1);
for i = 1:num_names
    student_names{i} = student_names_temp{i};
end
clear student_names_temp %Cleanup variable

%% Copy all students m files to parsed folder

mkdir(copy_to)
for student_count = 1:num_names % Should be num_names
    student = student_names{student_count};
    student_dir = [copy_to,'/',student,'/'];
    student_dir = join(student_dir);
    mkdir(student_dir);
    
    % Copy all files for a student to temp and rename
    for i = 1:n
        f = files{i}; % Get current file
        data = split(f,'_');
        if length(data) == 1
            continue
        end
        student_check = data{1};

        if strcmp(student, student_check) % This is one of the student's files
            name = data{end};

            source = [directory_files_to_grade, '/', f];
            source = join(source);
            destination = [student_dir, '/', strip(name)];
            destination = join(destination);
            
            copyfile(source,destination);
        end
    end
  
end

%% Copy necessary files to each students folder
if files_to_copy{1} ~= 0 % Checks if no files are selected
    [~,m] = size(files_to_copy);
    for j = 1:num_names
        for i = 1:m
            f = files_to_copy{i};
            source = [solution_dir,'/',f];
            destination = [copy_to,'/',student_names{j},'/',f];
            copyfile(source,destination);
        end
    end
end


%% Write an xls file for grading

grades = cell(num_names+1,1);
grades{1,1} = 'Username';

for i = 1:num_names % Check each student
    student = student_names{i};
    grades{i+1,1} = student;
end
xls_file = strcat(directory_files_to_grade, '/../', 'grades.xls');

xlswrite(xls_file,grades)