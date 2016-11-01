E1P1Q1  % script sets mu_p and sigma_p
mu_t = pair(mu_p, sigma_p)

x1 = -3:.05:3; 
x2 = -3:.05:3;

[X1,X2] = meshgrid(x1,x2);

y = mvnpdf([X1(:) X2(:)], mu_t, sigma_p);
y = reshape(y,length(x2),length(x1));
surf(x1,x2,y);
caxis([min(y(:))-.5*range(y(:)),max(y(:))]);

xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

