A4E2_1
% implement neural net
% input x = [x1, x2, bias]
% output y
% training data X, add bias don't forget

% input nodes
D = 2;
% hidden nodes
M = 8;
% weights, with bias implied (in the +1)
W1 = rand(D + 1, M) - 0.5;
W2 = rand(M + 1, 1) - 0.5;
% learning rate
eta = 0.1;

Yhat = zeros(length(X),1);
for i = 1:length(X)
    x_tmp = [X(i,:) 1];
    z = [tanh(x_tmp * W1) 1];
    y = z * W2;
    Yhat(i) = y;
end
figure;
surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
title(sprintf('epoch 0'))
%%
for epoch = 1:200
    epoch
    Yhat = zeros(length(X),1);
    for i = 1:length(X)
        x_tmp = [X(i,:) 1];
        z = [tanh(x_tmp * W1) 1];
        y = z * W2;
        Yhat(i) = y;
        % backpropagation
        delta_k = y - Y(i);
        delta_j = (1 - z.^2) .* W2' * delta_k; % 1x4 * 4x1 * 1x1 -> 1x4
        delta_j = delta_j(1:M);
        % (1 - z^2): da/dW1
        dEdW1 = delta_j' * x_tmp;
        dEdW2 = delta_k * z';

        W1 = W1 - eta * dEdW1';
        W2 = W2 - eta * dEdW2;
    end
    if(mod(epoch,20) == 0)
        sprintf('plot')
        figure;
        surf(X1, X2, reshape(Yhat, length(x1), length(x2)))
        title(sprintf('epoch: %d',epoch))
    end
end