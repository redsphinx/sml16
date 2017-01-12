clear
clc
close all
rng(111)
%% import data
N = 800; D = 28*28; X = uint8(zeros(N,D));
fid = fopen ('a012_images.dat', 'r');
for i = 1:N
    X(i,:) = fread(fid, [D], 'uint8');
end;
status = fclose(fid);
%% set initial values
n = size(X,1);
k = 3;
vars = size(X, 2); % number of variables
pik = ones(1,k)/k; % mixing coeff
its = 40; % iterations
gamma = zeros(n,k);  % responsibilities
top = ones(n,k); % top part of fractal calculating gamma, responsibilities, represents individual values of p(x|mu)
log_likelihood = zeros(its,1);
muk = (0.5 .* rand(k, vars) + 0.25);
%% calculate mk using em
for j = 1:its
    for c = 1:vars 
        % calculate pixelwise class probabilities of each data, 
        % multiply them with previous class probabilities and normalise in each step
        top = normc((top .* binopdf(repmat(X(:,c), 1, k), 1, repmat(muk(:,c)', n, 1)))')';
    end
    top = top .* repmat(pik, n, 1); % multiply class probabilities with pik
    bot = sum(top, 2);
    gamma = diag(bot)\top; % responsibilities
    % calculate new values for next iteration
    Nk = sum(gamma);
    muk_new = repmat(Nk, vars, 1)' .\ (gamma' * double(X)); 

    pik_new = Nk / n;
    topk_new = zeros(n,k);
    for c = 1:vars
        topk_new(:,:) = normc((topk_new(:,:) .* binopdf(repmat(X(:,c), 1, k), 1, repmat(muk_new(:,c)', n, 1)))')';
    end
    topk_new = topk_new .* repmat(pik_new, n, 1); 

    log_likelihood(j) = sum(log(pik_new * topk_new'));
    top = topk_new;
    pik = pik_new;
    muk = muk_new;
    len = sqrt(size(X,2));
%     for i= 1:k
%         subplot(1,k,i)
%         image(reshape(muk(i,:), len, len)*255)
%         colormap(gray(255));
%     end
%     pause
end
%% plot loglikelihood
figure(1)
plot(log_likelihood)

%% plot class prototypes, muk
figure(1)
for i= 1:k
    subplot(1,k,i)
    image(reshape(muk(i,:), len, len)*255)
    colormap(gray(255));
end
%% load label data
fid = fopen ('a012_labels.dat', 'r');
Z = fread(fid, N, 'uint8');

%% select predictions
high_probs = zeros(n, 1);
predictions = ones(n, k);
classes = ones(n, 1);
for c = 1:vars
    predictions = normc((predictions .* binopdf(repmat(X(:,c), 1, k), 1, repmat(muk(:,c)', n, 1)))')';
end

% labeled_predictions = (predictions > 0.9) * [3; 4];
labeled_predictions = (predictions > 0.9) * [2; 3; 4];
% labeled_predictions = (predictions > 0.9) * [2; 3; 4; 3];
sum(labeled_predictions ~= Z)

%% show some misclassified images.

misclassified = X((labeled_predictions ~= Z), :);
misclassified_labels = labeled_predictions((labeled_predictions ~= Z), :);
thing= 10;
figure(2)
for i= 1:thing
    subplot(1,thing,i)
    image(reshape(misclassified(i,:), len, len)*255)
    colormap(gray(255));
end

%% create prototypes with true values
real = zeros(3,vars);
real(1,:) = mean(X(Z==2, :));
real(2,:) = mean(X(Z==3, :));
real(3,:) = mean(X(Z==4, :));
%% make predictions again
r_high_probs = zeros(n, 1);
r_predictions = ones(n, k);
r_classes = ones(n, 1);
for c = 1:vars
    r_predictions = normc((r_predictions .* binopdf(repmat(X(:,c), 1, k), 1, repmat(real(:, c)', n, 1)))')';
end

% labeled_predictions = (predictions > 0.9) * [3; 4];
r_labeled_predictions = (r_predictions > 0.9) * [2; 3; 4];
% labeled_predictions = (predictions > 0.9) * [2; 3; 4; 3];
sum(r_labeled_predictions == Z)

%% load hand_drawn data
hand_drawn_data = imread('4.jpg');
hand_drawn = uint8(reshape(hand_drawn_data,1,28*28) > 250);
hand_drawn_prediction = ones(1,k);
for c = 1:vars
    hand_drawn_prediction = normc((hand_drawn_prediction .* binopdf(repmat(hand_drawn(:,c), 1, k), 1, repmat(muk(:,c)', 1, 1)))')';
end
la = (hand_drawn_prediction > 0.9) * [2; 3; 4];