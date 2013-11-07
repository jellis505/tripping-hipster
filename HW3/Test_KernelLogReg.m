function [ accuracy, predicted ] = Test_KernelLogReg( w,TrainX,TestX,TestY )
%Test_KernelLogReg This takes the test set and the training set, creates
%the gram matrix, and then returns the accuracy and the predicted labels

% Create the gram matrix, for the test set
Test_Gram = pdist2(TestX,TrainX);

for k = 1:size(Test_Gram,1)
       
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


