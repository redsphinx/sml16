clc
E1P2Q1 % create mu_p and sigma_p and mu_t and sigma_t
data = load('data.txt', '-ascii');
n = length(data)

mu_pr = mu_p;
sigma_pr = sigma_p;
% precision matrix L
L = inv(sigma_t);
mu_map = [];

for i=1:n
    % compute the new posterior sigma -> bishop eq.2.117
    sigma_pos = inv(inv(sigma_pr) + L);
    % compute new posterior mu -> bishop eq.2.116
    mu_pos = sigma_pos * (L * data(i,:)' + inv(sigma_pr) * mu_pr);
    
    sigma_pr = sigma_pos;
    mu_pr = mu_pos;
    
    mu_map = [mu_map; mu_pr'];
end


