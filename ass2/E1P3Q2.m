clc
E1P2Q1 % create mu_p and sigma_p and mu_t and sigma_t
data = load('data.txt', '-ascii');
n = length(data)
% n=10

mu_pr = mu_p;
sigma_pr = sigma_p;

for i=1:n
    % precision matrix L
    L = inv(sigma_t - sigma_pr);
    % compute the new posterior sigma
    sigma_pos = inv(inv(sigma_pr) + L)
    % compute new posterior mu
    mu_pos = sigma_pos * (L * data(i,:)' + inv(sigma_pr) * mu_pr)
    
    sigma_pr = sigma_pos;
    mu_pr = mu_pos;

end
mu_pr
sigma_pr

mu_t
sigma_t

