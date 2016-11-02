clc
E1P2Q1

data = load('data.txt', '-ascii');

mu_t = load('mu_t', '-ascii');

n = length(data)

mu_ml = mean(data);

s = zeros(2);

for i=1:n
    d = (data(i,:)' - mu_ml') * (data(i,:)' - mu_ml')';
    s = s + d;
end

sigma_ml = s / n

sigma_ub = s / (n-1)