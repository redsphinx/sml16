M=10;
l=0.1;
erms_train = ERMS(train_x, train_y, M, l);
erms_test = ERMS(test_x, test_y, M, l);

plot(0:10, erms_train, 'bo-', 0:10, erms_test, 'ro-')
legend('Training', 'Test')