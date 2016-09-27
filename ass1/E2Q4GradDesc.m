function E2Q4GradDesc(eta, steps)
    %contourplot h    
    h = @(x,y) 100*(y-x.^2).^2 + (1-x).^2;
    x = linspace(-2,2);
    y = linspace(-1,3);

    [X,Y] = meshgrid(x,y);
    Z = h(X,Y);    
    contour(X, Y, Z)
    hold on
    
    %gradient descent
    cn = 0;
    x1 = 4*rand()-2
    y1 = 4*rand()-1
    xmat = 0;
    ymat = 0;
    while cn < steps
        xn = x1 - eta*(-400*x1*y1 + 400*x1^3 + 2*x1 -2);
        yn = y1 - eta*(200*y1 - 200*x1^2);
        x1 = xn;
        y1 = yn;
        xmat = [xmat x1];
        ymat = [ymat y1];
        cn = cn + 1;
    end
    
    xmat = xmat(2:length(xmat));
    ymat = ymat(2:length(ymat));
    
    plot(xmat,ymat,'k-o');
end
