% This script Runs Problem 2 for Machine Learning Homework #4
% Created by Joe Ellis for Columbia University

% This loads the necessary data
close all; clear all;
load ShakespeareMiddleton.data

% Make this one if you will use the test
test = 1;
K = 4;
tests = 10;
% This is the number of mixtures

if test == 1
    test_logs = zeros(tests,1);
    train_logs = zeros(tests,1);
    test_num = 1;
    for k = 1:tests
       
        % Get some randomly decided test documents
        shakespeare_test = randperm(9,2);
        middelton_test = randperm(9,2) + 9;
        test_index = [shakespeare_test middelton_test];
        
        % Create the train and test splits randomly
        index = 1;
        for j = 1:18
            if sum(find(j==test_index)) == 0
                train_index(index) = j;
                index = index + 1;
            end
        end
        
        % Now create the train and test and run the multinomial model
        train = ShakespeareMiddleton(:,train_index);
        test = ShakespeareMiddleton(:,test_index);
        
        % This runs the EM mixture algorithm
        [train_l, r, mix_coeff, test_results, test_l] = mult_mix_model(train,K,1000,test);
        train_logs(test_num) = train_l;
        test_logs(test_num) = test_l;
        test_num = test_num + 1;
    end
        
        disp('The average training log-likelihood is')
        mean_train_logs = mean(train_logs)
        disp('The training standard deviation is')
        std_train_logs = std(train_logs)
        disp('The average testing log-likelihood is')
        mean_test_logs = mean(test_logs)
        disp('The testing standard deviation is')
        std_testing_logs = std(test_logs)
        
        disp('the trainign log-likelihoods')
        train_logs
        disp('The testing log-likelihoods')
        test_logs
        
    
end
    