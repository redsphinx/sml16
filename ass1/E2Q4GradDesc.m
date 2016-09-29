function E2Q4GradDesc(eta, steps)
%     xmin = -2; xmax = 2; ymin = -1; ymax = 3;
    xmin = -4; xmax = 4; ymin = -2; ymax = 5;


    %contourplot h    
    h = @(x,y) 100*(y-x.^2).^2 + (1-x).^2;
    x = linspace(xmin,xmax);
    y = linspace(ymin,ymax);

    [X,Y] = meshgrid(x,y);
    Z = h(X,Y);    
    contour(X, Y, Z)
    hold on
    
    %gradient descent
    cn = 0;
%     x1 = (xmax-xmin)*rand()+xmin
%     y1 = (ymax-ymin)*rand()+ymin
    x1 = 0
    y1 = 0
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
    xmat(end)
    ymat(end)
end
