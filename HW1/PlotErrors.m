function PlotErrors( error_vec, D )
%PlotErrors This function plots the error vectors and how it changes based
%on choice of dimension for Problem 1
%   Inputs:
%       - error_vec = The vector that holds the average squared training
%       loss
%       - D = The vector that corresponds to the dimension of each solution

figure 
plot(D-1,error_vec,'r-')
title('Average Cross-Valiadation Remp Loss vs. Model Complexity')
xlabel('Dimension of Polynomial Fit')
ylabel('Cross-Validation Remp Loss')

end

