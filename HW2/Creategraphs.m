% Creategraphs.m
% Created by Joe Ellis
%   Description:
%   This is a utility script that wraps RunProblem4 so that many values of C and paramter p1, can be tried in one run.  
%   The script then automatically generates the surf plot for a given bunch of trial runs.

% This section is used for the times, when there are 2 variables in the
% classification for the svm. 
figure
C_vec = [.001,.01,.1,1,10,100,1000];
other_var = [.001,.01,.1,1];

% Calculate the accuracy matrix for each variable
accuracy = zeros(length(C_vec),length(other_var));
for i = 1:length(C_vec)
    for j = 1:length(other_var)
        accuracy(i,j) = RunProblem4('svm-dataset.mat','poly',C_vec(i),other_var(j));
    end
end

% Now create the graph
h = surf(other_var,C_vec,accuracy);
% Change the scales to log scale for the logarithmic variables to make the
% plot look better.
set(get(h,'Parent'),'YScale','log')
set(get(h,'Parent'),'XScale','log')


% This section is used whenever we only want to use linear only
% classification and the only input value is the alpha parameter.
figure
% Calculate the accuracy matrix for linear only
% other_var(j) not used in this version
accuracy = zeros(length(C_vec),1);
for i = 1:length(C_vec)
        accuracy(i) = RunProblem4('svm-dataset.mat','linear',C_vec(i),other_var(j));
end

% Now create the graph
b = plot(C_vec,accuracy,'bo-');
% Change the scale of the x axis to log scale to improve plotting.
set(get(b,'Parent'),'XScale','log')
