f = @(x) 1 + sin(6*(x-2));

train_x = linspace(0,1,10);
train_y = f(train_x) + normrnd(0,0.3,1,10);

test_x = linspace(0,1,100);
test_y = f(test_x) + normrnd(0,0.3,1,100);

fplot(f, [0 1], 'g');
hold on
plot(train_x, train_y, 'o');
ylim([-.25 2.25]);
hold off

