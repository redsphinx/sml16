l1 = 1/exp(40);
l2 = 1/exp(0);

erms_train = ERMS2(train_x, train_y, l1, l2, train_x, train_y);
erms_test = ERMS2(train_x, train_y, l1, l2, test_x, test_y);

plot(log(l1):log(l2), erms_train, 'bo-', log(l1):log(l2), erms_test, 'ro-')
legend('Training', 'Test')
title('M = 9 ')

ylabel('E_{RMS}')
xlabel('ln lambda')