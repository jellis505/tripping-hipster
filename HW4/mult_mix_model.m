function [ log_likelihood ] = mult_mix_model( data , K , maxiter )
%mult_mix_model This function creates the multinomial mixture model using
%the derivations provided in the hand in.
%   Inputs:
%       - data = The data for the model, with each document on the column
%   Outputs:
%       - The log-likelihood of the multinomail mixture model created

N = size(data,2);
M = size(data,1);
% K is the number of mixtures to include
K = 2;

% Random initialization
% We will randomly initalize the mixtures of each data set, for the mixture
random_mixture_coeff = rand(K,N);
sums_of_mix = sum(random_mixture_coeff);
for z = 1:N
    for p = 1:K
        responsibilities(p,z) = random_mixture_coeff(p,z)/sums_of_mix(z);
    end
end
 disp(responsibilities)


% EM - algorithm, we will begin with the M step, because we intialized the
% parameters of the mixing coefficients first
iter = 0;
thresh = .0001;
delta_log_like = 1000;
log_like = 1000;
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
    disp(mix_coeff)
    pause(1)
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
    for i = 1:N
        % We need to find the probability of each document under the given
        % mixture.  Let's do this using the log likelihood
        % Solve the log probabilites for each model
        doc_log_probs = zeros(K,1);
        for j = 1:K
            doc_log_probs(j) = sum(log(mix_coeff(j).*data(:,i).*u_mat(:,j)));
        end
        % Now find the max of the doc log probs
        max_log_prob = max(doc_log_probs);
        
        % Now we calculate the responsibilities of each element using the
        % trick that was dictated in the handout

        for j = 1:K
            responsibilities(j,i) = exp(doc_log_probs(j) - max_log_prob)/(sum(exp(doc_log_probs-max_log_prob)));
        end
    end
    disp(responsibilities)
    
end



log_likelihood = 0;

end