clc
clear

%% Get directory information setup from user

current_directory = pwd;

directory_files_to_grade = uigetdir(current_directory, 'Student Files Directory');

% Get a list of all the files in student files directory
files_struct = dir(directory_files_to_grade);
files = {files_struct.name}; % Can access using files{i}
[~, n] = size(files); % n is number of files

for i = 1:n
    f = files{i}; %Get the current file
    data = split(f,'.'); % Splits into {assignment, username, attempt, data, name}
    
    % Catch the '.' and '..' cases
    if length(split(f,'_')) == 1
        continue
    end
    if data(end) == "m"
        publish_file_name = fullfile(directory_files_to_grade, f);
        options = struct('format','pdf','evalCode',false,'catchError',false);
        publish(publish_file_name, options);
    end
end