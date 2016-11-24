% E2P1Q2
clear

ts = [1,0,1,0];
ps = [0.3,0.44,0.46,0.6];
Ps = [ones(1,length(ps)); ps]';

w0 = [1.0;1.0]

sigmf = @(x) 1./(1+exp(-x))
y = @(x,w) sigmf(w(1) + (w(2).*x))

iters = 10;
w = w0;
for i = 1:iters
    R = repmat((y(ps,w).*(1-y(ps,w)))',1,length(ps)).*eye(length(ps));
    H = Ps'*R*Ps;
    d = Ps'*(y(ps,w)-ts)';
    w = w - inv(H)*d;
end

y(0.45,w)
