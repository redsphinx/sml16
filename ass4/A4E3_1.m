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
clc
clearvars -except X
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
% 2. Evaluate the responsibilities using the current parameter values -
% Bishop eq(9.23)
GAMMA = zeros(N, K); % responsibilities
for i=1:N
    for j=1:K
        p_x_i = PI(j)*mvnpdf(X(i,:), MU(j), SIGMA(:, (j-1)*4+1:j*4));% top in 9.23
        total_p_x = 0;
        % bot in 9.23
        for l=1:K
            p_x = PI(l)*mvnpdf(X(i,:), MU(l), SIGMA(:, (l-1)*4+1:l*4));
            total_p_x = total_p_x + p_x;
        end
        GAMMA(i,j) = p_x_i / total_p_x;
    end
end
%%
% 3. Re-estimate the parameters using current responsibilities
% Bishop eqs(9.24 - 9.27)
for j=1:K
	N_k = sum(GAMMA(:,j));
    for i=1:N
        mu_new_all =  sum(GAMMA(i,j).*X(i,:));
    end
    MU(j) = 1/N_k * mu_new_all;
    for i=1:N
       sigma_new_all = sum(GAMMA(i,j).*( (X(i,:)-MU(j)) * (X(i,:)-MU(j))' ) );
    end
    SIGMA(:, (j-1)*4+1:j*4) = 1/N_k * sigma_new_all;
    PI(j) = N_k/N;
end
%%
% 4. Evaluate log likelihood
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