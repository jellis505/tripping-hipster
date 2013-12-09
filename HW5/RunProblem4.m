% This script runs problem 4 for the HW5 in Machine Learning
% Created by Joe Ellis
% Columbia University -- Fall 2013


close all; clear all;
% We will be building the junction tree algorithm for markov chain
% First initalize the values of each cell, choose the number of the markov
% chain in the line below equal to n

% This variable states how long we want the chain to be
n = 5;

% This variable controls if we want to run the test discussed in the HW
% test = 1 -- run the values assigned in the HW5 Problem 4
% test = 0 -- means run the JTA with randomly assigned values
test = 1;

if test == 1
    psis = cell(n-1,1);
    psis{1} = [0.1 0.7;0.8 0.3];
    psis{2} = [0.5 0.1;0.1 0.5];
    psis{3} = [0.1 0.5;0.5 0.1];
    psis{4} = [0.9 0.3;0.1 0.3];
    disp('Running with pre-determined psis')
else
    disp('Running with random preinitialized psis')
    psis = cell(n-1, 1);
    for i = 1:(n-1)
        psis{i} = rand(2,2);
    end
end

% Now we should initalize the sperators... Which are called phis, as 1's
phis = cell(n-2,1);
for i = 1:n-2
    phis{i} = ones(1,2);
end

% Now that the psis and phis are initialized let's perform the JTA
% aglorithm
% Left - Right algorithm pass
for i = 1:n-2
    % Add the first row to the second row
    phi_star = psis{i}(1,:) + psis{i}(2,:);
    % Do the first values top row of the psis value
    for j = 1:2
        psis{i+1}(j,:) = (phi_star(j)/phis{i}(j))*psis{i+1}(j,:);
    end
    phis{i} = phi_star;
end

% Now let's do the Right - Left Algorithm pass
% We will pass through this backwards
for i = n-2:-1:1
    % Add the first row to the second column, this is because we are moving
    % backward through the JTA algorithm
    phi_star = psis{i+1}(:,1) + psis{i+1}(:,2);
    % Now go through the first values and top row of the psis value
    for j = 1:2
        psis{i}(:,j) = (phi_star(j)/phis{i}(j))*psis{i}(:,j);
    end
    phis{i} = phi_star';
end

% Let's normalize each of the values of each psi, because 
for k = 1:n-1
    psis{k} = psis{k}/(sum(psis{k}(:)));
    psis{k}
end


    