f = @(x) 1 + sin(6*(x-2));
other_x = linspace(0,1,40);
other_y = f(other_x) + normrnd(0,0.3,1,40);

M=10;
erms_train = ERMS(train_x, train_y, M, train_x, train_y);
erms_test = ERMS(train_x, train_y, M, test_x, test_y);
erms_other = ERMS(train_x, train_y, M, other_x, other_y);

xax = 0:M;
plot(xax, erms_train, 'bo-', xax, erms_test, 'ro-', xax, erms_other, 'go-')
legend('Training', 'Test', 'D_{40}')