clf
E1P3Q1 % get mu ML
E1P3Q3 % get mu MAP
sz = 30;

m1 = mu_t(1);
m2 = mu_t(2);
lw = 2
figure(2)
x = 1:1:n;
plot(x, mu_ml(:,1), 'b', 'LineWidth', lw)
hold on
plot(x, mu_ml(:,2), 'c', 'LineWidth', lw)
hold on
plot(x, mu_map(:,1), 'r', 'LineWidth', lw)
hold on
plot(x, mu_map(:,2), 'm', 'LineWidth', lw)
hold on
plot(x, m1, '-g', 'LineWidth', lw)
hold on
plot(x, m2, '-k', 'LineWidth', lw)
legend({'ML mu1','ML mu2', 'MAP mu1', 'MAP mu2', 'true mu1', 'true mu2'},'FontSize',12)
xlabel('number of datapoints')
ylabel('mu value')

