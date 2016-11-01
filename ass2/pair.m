function [mu_t] = pair(mu, sigma)

rng(42)

mu_t = mvnrnd(mu', sigma');

end

