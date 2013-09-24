function PlotPolyFits(x,y,theta,d)
%This function plots the fits given a data set, and then the model learned
%theta
%   Inputs:
%       - x = The inputs and the x axis values
%       - y = The labels learned from the polynomial regression
%       - theta = The learned model

figure
% This plots the points
plot(x,y,'X')
hold on
% Create the x vector for each of the points to draw the curve
points = (min(x):((max(x)-min(x))/100):max(x))';
xvec = zeros(length(points),d);
for i = 1:d
    xvec(:,i) = points.^(d-i);
end

% Calculate the y_vector value
yvec = xvec*theta;
plot(points,yvec,'b-')
xlabel('X points')
ylabel('Y Values')
title('Curve Fitting')
