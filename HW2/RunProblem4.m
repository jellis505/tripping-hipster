function [accuracy] = RunProblem4( dataset_path, type_of_svm, C , p1 )
%RUNPROBLEM4: This function furns the problem4 variables
%   Inputs:
%       - dataset_path = The path to svm-dataset.m
%       - type_of_svm = The type of kernel used for the svm
%       - C = the cost value for non-seperable section
%       - p1 = the first kernel input parameter, for poly this is the value
%       of the polynomial, and rbf it is the value of sigma
%   Outputs:
%       - No Outputs

% Add the path to the svm library
addpath('svm')

% This loads our dataset into the path
load(dataset_path)
num_trials = 10;
% The possible kernel functions are 
% "linear","poly","rbf","sigmoid"

for j = 1:num_trials

    % Now let's automatically pick half of the data to do classification then
    % testing
    total_vals = length(Y);
    perm_idx = randperm(total_vals);
    
    % Seperate the train_idx and test_idx
    train_idx = perm_idx(1:(total_vals/2)+1);
    test_idx = perm_idx(floor(total_vals/2)+1:total_vals);
    
    % Training and Testing Points
    train_data = X(train_idx,:);
    train_labels = Y(train_idx);
    test_data = X(test_idx,:);
    test_labels = Y(test_idx,:);
    
    % Now let's run the actual svm to get the accuracy
    [nsv alpha bias] = svc(train_data,train_labels,type_of_svm,C,p1);
    num_support_vecs(j) = nsv;
    
    % Now let's see what the accuracy is
    output_val = svcoutput(train_data,train_labels,test_data,type_of_svm,alpha,bias,0,p1);
    
    % Here is the svc error
    error = svcerror(train_data,train_labels,train_data,train_labels,type_of_svm,alpha,bias,p1);
    output_string = sprintf('The number of errors is: %d',error);
    disp(output_string)
    
    % Now let's calculate the accuracy
    total_test_vals = length(test_labels);
    correct = 0;
    for i = 1:length(test_labels)
        if test_labels(i) == output_val(i)
            correct = correct + 1;
        end
    end
    
    % This values keep the error and correct_list values
    error_list(j) = error;
    correct_list(j) = correct/total_test_vals;
    
end

correct = sum(correct_list)/length(correct_list);
nsv_sum = sum(num_support_vecs)/length(num_support_vecs);
accuracy = correct;

% Output the accuracy to the screen
output_string = sprintf('Classification: %f',correct);
disp(output_string)

% Output the accuracy to the screen
output_string = sprintf('# of support vectors: %f',nsv_sum);
disp(output_string)

end
