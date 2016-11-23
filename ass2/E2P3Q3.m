E2P2Q2 % generate data, alpha, beta

xs = zeros(length(data),2);
for i = 1:length(data)
    negloglik = @(x) -(i*log(x(2)) - i*log(pi) - sum(log(x(2)^2 + (data(1:i)-x(1)).^2)));
    xs(i,:) = fminsearch(negloglik,[0,1]);
end

a = a*ones(1,length(data));
b = b*ones(1,length(data));
figure(1)
x = 1:length(data);
plot(x,xs(:,1),'r')
hold on
plot(x,a,'--m')
hold on
plot(x,xs(:,2),'b')
hold on
plot(x,b,'--c')
legend({'alpha estimate', 'true alpha', 'beta estimate', 'true beta'})
title('Estimates of alpha and beta');
xlabel('Number of data points');
ylabel('alpha, beta');
