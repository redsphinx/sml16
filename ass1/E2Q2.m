
hdifx = @(x,y) 2*x - 400*x*(-x.^2 + y) - 2
hdify = @(x,y) -200*x.^2 + 200*y

% ~latex~
% write down that hdifx = 0 and hdify = 0
% hdifx = hdify => y = x^2
% substitute and solvex