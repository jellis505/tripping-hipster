function [err,model,errT] = sinusoidalreg(x,y,k,print_val,xT,yT)
%
% Finds a D-1 order Sinusoidal fit to the data
%
%    function [err,model,errT] = polyreg(x,y,D,xT,yT)
% Inputs:
%   - x = vector of input scalars for training
%   - y = vector of output scalars for training
%   - k = (k -1) the number of harmonics to use for this function
%   - xT = vector of input scalars for testing
%   - yT = vector of output scalars for testing
% Outputs: 
%   - err = average squared loss on training
%   - model = vector of polynomial parameter coefficients
%   - errT = average squared loss on testing


% For this section when we have k = 0 then we have cos(0) = 1, which is
% simply the bias of the function
% Create two matrices to hold the values for the cos and sin basis
% functions

% This section learns the model on the training labels, and then finds the
% squared loss error
xcos = zeros(length(x),k);
xsin = zeros(length(x),k);
for i=0:k
  xcos(:,i+1) = cos(i*x);
  xsin(:,i+1) = sin(i*x);
end
xboth = [xcos xsin];
model = pinv(xboth)*y;
err   = (1/(2*length(x)))*sum((y-(xboth*model)).^2);


% This section only operates if we have test data 
if (nargin>5)
  xcosT = zeros(length(xT),k);
  xsinT = zeros(length(xT),k);
  for i=0:k
    xcosT(:,i+1) = cos(i*xT);
    xsinT(:,i+1) = sin(i*xT);
  end
  xbothT = [xcosT xsinT];
  errT  = (1/(2*length(xT)))*sum((yT-xbothT*model).^2);
end


% This shows how the model looks when we interpolate it to all of the
% points in between the values
q  = (min(x):(max(x)/300):max(x))';
qcos = zeros(length(q),k);
qsin = zeros(length(q),k);
for i=0:k
  qcos(:,i+1) = cos((i)*q);
  qsin(:,i+1) = sin((i)*q);
end
qboth = [qcos qsin];


% Uncomment if you want to output the results

% Open up a new figure
if print_val
    figure
    %clf
    plot(x,y,'X');
    hold on
    if (nargin>5)
    plot(xT,yT,'cO');
    end
    plot(q,qboth*model,'r')

    % This section controls the output of the functions
    title_string = sprintf('k = %d',(k));
    title(title_string)
    xlabel('Input Data')
    ylabel('Ouput Labels')
end