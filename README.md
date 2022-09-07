# Blackboard Parser
A Matlab program which parses the data files from Blackboard assignments and splits them into folders based on the Blackboard username.

1. To use, create a folder (anywhere) for your assignment. An example of this is the *example* folder in this directory.

2. Next, download all of the files for the assignment. An example of this is in *example/files_from_blackboard*

3. Next, run the *BlackboardParser.m* script. 

    3.1. When prompted, select the folder with all files from the assignment. An example of this is the *example/files_from_blackboard* folder.

    3.2. When prompted, you may select an instructor file to be copied to every student's folder. During this example, you may wish to select the *example/solution/a_test.m* file. You may select multiple. **Be careful, as if these files are named the same as a student's file, the student's file will be overwritten.**

4. Your parsed files will be placed at the same folder level as your folder with the assignment files. 

5. A .xls file will be created with all of the usernames.

To try this out, go ahead and run the *BlackboardParser.m* on the example!

# Matlab Similarity Checker
There is also an included plagiarism checker for Matlab code. Please see the Readme in the *PlagiarismCheckerForMatlabCode* for more information.
