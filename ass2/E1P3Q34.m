clf
E1P3Q1 % get mu ML
E1P3Q2 % get mu MAP
sz = 30;

% figure(1)
% % scatter( data(:,1), data(:,2), sz,  'cs',  'filled' )
% % hold on
% scatter(mu_ml(:,1), mu_ml(:,2), sz, 'gs')
% hold on
% scatter(mu_map(:,1), mu_map(:,2), sz, 'bs')
% hold on
% plot(mu_t(1), mu_t(2), 'r+', 'MarkerSize', sz-20, 'LineWidth', 2)
% legend({'ML','MAP', 'true'},'FontSize',12)
% xlabel('x_1')
% ylabel('x_2')

m1 = mu_t(1);
m2 = mu_t(2);
lw = 2
figure(1)
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

