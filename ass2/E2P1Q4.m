clear
clc
x = [4.8, -2.7, 2.2, 1.1, 0.8, -7.3];
b = 1;

% a = linspace(-5,5);
a = [-5:0.1:5];
pos = zeros(length(a),1);
for j = 1:length(a)
    p = 1;
    for i = 1:length(x)
        p =  p * (b / (pi * ( b^2 + (x(i) - a(j))^2 )));
    end
    pos(j) = p;
end
plot(a, pos)

xlabel('alpha')
ylabel('p(alpha|D, beta=1)')

mean(x)