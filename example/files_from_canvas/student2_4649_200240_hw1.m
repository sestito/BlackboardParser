close all
clear
clc

i=randi([1,20]); %generates random integer i between 1 and 20
x=rndSum(i); %calls rndSum function with input as i 
FormatSpec="A random integer %i is requested and put into the function, the sum of the numbers is %x ";
s=sprintf(FormatSpec,i,x); %formats variables in readable format
disp(s)
