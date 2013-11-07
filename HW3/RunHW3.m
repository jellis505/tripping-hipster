function [ output_args ] = RunHW3( dataset_path )
%RunHW3 This function runs problem 5 of HW3 for ML at Columbia University

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

% Now let's perform gradient descent on the cost function
w = Ker_Logreg_Stograd( TrainingX,TrainingY,K_mat,.01,1000,.001 );

%disp('This is the trained weight value')




end

