M=10;
l=0.1;
erms_train = ERMS(train_x, train_y, M, l, train_x, train_y);
erms_test = ERMS(train_x, train_y, M, l, test_x, test_y);

plot(0:M, erms_train, 'bo-', 0:M, erms_test, 'ro-')
legend('Training', 'Test')
title(['m = ' num2str(M) ', lambda = ' num2str(l)])