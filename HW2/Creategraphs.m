% Creategraphs.m
% This script creates the graphs that can be seen in the paper for Problem4

% This sets up the vectors that we want to use to create the data
figure
C_vec = [.001,.01,.1,1,10,100,1000];
other_var = [.001,.01,.1,1];
%{
% Calculate the accuracy matrix
accuracy = zeros(length(C_vec),length(other_var));
for i = 1:length(C_vec)
    for j = 1:length(other_var)
        accuracy(i,j) = RunProblem4('svm-dataset.mat','poly',C_vec(i),other_var(j));
    end
end

% Now create the graph
h = surf(other_var,C_vec,accuracy);
set(get(h,'Parent'),'YScale','log')
set(get(h,'Parent'),'XScale','log')
%}

figure
% Calculate the accuracy matrix for linear only
% other_var(j) not used in this version
accuracy = zeros(length(C_vec),1);
for i = 1:length(C_vec)
        accuracy(i) = RunProblem4('svm-dataset.mat','linear',C_vec(i),other_var(j));
end

% Now create the graph
b = plot(C_vec,accuracy,'bo-');
set(get(b,'Parent'),'XScale','log')
