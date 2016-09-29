f = @(x) 1 + sin(6*(x-2));
other_x = linspace(0,1,40);
other_y = f(other_x) + normrnd(0,0.3,1,40);

M=10;
% erms_train = ERMS(train_x, train_y, M, train_x, train_y);
erms_other = ERMS(other_x, other_y, M, other_x, other_y);
erms_test = ERMS(other_x, other_y, M, test_x, test_y);

xax = 0:M;
plot(xax, erms_other, 'bo-', xax, erms_test, 'ro-')
legend('Training', 'Test-40')
ylabel('E_{RMS}')
xlabel('M')