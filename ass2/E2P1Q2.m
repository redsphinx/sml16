b = 1;
a = 125;
p = @(x)  b / (pi * ( b^2 + (x - a)^2 ))
fplot(p, [a-5 a+5])

data = [4.8, -2.7, 2.2, 1.1, 0.8, -7.3]
