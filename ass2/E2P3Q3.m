E2P2Q2 % generate data

xs = zeros(length(data),2);
for i = 1:length(data)
    negloglik = @(x) -(i*log(x(2)) - i*log(pi) - sum(log(x(2)^2 + (data(1:i)-x(1)).^2)));
    xs(i,:) = fminsearch(negloglik,[0,1]);
end

figure(1)
x = 1:length(data);
plot(x,xs(:,1),'r')
hold on
plot(x,a,'r-')
hold on
plot(x,xs(:,2),'b')
hold on
plot(x,b,'b-')
legend({'\alpha estimate', '\alpha', '\beta estimate', '\beta'})
title('Estimates of \alpha and \beta');
xlabel('Number of data-points');
ylabel('\alpha, \beta');
