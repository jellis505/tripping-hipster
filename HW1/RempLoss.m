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

% Latex equation for logistic loss
% R_{emp}(\bm{\theta}) = \frac{1}{N}\sum\limits_{i=1}^N(y_{i}-1)log(1-f(x;\bm{\theta})) - y_{i}log(f(x;\bm{\theta})).

Loss_per_point = ((y-1).*log(1-LogRegFunc(x,theta)) - y.*log(LogRegFunc(x,theta)));

% Now we need to check to see if any of the points are NaN values due to
% rounding error.  
if any(isnan(Loss_per_point))
    nan_idx = isnan(Loss_per_point);
    Loss_per_point(nan_idx) = 0;
end

Loss = sum(Loss_per_point)/N;

end

