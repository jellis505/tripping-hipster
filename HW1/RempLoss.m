function [ Loss ] = RempLoss(x,y,theta)
%RempLoss This function calculates the empirical loss for a function given
%a model and the values
%   Put the latex expression here
%   Inputs:
%       - x = the data inputs
%       - y = the labels {0,1}
%       - theta = The current model that is performing the logistic
%       regression
%   Outputs: 
%       - Loss = The empirical loss across the dataset
N = length(x);
Loss = (sum((y-1).*log(1-LogRegFunc(x,theta)) - y.*log(LogRegFunc(x,theta))))/N;
end

