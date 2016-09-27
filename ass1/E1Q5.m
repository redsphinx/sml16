M=10;
l=0;
erms_train = ERMS(train_x, train_y, M, l);
erms_test = ERMS(test_x, test_y, M, l);

plot(0:M, erms_train, 'bo-', 0:M, erms_test, 'ro-')
legend('Training', 'Test')
title(['m = ' num2str(M) ', lambda = ' num2str(l)])