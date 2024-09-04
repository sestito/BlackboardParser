clear 
close all
clc

i=randi([1,20]); %generate a random number between 1 and 20
x=rndSum(i); %call function to add i amount of random numbers together
s=sprintf("Adding %d random numbers together gives you %.3f",i,x); %Put the numbers in a readable text format
disp(s) %display results

