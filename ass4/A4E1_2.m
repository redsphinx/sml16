%E1.1-1.5

thetas = [1,1,1,1;
    1,4,0,0;
    9,4,0,0;
    1,64,0,0;
    1,0.25,0,0;
    1,4,10,0;
    1,4,0,5];
N = linspace(-1,1,101);

n = length(N);
K = zeros(n,n);

for params = 1:7
    th = thetas(params,:);

    for i = 1:n
        for j = 1:n
            K(i,j) = kkernel(th,N(i),N(j));
        end
    end
    
% E1.3
% The dimensions are 101x101
% We can show it is positive semidefinite by showing that all of the
% eigenvalues are >0.

% E1.4
% we might want a title etc.
    Y = mvnrnd(zeros(1,101),K,5);
    plot(N,Y);
    ylim([-10,10]);
%     title(th);
    saveas(gcf, sprintf('E1_4_gpPrior_params%d.png',params));   
end

%%
 
D = [-0.5, 0.5; 0.2, -1; 0.3, 3; -0.1, -2.5];
th = [1,1,1,1];

d = length(D);
Kd = zeros(d,d);

for i = 1:d
    for j = 1:d
        Kd(i,j) = kkernel(th,D(i,1),D(j,1));
    end
end

C = Kd + eye(d);

%%
k = zeros(d,1);
for i = 1:d
    k(i,1) = kkernel(th,D(i,1),0);
end
c = kkernel(th,0,0)+1

mean_N1 = k'*inv(C)*D(:,2);
sigma_N1 = c-k'*inv(C)*k;

%%
% By setting th2 and th3 to 0, the mean of the conditional distribution
% p(t|t) goes to 0. As x approaches +/- infinity, the exponential term
% converges to 0, cancelling out th0 and th1. Only th2 and th3 remain
% positive and make the kernel output non-negative.

