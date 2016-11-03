E1P1Q1
mu_t = getmut(mu_p, sigma_p);
sigma_t = [2, 0.8; 0.8, 4];

n = 1000;
    
data = mvnrnd(mu_t, sigma_t, n);

save('data.txt', 'data', '-ascii');
