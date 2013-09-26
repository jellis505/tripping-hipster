function [ grad_theta ] = grad_Remp(x,y,theta)
%grad_Remp This function calculates the gradient of the Remp loss with
%respect to theta
%   Put the latex expression here
%   Inputs:
%       - x = the data inputs
%       - y = the labels {0,1}
%       - theta = The current model that is performing the logistic
%       regression
%   Outputs: 
%       - grad_theta = The direction of the gradient at the current place
%       of theta

% Latex Equation for Partial Derivatives
% \frac{\partial R_{emp}}{\partial \theta_{j}} = \frac{1}{N}\sum\limits_{i=1}^N(y_{i}-f(x;\bm{\theta}))x_{ij}.

grad_theta = zeros(1,length(theta));
N = length(x);

for i = 1:length(theta) 
    % This function finds the partial with respect to theta
    %partial_for_theta = sum((((1-y)./(1-LogRegFunc(x,theta_val))) - (y./(LogRegFunc(x,theta_val)))).*(LogRegFunc(x,theta_val).*(1-LogRegFunc(x,theta_val))))/N;
    %grad_theta(i) = partial_for_theta;
    partial_for_theta = sum((y - LogRegFunc(x,theta)).*x(:,i))/N;
    grad_theta(i) = partial_for_theta;

end

end

