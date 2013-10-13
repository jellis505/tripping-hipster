function [err,model,errT] = polyreg(x,y,D,xT,yT)
%
% Finds a D-1 order polynomial fit to the data
%
%    function [err,model,errT] = polyreg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing
%
% Example Usage:
%
% x = 3*(rand(50,1)-0.5);
% y = x.*x.*x-x+rand(size(x));
% [err,model] = polyreg(x,y,4);
%

% Latex Equation for this function 
% f(x;\bm{\theta}) = \bm{\theta}_{0}	+ \bm{\theta}_{1}x_{1} + \bm{\theta}_{2}x_{2} + ... + \bm{\theta}_{d}x_{d}

xx = zeros(length(x),D);
for i=1:D
  xx(:,i) = x.^(D-i);
end
model = pinv(xx)*y;

% Latex Equation
% R_{emp}(\bm{\theta}) = \frac{1}{N}\sum\limits_{i=1}^n (y_{i} - f(x_{i};\bm{\theta}))^{2}

err   = (1/(2*length(x)))*sum((y-xx*model).^2);

if (nargin==5)
  xxT = zeros(length(xT),D);
  for i=1:D
    xxT(:,i) = xT.^(D-i);
  end
  errT  = (1/(2*length(xT)))*sum((yT-xxT*model).^2);
end

q  = (min(x):(max(x)/300):max(x))';
qq = zeros(length(q),D);
for i=1:D
  qq(:,i) = q.^(D-i);
end

%{
clf
plot(x,y,'X');
hold on
if (nargin==5)
plot(xT,yT,'cO');
end
plot(q,qq*model,'r')
%}
