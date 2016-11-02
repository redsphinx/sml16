E1P3Q1 % get mu ML
E1P3Q2 % get mu MAP
sz = 30;

figure(1)
% scatter( data(:,1), data(:,2), sz,  'cs',  'filled' )
% hold on
scatter(mu_ml(:,1), mu_ml(:,2), sz, 'gs')
hold on
scatter(mu_map(:,1), mu_map(:,2), sz, 'bs')
hold on
plot(mu_t(1), mu_t(2), 'r+', 'MarkerSize', sz-20, 'LineWidth', 2)

legend({'ML','MAP', 'true'},'FontSize',12)

xlabel('x_1')
ylabel('x_2')
