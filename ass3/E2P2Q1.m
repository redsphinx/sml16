clear
data = load('a010_irlsdata.txt','-ASCII');
X = data(:,1:2); C = data(:,3);

%%
% E2 P2 Q1
Red = C;
Gre = ones(length(C),1) - Red;
Blu = zeros(length(C),1);

scatter(X(:,1),X(:,2),25,[Red Gre Blu],'fill');
xlabel('x_1');
ylabel('x_2');
title('Two class data for logistic regression')
%%
% E2 P2 Q2

Ps = [ones(length(X),1), X];
w0 = [0;0;0]

sigmf = @(x) 1./(1+exp(-x))
y = @(x,w) sigmf(w(1) + (w(2).*x(:,1)) + (w(3).*x(:,2)))

% class probabilities before optimization:
y(X,w0)
%%
iters = 10;
w = w0
for i = 1:iters
    R = repmat((y(X,w).*(1-y(X,w))),1,length(X)).*eye(length(X));
    H = Ps'*R*Ps;
    d = Ps'*(y(X,w)-C);
    w = w - inv(H)*d;
end
w

%%
% E2 P2 Q3
cl = y(X,w)
mycolormap = colormap('Jet');
d64 = [0:63]/63; % 
c = interp1(d64, mycolormap,cl);

dotsize = 15;
scatter(X(:,1),X(:,2),dotsize,c,'fill');
xlabel('x_1');
ylabel('x_2');
colorbar;
title('scatterplot of data point probabilities')

%%
%eq 4
E_w = -sum(C.*log(y(X,w))+(1-C).*log(1-y(X,w)))
E_w0 = -sum(C.*log(y(X,w0))+(1-C).*log(1-y(X,w0)))

%%
% E2 P2 Q4
%covariance matrix
s = 0.2;
S = eye(2)*s;
%means of the basis functions
mu1 = [0,0];
mu2 = [1,1];
%gaussian basis functions
p1 = mvnpdf(X,mu1,S);
p2 = mvnpdf(X,mu2,S);
%plot
dotsize = 10.3;
scatter(p1,p2,dotsize,[Red Gre Blu],'fill');
xlabel('phi_1');
ylabel('phi_2');
title('scatterplot of the data in the feature domain')

%%
% E2 P2 Q5
F = [p1,p2];
FPs = [ones(length(F),1), F];

iters = 100;
wf = w0
for i = 1:iters
    R = repmat((y(F,wf).*(1-y(F,wf))),1,length(F)).*eye(length(F));
    H = FPs'*R*FPs;
    d = FPs'*(y(F,wf)-C);
    wf = wf - inv(H)*d;
end
wf

cl_f = y(F,wf)
mycolormap = colormap('Jet');
d64 = [0:63]/63; % 
c_f = interp1(d64, mycolormap,cl_f);

dotsize = 15;
scatter(X(:,1),X(:,2),dotsize,c_f,'fill');
xlabel('phi_1');
ylabel('phi_2');
colorbar;
title('scatterplot of the data after optimization')

E_wf = -sum(C.*log(y(F,wf))+(1-C).*log(1-y(F,wf)))