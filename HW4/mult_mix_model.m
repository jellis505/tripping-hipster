function [ train_l, responsibilities, mix_coeff, test_results, test_l ] = mult_mix_model( data , K , maxiter, test )
%mult_mix_model This function creates the multinomial mixture model using
%the derivations provided in the hand in.
%   Inputs:
%       - data = The data for the model, with each document on the column
%       - K = The number of mixtures
%       - maxiter = The max number of iterations allowed
%       - test = The test data in the same format as the "data" variable
%   Outputs:
%       - train_l = The log-likelihood of the multinomail mixture model 
%       created for the given data
%       - responsibilities = The responsibilities of each document for each
%       mixture
%       - mix_coeff = The final mix_coeff for the mixtures
%       - test_results = The responsibilities on the test set
%       - test_l = The log-likelihood on the test set

N = size(data,2);
M = size(data,1);
% K is the number of mixtures to include

% Random initialization
% We will randomly initalize the mixtures of each data set, for the mixture
random_mixture_coeff = rand(K,N);
if K > 1
    sums_of_mix = sum(random_mixture_coeff);
else
    sums_of_mix = random_mixture_coeff;
end


for z = 1:N
    for p = 1:K
        responsibilities(p,z) = random_mixture_coeff(p,z)/sums_of_mix(z);
    end
end
 
 % This is for debug purposes only
 %responsibilities = [0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25;
 %                    0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75];


% EM - algorithm, we will begin with the M step, because we intialized the
% parameters of the mixing coefficients first
iter = 1;
thresh = .0001;
delta_log_like = 1000;
log_likelihood(1) = -100000;
mix_coeff = zeros(K,1);
u_mat = zeros(M,K);
while (iter < maxiter) && (delta_log_like > thresh)
    iter = iter + 1;
    %%%%%%%%%%%%%%%%%%%%
    %%%%% M-STEP %%%%%%%
    %%%%%%%%%%%%%%%%%%%%
    %%% Calculate mixing coeff %%%%%%%%
    for i = 1:K
        mix_coeff(i) = sum(responsibilities(i,:))/N;
    end
    
    %%%% Calcluate mu variable %%%%%%%%%
    for j = 1:K
        denom = sum(sum(data).*responsibilities(j,:));
        for i = 1:M
            numerator = sum((responsibilities(j,:).*data(i,:)));
            u_mat(i,j) = numerator/denom;
        end
    end

    %%%%%%%%%%%%%%%%%%%%
    %%%%%% E-Step %%%%%%
    %%%%%%%%%%%%%%%%%%%%
    % Calculate the updated responsibilities for each point
    % We need to do something clever here to find the multinomial mixture
    % model of the documents with the given counts
    doc_log_probs_raw = zeros(K,N);
    for i = 1:N
        % We need to find the probability of each document under the given
        % mixture.  Let's do this using the log likelihood
        % Solve the log probabilites for each model

        
        % Let's calculate the normalization coefficients for the document
        % mutinomial count model
        for j = 1:K
            doc_log_probs_raw(j,i) = log(mix_coeff(j))+sum(data(:,i).*log(u_mat(:,j)));
        end
       
        % Now find the max of the doc log probs
        doc_log_probs = doc_log_probs_raw(:,i)/1000;
        max_log_prob = max(doc_log_probs);
        
        % Now we calculate the responsibilities of each element using the
        % trick that was dictated in the handout
        for j = 1:K
            responsibilities(j,i) = exp((doc_log_probs(j) - max_log_prob))/(sum(exp((doc_log_probs-max_log_prob))));
        end
        
    end
    x = sum(doc_log_probs_raw');
    train_log_likelihood(iter) = sum(mix_coeff.*x');
    train_l = sum(mix_coeff.*x');
    delta_log_like = (abs(train_log_likelihood(iter) - train_log_likelihood(iter-1)));
    
    % This outputs how much of each mixture the values have during the
    % iterations
    %if (iter == 2) || (mod(iter-1,5) == 0)
    %    figure
    %    r = responsibilities;
    %    plot(r(1,1:9),r(2,1:9),'ro',r(1,10:18),r(2,10:18),'b*');
    %    xlabel('Percentage of Mixture 1')
    %    ylabel('Percentage of Mixture 2')
    %    legend('Shakespearean Document', 'Middleton Document')
    %end
    
end


if nargin == 4
    % this section Tests the unseen documents as to what is thier
    % responsibilities and log-likelihood
    test_N = size(test,2);
    doc_log_probs_raw = zeros(K,test_N);
    for i = 1:test_N
            % We need to find the probability of each document under the given
            % mixture.  Let's do this using the log likelihood
            % Solve the log probabilites for each model


            % Let's calculate the normalization coefficients for the document
            % mutinomial count model
            for j = 1:K
                doc_log_probs_raw(j,i) = log(mix_coeff(j))+sum(test(:,i).*log(u_mat(:,j)));
            end

            % Now find the max of the doc log probs
            doc_log_probs = doc_log_probs_raw(:,i)/1000;
            max_log_prob = max(doc_log_probs);

            % Now we calculate the responsibilities of each element using the
            % trick that was dictated in the handout
            for j = 1:K
                test_results(j,i) = exp((doc_log_probs(j) - max_log_prob))/(sum(exp((doc_log_probs-max_log_prob))));
            end
            
            x = sum(doc_log_probs_raw');
            test_l = sum(mix_coeff.*x');

    end
else
    test_results = 0;
    test_l = 0;
end

end
