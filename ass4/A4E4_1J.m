clc
clear
rng(45)
%%
N = 800; D = 28*28; X = uint8(zeros(N,D));
fid = fopen ('a012_images.dat', 'r');
for i = 1:N
    X(i,:)  = fread(fid, [D], 'uint8');
end;
status = fclose(fid);

BW_map=[1,1,1; 0,0,0]; 
dims = sqrt(D);

for i = 1:10
% 	figure
% 	image(reshape(X(i,:),[28,28]))
%     colormap(BW_map);
end

X = double(X);
%% Bernoulli MM
K = 3;
N = size(X,1);
dims = size(X,2);
pis = zeros(1,K) + 1/K; %responsibilities

%% log likelihood + E Step
cycles = 40;
reps = 1;
loglik = zeros(cycles,reps);

% for rep = 1:reps
mus = rand(K, dims)/2+0.25;
% sigmas = repmat(eye(4)*(4*rand()+2),1,1,K);

respb = zeros(N,K);
%%
for i = 1:cycles
    pi_log_pX = zeros(K,N);
    pi_pX = zeros(K,N);
    respb = zeros(K,N);  
    for k = 1:K
        log_pX_k = log(binopdf(X, 1, repmat(mus(k,:), N,1)));
        log_pX_k(log_pX_k == -Inf) = 0;
        sum_log_pX_k = sum(log_pX_k,2);
        pi_log_pX(k,:) = (log(pis(k))+sum_log_pX_k)';
        pi_pX(k,:) = (pis(k) * exp(sum_log_pX_k))';
    end
    
    for k = 1:K
        respb(k,:) = pi_pX(k,:)./sum(pi_pX);
        Nk = sum(respb(k,:),2);
        pis(k) = Nk/N;
        mus(k,:) = (respb(k,:)*X)/Nk;
    end
    
    %% calculate log prob
    loglik(i) = sum(sum(respb.*pi_log_pX));
    
    %% M Step
end
% end
plot(1:length(loglik),loglik)

%%

for k = 1:K
	img = mus(k,:)*255;
    figure;
    image(reshape(img,[28,28]))
    colormap(gray(255));
end

%% figure out class assignments and plot
classignments = round(respb);
classignments(1,:) = classignments(1,:)*4;
classignments(2,:) = classignments(2,:)*3;
classignments(3,:) = classignments(3,:)*2;
labels = sum(classignments)';
%% assign classes to new datapoints
fid = fopen ('a012_labels.dat', 'r');
Z = fread(fid, N, 'uint8');
%%
diff = labels - Z;
misclass = find(diff);
misimages = X(misclass(1:4),:);
