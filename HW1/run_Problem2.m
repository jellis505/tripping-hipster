% Script that runs Cross-Validation for Problem 2
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section 2
% This will produce to vectors of length 100
% X = the input variables
% y = the output labels (1 or 0)
clear all; close all;
load('Data\dataset1b.mat')

% The number of harmonics that we want to use to describe the points
k = [1 5 10 20 25 50 100];
for i = 1:length(k)

    % Do this process for every example of k
    [err,model] = sinusoidalreg(x,y,k(i));
    size(model)

end

