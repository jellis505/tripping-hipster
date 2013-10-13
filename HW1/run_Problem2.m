% Script that runs Cross-Validation for Problem 2
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section 2
% This will produce to vectors of length 100
% X = the input variables
% y = the output labels (1 or 0)
clear all; close all;
load('Data/dataset1b.mat')

% The number of harmonics that we want to use to describe the points
k = 1:1:20;

% let's store the 10-fold cross validation accuracies in a vector, and then
% use the one that has the best accuracy at the end to do the final
% classification of the test set.
cross_val_errs_across_tests = zeros(1,length(k));

% Seperate the dataset into 1-100 and 101-200 as stated in the homework
% x_set2 and y_set2 are what the final test results will be given and set1
% will be used for cross validation
x_set1 = x(1:100);
x_set2 = x(101:200);
y_set1 = y(1:100);
y_set2 = y(101:200);

% This is the number of cross val steps
cross_val_steps = 100;
for i = 1:length(k)
    %disp(sprintf('Solving for k = %d',k(i)));
    cross_val_errs = zeros(1,cross_val_steps);
    for j = 1:cross_val_steps
        
        % Set up the cross validation steps
        [x_train,y_train,x_test,y_test] = GetCrossValGroups(x_set1,y_set1,0.8);

        % Do this process for every example of k
        [err,model,errT] = sinusoidalreg(x,y,k(i),false,x_test,y_test);
        
        % Store the cross validation errors
        cross_val_errs(j) = errT;
        
    end
    cross_val_errs_across_tests(i) = mean(cross_val_errs);
end

for i = 1:length(k)
    output_string = sprintf('The error for k = %d is %f',k(i)-1,cross_val_errs_across_tests(i));
    disp(output_string)
end

% This portion shows the fit of the 
PlotErrors(cross_val_errs_across_tests,k+1)

% Now do the testing on the whole dataset
[err,model,errT] = sinusoidalreg(x_set1,y_set1,6,true,x_set2,y_set2);
err
errT
model
