b = 1;
a = 125;
p = @(x)  b / (pi * ( b^2 + (x - a)^2 ))
fplot(p, [a-5 a+5])

