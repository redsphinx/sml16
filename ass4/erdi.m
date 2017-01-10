N = 2.0;values = -N:0.1:N;[x1, x2]=meshgrid(values,values);mu = zeros(1, 2);sigma = eye(2) * 2 / 5;X = [x1(:) x2(:)];Y = mvnpdf(X, mu, sigma) * 3;
D=2; % number of input nodes
K=1; % number of output nodes
M=8; % number of hidden nodes
w1 = rand(D,M) - 0.5; % weights of first layer
w2 = rand(M,K) - 0.5; %weights of second layer
b1 = rand(1,M) - 0.5; % biases for first layer
b2 = rand(K,1) - 0.5; %biases for second layer
h = @(a)tanh(a); % activation function
dh = @(a)(1 - h(a).^2); % derivative of activation function
n = 0.1; % n, learning rate
a1 = X * w1 + repmat(b1, length(X),1); % values for activation function
z = h(a1); % values of nodes
y = z * w2 + b2; % output values

number_of_epochs = 500;
interval = 50;
number_of_plots = number_of_epochs / interval;
plot_counter = 0;

for count = 1:500
    for i = 1:length(X)
        ti = Y(i); % real output
        xi = X(i, :); % inputs with index i
        a1 = xi * w1 + b1; % values for hidden nodes, to be activated
        zi = h(a1); % activations of hidden nodes
        yi = zi * w2 + b2; % output for input i
        d2 = yi - ti; % difference in layer 2
        d1 = dh(a1)' .* (w2 * d2); % difference in layer 1
        w1 = w1 - n * (d1*xi)'; % new weight assignments
        w2 = w2 - n * (d2*zi)';
    end
    % plot the outputs for new weights and wait for user input
    a1s = X * w1 + repmat(b1, length(X),1);
    zs = h(a1s);
    ys = zs * w2 + b2;
    
    if(mod(count,interval) == 0)
        plot_counter = plot_counter + 1;
        subplot(2,number_of_plots/2,plot_counter)
        surf(values, values, reshape(ys, length(values), length(values)))
        axis square
        title(sprintf('epoch: %d',count))
    end
    
%     surf(values, values, reshape(ys, length(values), length(values)))
%     pause
%     count
end