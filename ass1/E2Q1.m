h = @(x,y) 100*(y-x.^2).^2 + (1-x).^2;

x = linspace(-2,2);
y = linspace(-1,3);

[X,Y] = meshgrid(x,y)
surf(X, Y, h(X,Y))

xlabel('x')
ylabel('y')
zlabel('z')
