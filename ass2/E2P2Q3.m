E2P2Q2 % generate data

n = length(data);

m_all = zeros(1,n);

mu = 0;
for i=1:n
    mu = mu + 1/i * (data(i) - mu);
    m_all(i) = mu;
end

plot(1:1:n, m_all)
hold on
plot(1:n, a, 'r')

xlabel('N datapoints')
ylabel('mean of data')