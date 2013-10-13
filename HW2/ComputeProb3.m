% Problem3script.m
% Created by Joe Ellis to compute the gram matrix
% This script creates the gram matrix and outputs it to the screen

% clear the variables;
clear all; close all;

% Here are the sample data points we have
X = [0.25 0.3 0.4; 0.2 0.4 0.25; 0.3 0.03 0.2; 0.1 0.2 0.15; 0.03 0.05 0.7];
sample_points = length(X);

% Compute the gram matrix
gram_matrix = zeros(sample_points,sample_points);
gram_matrix_int = zeros(sample_points,sample_points);
fun = @(var) (3/0.75).*((var/0.75).^(3-1)).*exp(-(var/0.75).^3);
for i = 1:sample_points
    for j = 1:sample_points;
        % Calculate the inner product
        dot_val = X(i,:)*X(j,:)';
        gram_matrix(i,j) = -1*(exp(-(dot_val/0.75)^3)) - (-1*(exp(-(0/0.75)^3)));
        gram_matrix_int(i,j) = integral(fun,0,dot_val);
    end
end
disp('Below is the gram_matrix')
gram_matrix
gram_matrix_int