data_x = [0.4 0.6]
data_t = [0.05, -0.35]

a = 2
b = 10

mu_x = mean(data_x);
mu_xx = mean(data_x.*data_x);

N = length(data_x);

S_invN = a*eye(2) + N*b*[1 mu_x; mu_x mu_xx]
S_n = inv(S_invN)

mu_t = mean(data_t)
mu_xt = mean(data_x.*data_t)

m = @(x) N*b*[1 x]*S_n*[mu_t;mu_xt]
s2 = @(x) inv(b) + [1 x]*S_n*[1; x]
% sdp = @(x) (N*b*[1 x]*S_n*[mu_t;mu_xt])+(inv(b) + [1 x]*S_n*[1; x])^.5
sdp = @(x) m(x) + sqrt(s2(x));
% sdm = @(x) (N*b*[1 x]*S_n*[mu_t;mu_xt])-(inv(b) + [1 x]*S_n*[1; x])^.5
sdm = @(x) m(x) - sqrt(s2(x));

%%

hold on
fplot(m, [0 1])
fplot(sdp, [0 1], 'r')
fplot(sdm, [0 1], 'r')
plot(data_x,data_t,'o','MarkerEdgeColor','k','LineWidth',2, 'MarkerSize',10);
 
m_n = N*b*S_n*[mu_t; mu_xt];

samples = mvnrnd(m_n, S_n, 5);
w0 = samples(:,1)
w1 = samples(:,2)
y = @(x) w0' + w1'.*x

fplot(y, [0 1], ':') 
hold off

xlabel('x')
ylabel('t')
title('Predictive Gaussian Distribution with 5 sampled functions')
