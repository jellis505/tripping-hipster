% Script that runs Cross-Validation for Problem 3
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section 3
% This will produce to vectors of length 200
% X = the input variables
% y = the output labels (1 or 0)
clear all; close all;
load('Data/dataset2.mat')

% The third column of the X matrix is all the same, therefore it does not
% matter
X = X(:,1:2);

% Let's implement stochastic gradient descent to find the minimum of the
% logistic loss function
eta_step = .01;
epsilon_tolerance = .0001;
theta = rand(2,1);

%Now let's use gradient descent to find the optimum solution
% Batch Gradient Descent
theta_diff = 1;
while (theta_diff > eta_step)
    grad = grad_Remp(X,Y,theta)
    
    
    
    
end






