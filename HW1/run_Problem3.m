% Script that runs Cross-Validation for Problem 3
% Machine Learning -- Fall 2013 --  Columbia University
% Written by Joe Ellis

% Load the data for the HW1 section 3
% This will produce to vectors of length 200
% X = the input variables
% y = the output labels (1 or 0)
clear all; close all;
load('Data/dataset2.mat');

% Let's implement stochastic gradient descent to find the minimum of the
% logistic loss function
eta_step = 100;
epsilon_tolerance = .001;
theta = rand(1,3);

%Now let's use gradient descent to find the optimum solution
% Batch Gradient Descent
theta_diff = 1;
Loss = 0;
counter = 1;
while (theta_diff > epsilon_tolerance) 
    counter = counter + 1;
    old_theta = theta;
    grad = grad_Remp(X,Y,theta);
    %norm_grad = grad/(norm(grad));    
    theta = theta + eta_step*grad;
    Loss = RempLoss(X,Y,theta);
    theta_diff = norm(theta-old_theta)

end

% This section creates the output plots
pos_points = X(find(Y),1:2);
neg_points = X(find(~Y),1:2);
figure
title('Found Logistic Regression Solution')
hold on 
plot(pos_points(:,1),pos_points(:,2),'rx')
plot(neg_points(:,1),neg_points(:,2),'bo')

% Now let's plot our found logistic regression classifier
x_sweep = min(X(:)):(max(X(:))-min((X(:))))/300:max(X(:));
y_sweep = (-theta(1)*x_sweep-theta(3))/theta(2);
plot(x_sweep,y_sweep,'g-')
axis([-0.1 1 -1.1 1.1])



