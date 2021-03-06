%A4E3_1
X = load('a011_mixdata.txt', '-ASCII');
%%

%%
subplot(2,2,1)
scatter3(X(:,1), X(:,2), X(:,3))
xlabel('x1')
ylabel('x2')
zlabel('x3')
axis square

subplot(2,2,2)
scatter3(X(:,2), X(:,3), X(:,4))
xlabel('x2')
ylabel('x3')
zlabel('x4')
axis square

subplot(2,2,3)
scatter3(X(:,3), X(:,4),X(:,1))
xlabel('x3')
ylabel('x4')
zlabel('x1')
axis square

subplot(2,2,4)
scatter3(X(:,1), X(:,2), X(:,4))
xlabel('x1')
ylabel('x2')
zlabel('x4')
axis square
%%
%A4E3_2
clc
clearvars -except X
N = length(X); % number of samples
K = 2; % number of classes
PI = 1/K * ones(1,K); % a priori equal mixing coefficiens
% Initialize the means ??k to random values around the sample mean of each variable
MU = zeros(K, 4);
SIGMA = repmat(eye(4),1,1,K);
for j=1:K
    MU(j, :) = [mean(X(:,1)) + rand, mean(X(:,2)) + rand, mean(X(:,3)) + rand, mean(X(:,4)) + rand];
    SIGMA(:, :, j) = eye(4).*(4*rand(4)+2);
end

% 1. evaluate the initial value of the log likelihood - Bishop eq(9.28)
likelihood = 0;
for j=1:K
    likelihood_i = PI(j) * mvnpdf(X, MU(j,:), SIGMA(:, :, j));
    likelihood = likelihood + likelihood_i;
end
total_log_likelihood = sum(log(likelihood));

total_log_likelihood


%%
iterations = 100;
store_log_likelihoods = zeros(1, iterations);
GAMMA = zeros(N, K); % responsibilities

for step=1:iterations
    step
    % 2. Evaluate the responsibilities using the current parameter values -
    % Bishop eq(9.23)
    
    for j=1:K
        p_x = PI(j)*mvnpdf(X, MU(j, :), SIGMA(:, :, j));% top in 9.23
        total_p_x = 0;
%         bot in 9.23
        for l=1:K
            p_x_tmp = PI(l)*mvnpdf(X, MU(l, :), SIGMA(:, :, l));
            total_p_x = total_p_x + p_x_tmp;
        end
        GAMMA(:,j) = p_x ./ total_p_x;
    end

    % 3. Re-estimate the parameters using current responsibilities
    % Bishop eqs(9.24 - 9.27)
    for j=1:K
        N_k = sum(GAMMA(:,j));
        mu_new =  GAMMA(:,j)'*X;
        MU(j,:) = 1/N_k.* mu_new;
        sigma_new_all = zeros(4, 4);
        for i=1:N
            sigma_new = GAMMA(i,j).*( (X(i,:)-MU(j, :))' * (X(i,:)-MU(j, :)) ) ;
            sigma_new_all = sigma_new_all + sigma_new;
        end
        SIGMA(:, :, j) = 1/N_k * sigma_new_all;
        PI(j) = N_k/N;
    end
 
    % 4. Evaluate log likelihood
    likelihood = 0;
    for j=1:K
        likelihood_i = PI(j) * mvnpdf(X, MU(j,:), SIGMA(:, :, j));
        likelihood = likelihood + likelihood_i;
    end
    total_log_likelihood = sum(log(likelihood));

%     total_log_likelihood
    store_log_likelihoods(step) = total_log_likelihood;
end

plot(store_log_likelihoods)
%%
probability = zeros(N, 1);
classes = zeros(N, 1);

for i = 1:K
    predictions = mvnpdf(X, MU(i,:), SIGMA(:,:,i));
    classes(predictions > probability) = i;
    probability(predictions > probability) = predictions(predictions > probability);
end
color = 'rgbkcym';

hold on
for i = 1:K
    matches = X(classes == i, :);
    plot(matches(:, 3), matches(:,2), [color(i) 'o'])
    axis square
end
xlabel('x1')
ylabel('x2')
title('Class Probability of x1 and x2')
legend('class 1', 'class 2')
hold off
%%
X1 = [];
X2 = [];

for i=1:N
   if GAMMA(i, 1) >  GAMMA(i, 2)
       X1 = [X1; X(i, :)];
   else
       X2 = [X2; X(i, :)];
   end
end
rho_1 = SIGMA(1:2, 3:4, 1) ./ sqrt( var(X1(:,1)) * var(X1(:,2)));
rho_2 = SIGMA(1:2, 3:4, 2) ./ sqrt( var(X2(:,1)) * var(X2(:,2)));
%%
