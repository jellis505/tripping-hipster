function [ bin_err ] = BinClassErr( x,y,theta )
%BinClassErr This function finds the binary class error using logistic
%regression across our current dataset
%   Inputs:
%       - x = The input data
%       - y = The output labels {0,1}
%       - theta = the current model parameters for logistic regression
%   Outputs:
%       - bin_err = the binary classification error

N = length(x);
value = LogRegFunc(x,theta);
class = round(value);
correct = sum(class==y);
bin_err = 1-(correct/N);

end

