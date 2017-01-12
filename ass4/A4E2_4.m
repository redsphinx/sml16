% A4E2_2 
A4E2_1 % execute script to make data X and Y

% implement neural net
D = 2; % input nodes
M = 8; % hidden nodes
% weights, with bias implied (in the +1)

range_w = 0.5;
a = -range_w;
b = range_w;
W1 = (b-a).*rand(D + 1, M) + a;
W2 = (b-a).*rand(M + 1, 1) + a;
% W1 = rand(D + 1, M) - range_w;
% W2 = rand(M + 1, 1) - range_w;
% learning rate
eta = 0.60;

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
number_of_epochs = 100;
interval = 10;
number_of_plots = number_of_epochs / interval;
plot_counter = 0;

%to plot the initial approximation with random weights
% subplot(2,number_of_plots/2,1)
% surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
% axis square
% title(sprintf('initial'))
tic
for epoch = 1:number_of_epochs
    sequence = randperm(length(X));
    epoch
    Yhat = zeros(length(X),1);
    for k = 1:length(X)
        i = sequence(k);
        x = [X(i,:) 1];
        z = [tanh(x * W1) 1];
        y = z * W2;
        Yhat(i) = y;
        % backpropagation
        delta_k = y - Y(i);
        delta_j = (1 - z.^2) .* W2' * delta_k; % 1x4 * 4x1 * 1x1 -> 1x4
        delta_j = delta_j(1:M);
        % (1 - z^2): da/dW1
        dEdW1 = delta_j' * x;
        dEdW2 = delta_k * z';

        W1 = W1 - eta * dEdW1';
        W2 = W2 - eta * dEdW2;
    end
%     if(mod(epoch,interval) == 0)
%         plot_counter = plot_counter + 1;
% 
%         subplot(2,number_of_plots/2,plot_counter)
%         surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
%         axis square
%         title(sprintf('epoch: %d',epoch))
%     end
end
toc
surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
axis square
title([' M: ' num2str(M) ' eta: ' num2str(eta) ' W: ' num2str(range_w)])
