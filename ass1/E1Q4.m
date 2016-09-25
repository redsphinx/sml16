f = @(x) 1 + sin(6*(x-2));
other_x = linspace(0,1,40);
other_y = f(other_x) + normrnd(0,0.3,1,40);

M=10;
erms_train = ERMS(train_x, train_y, M);
erms_test = ERMS(test_x, test_y, M);
erms_other = ERMS(other_x, other_y, M);

xax = 0:M;
plot(xax, erms_train, 'bo-', xax, erms_test, 'ro-', xax, erms_other, 'go-')
legend('Training', 'Test', 'D_{40}')