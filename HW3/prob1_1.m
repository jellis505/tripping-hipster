function [ prob_quarter, prob_half, prob_threequarter ] = prob1_1( H , T )
%prob1_1 This script calculates the 
%   This function finds the probability of the model given the discrete
%   parameters that we have.

% Let's take the probability of 
prob_quarter = (1/4)^H * (1-(1/4))^T * (1/3);
prob_half = (1/2)^H * (1-(1/2))^T * (1/3);
prob_threequarter = (3/4)^H * (1-(3/4))^T * (1/3);

% total_prob is the probablity of each added up, we can do this because we
% only have the three possible variables
total = prob_quarter + prob_half + prob_threequarter;
prob_quarter = prob_quarter/total
prob_half = prob_half/total
prob_threequarter = prob_threequarter/total

end

