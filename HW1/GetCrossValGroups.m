function [x_train,y_train,x_test,y_test] = GetCrossValGroups(x,y,percent_split)
%GetCrossValGroups Splits a group of data points into the desired
%percentages for testing, as specified by percent_split.  percent_split
%must be between 0 and 1.
%
%   Example: If x and y are of length 100 and percent_split is chosen as
% 0.8 then 80 points will be chosen randomly for testing and 20 chosen
% for the testing. 
%   Inputs:
%       - x = The data points in vector format
%       - y = The labels or ouput values to be chosen
%       - percent_split = Value between 0 and 1 deciding the split.
%   Outputs:
%       - x_train = the points chosen for training
%       - y_train = The labels chosen for training
%       - x_test = the points chosen for test
%       - y_test = the labels chosen for test

% Get the number of points
total_points = length(x);
train_points = floor(length(x)*percent_split);
test_points = total_points - train_points;

% Choose elements from x and y randomly
train_idx = randperm(total_points,train_points);

test_counter = 1;
for i = 1:total_points
    if any(i==train_idx)
        test_idx(test_counter) = i;
        test_counter = test_counter + 1;
    end
end


% Grab the training values
x_train = x(train_idx);
y_train = y(train_idx);

% Grab the test_values
x_test = x(test_idx);
y_test = y(test_idx);

end

