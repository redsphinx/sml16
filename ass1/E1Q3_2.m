M=10;
erms_train = ERMS(train_x, train_y, M);
erms_test = ERMS(test_x, test_y, M);

plot(0:10, evec_train, 'bo-', 0:10, evec_test, 'ro-')
legend('Training', 'Test')
