function [ w ] = Ker_Logreg_Stograd( TrainX,TrainY,K_gram,Reg_Penalty,p,eta )
%Ker_Logreg_Stograd = This function performs the training using stochastic
%gradient descent, and randomly choosing the elements to use in the descent
%algorithm
%   Detailed explanation goes here

% Choose randomly the training points

% This is the threshold for stopping the gradient descent
thresh = 2.5;
grad_mag = 100;
num_points = size(TrainX,1);
w = rand(num_points,1);
while grad_mag > thresh

    % These are the points to traing the stochastic descent with
    batch_points = randperm(num_points,p);
    % Loop through each of the batch points
    
    % This portion gets the first term in the logistic regression
    sum_logistic_errors = zeros(length(w),1);
    num_correct_class = 0;
    for j = 1:p
        sto_point = batch_points(j);
        % This calculates the k vector for this point
        K_j = K_gram(:,sto_point);
        
        % This adds up the gradients from each example
        correct_class = (1/(1+exp(-(-TrainY(sto_point)*w'*K_j))));
        num_correct_class = num_correct_class + correct_class;
        sum_logistic_errors = sum_logistic_errors + TrainY(sto_point)*K_j*(1/(1+exp(-(-TrainY(sto_point)*w'*K_j))));
        %sum_logistic_errors = sum_logistic_errors + (TrainY(sto_point) - (1/(1+exp(-w'*K_j)))).*K_j;
    end
    %accuracy_batch = 1 - (num_correct_class / p)
    
    % Add the regularizer penalty
    gradient_without_reg = sum_logistic_errors;
    gradient = (gradient_without_reg/p) - Reg_Penalty*(w);
    w = w + eta*gradient;
    
    % Calculate the cost function
    Cost = -sum((1/(1+exp(-TrainY.*(w'*K_gram)')))) + Reg_Penalty.*w'*w
    
    
    % Now let's find the classifier error
    correct = 0;
    for k = 1:num_points
        
        % This calculates the k vector for this point
        K_k = K_gram(:,k);
        pred = 0;
        if (1/(1+exp(-w'*K_k))) > 0.5
            pred = 1;
        else
            pred = -1;
        end
        
        % NOw predict the label
        if pred == TrainY(k)
            correct = correct + 1;
        end
    end
    accuracy = correct/num_points
    
end

end
