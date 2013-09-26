% Script that runs Cross-Validation for Problem 1
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section
% This will produce to vectors of length 10
% x = the input vector
% y = the output labels
clear all; close all;
load('Data/dataset1a.mat')

%We are provided the polyreg.m code for this problem so we will use this to
%find the error for a variety of different values of D.
% The values of D that we want to explore and plot can be seen below

D = [1 2 3 4 5 6 7];

% This values set up our cross validation steps
cross_val_steps = 1000;
cross_val_errs = zeros(length(D),cross_val_steps);
final_cross_val_errs = zeros(length(D),1);
percent_split = 0.9;

for i = 1:length(D)
    for j = 1:cross_val_steps
        
        % seperate the cross validation groups
        [x_train,y_train,x_test,y_test] = GetCrossValGroups(x,y,percent_split);
        
        % Get the error for simple training
        [error, theta, errT] = polyreg(x_train,y_train,D(i),x_test,y_test);
        cross_val_errs(i,j) = errT;
        %PlotPolyFits(x,y,theta,D(i))
    end
end
    
% Now find the mean of each of the cross value errors
for i = 1:length(final_cross_val_errs)
    final_cross_val_errs(i) = mean(cross_val_errs(i,:));
end

% This function plots the error values
PlotErrors(final_cross_val_errs,D);

% Now find the model for our desired 4 dimensional plot
[error, theta] = polyreg(x,y,4);
theta
error
PlotPolyFits(x,y,theta,4)
