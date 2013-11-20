function [ Cost ] = RunHW3( dataset_path )
%RunHW3 This function runs problem 5 of HW3 for ML at Columbia University
% dataset path is the path to the dataset, that was provided

% Load the data
load(dataset_path)

%Let's do the Kernel Logistic regression function, and train the logistic
%regression classifier.

% Solve for the K parameter
% I already solved for it, and the K = 103.4680.  Therefore, I will comment
% out the code below.
%{
N = size(TrainingX,1);
sum_val = 0;
for i = 1:N
    disp(i)
    for j = 1:N
        sum_val = sum_val + pdist([TrainingX(i,:); TrainingX(j,:)])^2;
    end
end
%}

% Now normalize the k parameter
%K = (1/N^2)*sum_val;
K = 103.4680;

% This creates the K matrix, uncomment this line if it is not stored in the
% dataset that we use.
K_mat = exp((pdist2(TrainingX,TrainingX)).^2/K);

% Now let's perform gradient descent on the cost function
[w,Cost,iter] = Ker_Logreg_Stograd( TrainingX,TrainingY,K_mat,.01,100,.001 );

% This creates a plot of the cost function, where the errors are not
% normalized by the log of the error.


% Now let's test for accuracy
[ accuracy ] = Test_KernelLogReg( w,TrainingX,TestX,TestY )

end

