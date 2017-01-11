clc
clear
X = load('a011_mixdata.txt', '-ASCII');
scatter3(X(:,1), X(:,2), X(:,3));
%%
figure
scatter(X(:,1),X(:,2))
title('1 and 2')
figure
scatter(X(:,2),X(:,3))
title('2 and 3')
figure
scatter(X(:,3),X(:,4))
title('3 and 1')

%%
K = 2 % num classes