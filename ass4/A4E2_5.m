% A4E2_5 
clc 
clear
data = load('a017_NNpdfGaussMix.txt', '-ASCII');
X = data(:,1:2); Y = data(:,3);
num = sqrt(length(X(:,1)));
x1 = -2:0.1:2;
x2 = x1;
[X1, X2] = meshgrid(x1, x2);
% X1 = reshape(X(:,1), num, num);
% X2 = reshape(X(:,2), num, num);
surf(X1, X2, reshape(Y, num, num))
r = randperm(length(X));
X = X(r, :);
Y = Y(r);
%%
% A4E2_6 
% implement neural net
D = 2; % input nodes
M = 40; % hidden nodes
% weights, with bias implied (in the +1)
W1 = rand(D + 1, M) - 0.5;
W2 = rand(M + 1, 1) - 0.5;
% learning rate
eta = 0.01;

Yhat = zeros(length(X),1);
for i = 1:length(X)
    x = [X(i,:) 1];
    z = [tanh(x * W1) 1];
    y = z * W2;
    Yhat(i) = y;
end
% figure;
% surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
% title(sprintf('epoch 0'))

% A4E2_3
number_of_epochs = 2000;
interval = 20;
number_of_plots = number_of_epochs / interval;
plot_counter = 0;

%to plot the initial approximation with random weights
% subplot(2,number_of_plots/2,1)
% surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
% axis square
% title(sprintf('initial'))
Yhat = zeros(length(X),1);

for epoch = 1:number_of_epochs
    epoch
    for i = 1:length(X)
        x = [X(i,:) 1];
        z = [tanh(x * W1) 1];
        y = z * W2;
        Yhat(i) = y;
        % backpropagation
        delta_k = y - Y(i);
        delta_j = (1 - z.^2) .* (W2' * delta_k); % (1x(M+1))
        delta_j = delta_j(1:M); %remove the last "bias" item
        % (1 - z^2): da/dW1
        dEdW1 = delta_j' * x;
        dEdW2 = delta_k * z';

        W1 = W1 - eta * dEdW1';
        W2 = W2 - eta * dEdW2;
    end
    if(mod(epoch,interval) == 0)
        plot_counter = plot_counter + 1;
%         sprintf('plot')
%         figure;
%         surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
%         title(sprintf('epoch: %d',epoch))

        subplot(10,number_of_plots/10,plot_counter)
        surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
        axis square
        title(sprintf('epoch: %d',epoch))
    end
end
