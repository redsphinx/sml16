m = 9;
x = train_x;
y = train_y;
mcon = 0:m;

% getting weights
w = E1Q2PolCurFit(x, y, m);

% function f
f = @(x) 1+sin(6*(x-2));

% approximation with weights
z = @(x,w,m) sum((x.^m).*w');
fun = @(x) z(x,w,mcon);

fplot(f, [0, 1], 'g')
hold on
fplot(fun, [0, 1], 'r')
hold on
plot(x,y,'o')

legend('function f', 'polynomial', 'observations', 'Location', 'southwest')
title(['M = ' num2str(m) ])
