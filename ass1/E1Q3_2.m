M=10;
erms_train = ERMS(train_x, train_y, M, train_x, train_y);
erms_test = ERMS(train_x, train_y, M, test_x, test_y);

plot(0:M, erms_train, 'bo-', 0:M, erms_test, 'ro-')
legend('Training', 'Test')
ylabel('E_{RMS}')
xlabel('M')