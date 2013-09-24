function PlotErrors( error_vec, D )
%PlotErrors This function plots the error vectors and how it changes based
%on choice of dimension for Problem 1
%   Inputs:
%       - error_vec = The vector that holds the average squared training
%       loss
%       - D = The vector that corresponds to the dimension of each solution

figure 
plot(D,error_vec,'r-')
title('Value of Error Across Training Set')
xlabel('Dimension of Polynomial fit')
ylabel('Error')

end

