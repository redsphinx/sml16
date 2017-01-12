% loading data
clc
clear
N = 800; 
D = 28*28; 
X = uint8(zeros(N,D));
fid = fopen ('a012_images.dat', 'r');
for i = 1:N
    X(i,:) = fread(fid, [D], 'uint8');
end;
status = fclose(fid);
%%
% A4E4_1
number_of_images = 5;
for i=1:number_of_images
    subplot(1,number_of_images,i)
    imagesc(reshape(X(i,:), 28, 28))
%     BW_map=[1,1,1; 0,0,0]; colormap(BW_map);
    axis square
end
%%
% A4E_2
clc
clearvars -except X N D
N = length(X); % number of samples
K = 3; % number of classes, 3
PI = 1/K * ones(1,K); % a priori equal mixing coefficiens
% Initialize the means μk to random values around the sample mean of each variable
MU = 0.5.*rand(K, D) + 0.25;

% 1. evaluate the initial value of the log likelihood - Bishop eq(9.28)
likelihood = 0;
p_x_mu = [];
for j=1:K

    p_x_mu = p_x_mu * binopdf(X, 1, MU(j,i));

	likelihood_i = PI(j) * p_x_mu;
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