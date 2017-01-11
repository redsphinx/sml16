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
SIGMA = repmat(eye(4),1,1,K);
for j=1:K
    MU(j, :) = [mean(X(:,1)) + rand, mean(X(:,2)) + rand, mean(X(:,3)) + rand, mean(X(:,4)) + rand];
    SIGMA(:, :, j) = eye(4).*(4*rand(4)+2);
end

% 1. evaluate the initial value of the log likelihood - Bishop eq(9.28)
total_log_likelihood = 0;
for i=1:N
    likelihood = 0;
    for j=1:K
        likelihood_i = PI(j) * mvnpdf(X(i,:), MU(j,:), SIGMA(:, :, j));
        likelihood = likelihood + likelihood_i;
    end
    total_log_likelihood = total_log_likelihood + log(likelihood);
end
total_log_likelihood


%%
iterations = 50;
store_log_likelihoods = zeros(1, iterations);
GAMMA = zeros(N, K); % responsibilities

for step=1:iterations
    step
    % 2. Evaluate the responsibilities using the current parameter values -
    % Bishop eq(9.23)
    
    for j=1:K
        p_x = PI(j)*mvnpdf(X, MU(j, :), SIGMA(:, :, j));% top in 9.23
        total_p_x = 0;
        % bot in 9.23
        for l=1:K
            p_x = PI(l)*mvnpdf(X, MU(l, :), SIGMA(:, :, l));
            total_p_x = total_p_x + p_x;
        end
        GAMMA(:,j) = p_x ./ total_p_x;
    end

    % 3. Re-estimate the parameters using current responsibilities
    % Bishop eqs(9.24 - 9.27)
    for j=1:K
        j
        N_k = sum(GAMMA(:,j));
        mu_new =  GAMMA(:,j)'*X;
        MU(j,:) = 1/N_k.* mu_new;
        sigma_new_all = zeros(4, 4);
        for i=1:N
            sigma_new = GAMMA(i,j).*( (X(i,:)-MU(j, :))' * (X(i,:)-MU(j, :)) ) ;
            sigma_new_all = sigma_new_all + sigma_new;
        end
        SIGMA(:, :, j) = 1/N_k * sigma_new;
        PI(j) = N_k/N;
    end
 
    % 4. Evaluate log likelihood
    total_log_likelihood = 0;
    for i=1:N
        likelihood = 0;
        for j=1:K
            likelihood_i = PI(j) * mvnpdf(X(i,:), MU(j,:), SIGMA(:, :, j));
            likelihood = likelihood + likelihood_i;
        end
        total_log_likelihood = total_log_likelihood + log(likelihood);
    end
%     total_log_likelihood
    store_log_likelihoods(step) = total_log_likelihood;
end

plot(store_log_likelihoods)