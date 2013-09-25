function [ value ] = LogRegFunc(x,theta)
%LogRegFunc This function calculates the regression value for
%the f(x,theta) described in problem 3.
% Put the latex math function here.
%   Inputs: 
%       - x = Any real dimensional vector
%       - theta = the model parameters to calulate the loss
%   Outputs:
%       - value = the value of the function
value = (1 + exp(1).^(x*-theta')).^-1; 
end

