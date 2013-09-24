% Script that runs Cross-Validation for Problem 1
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section
% This will produce to vectors of length 10
% x = the input vector
% y = the output labels
clear all; close all;
load('Data\dataset1a.mat')

%We are provided the polyreg.m code for this problem so we will use this to
%find the error for a variety of different values of D.
% The values of D that we want to explore and plot can be seen below

D = [1 2 3 4 5 6 7 8 9 10];

for i = 1:length(D)
    
    % Get the error for simple training
    [error, theta] = polyreg(x,y,D(i));
    error_vec(i) = error;
    PlotPolyFits(x,y,theta,D(i))
    
end
    
% This function plots the error values
PlotErrors(error_vec,D);
