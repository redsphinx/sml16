%A4E3_1
X = load('a011_mixdata.txt', '-ASCII');
%%
subplot(2,2,1)
scatter(X(:,1), X(:,2))
xlabel('x1')
ylabel('x2')
axis square

subplot(2,2,2)
scatter(X(:,2), X(:,3))
xlabel('x2')
ylabel('x3')
axis square

subplot(2,2,3)
scatter(X(:,3), X(:,4))
xlabel('x3')
ylabel('x4')
axis square

subplot(2,2,4)
scatter(X(:,1), X(:,4))
xlabel('x1')
ylabel('x4')
axis square
%%
%A4E3_2
N = length(X); % number of samples
K = 2; % number of classes
PI = 1/K * ones(1,K); % a priori equal mixing coefficiens
% Initialize the means μk to random values around the sample mean of each variable
MU = zeros(K, 4);
for i=1:K
    MU(i, :) = [mean(X(:,1)) + rand, mean(X(:,2)) + rand, mean(X(:,3)) + rand, mean(X(:,4)) + rand];
end
SIGMA = repmat(eye(4),1,K);
for j=1:K
    sigma_tmp = eye(4);
    for i=1:4
       sigma_tmp(i,:) = sigma_tmp(i,:).*(4*rand()+2);
    end
    SIGMA(:, (j-1)*4+1:j*4) = sigma_tmp;
end
iterations = 100;

%%
% 1. evaluate the initial value of the log likelihood - Bishop eq(9.28)
total_log_likelihood = 0;
for i=1:N
    likelihood = 0;
    for j=1:K
        likelihood_i = PI(j) * mvnpdf(X(i,:), MU(j,:), SIGMA(:, (j-1)*4+1:j*4));
        likelihood = likelihood + likelihood_i;
    end
    total_log_likelihood = total_log_likelihood + log(likelihood);
end
total_log_likelihood
%%
% 2. Evaluate the responsibilities using the current parameter values
