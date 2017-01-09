% implement neural net
% input x = [x1, x2, bias]
% output y
% training data X, add bias don't forget
b1 = 1;
x_tmp = [1, 1, b1];
t_tmp = 0;

% input nodes
D = 2;
% hidden nodes
M = 3;
% weights
W1 = rand(D + 1, M) - 0.5;
W2 = rand(M + 1, 1) - 0.5;
% learning rate
eta = 0.1;
% bias implied
z = tanh(x_tmp * W1);
b2 = 1;
z = [z b2];
y = z * W2;
%%
% backpropagation
delta_k = y - t_tmp;
delta_j = (1 - z.^2) .* W2' * delta_k; % 1x4 * 4x1 * 1x1 -> 1x4
delta_j = delta_j(1:M);
% (1 - z^2): da/dW1
dEdW1 = delta_j' * x_tmp;
dEdW2 = delta_k * z';

W1 = W1 - eta * dEdW1;
W2 = W2 - eta * dEdW2;

