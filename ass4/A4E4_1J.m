clc
clear

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
    figure
    image(reshape(X(i,:),[dims,dims]))
    colormap(BW_map);
end

%% Bernoulli MM
clc
% clearvars -except X
% number of clusters
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
        pi_log_pX(k,:) = (log(pis(k))+sum(log_pX_k,2))';
        pi_pX(k,:) = (pis(k) * exp(sum(log_pX_k,2)))';
    end
    
    for k = 1:K
%         respb(k,:) = pi_log_pX(k,:)./sum(pi_log_pX);
        respb(k,:) = pi_pX(k,:)./sum(pi_pX);
    end
    
    %% calculate log prob
    loglik(i) = sum(sum(respb.*pi_log_pX));
    
    %% M Step
    
    ln_pX = 0;
    pxns = zeros(N,K);
    for k = 1:K
        pxn = pis(k)*mvnpdf(X,mus(k,:),sigmas(:,:,k));
        pxns(:,k) = pxn;
    end
    ln_pX = sum(log(sum(pxns,2)));
    for k = 1:K
        respb(:,k) = pxns(:,k)./sum(pxns,2);
    end

    loglik(i,rep) = ln_pX;
%% M Step
    Nks = sum(respb);
    for k = 1:K
%         mus(k,:) = sum(bsxfun(@times,respb(:,k),X))/Nks(k);
        mus(k,:) = (respb(:,k)'*X)/Nks(k);
    end
    for k = 1:K
        varx = bsxfun(@minus,X,mus(k,:));
        sigmaskn = bsxfun(@times, permute(varx', [1 3 2]), permute(varx', [3 1 2]));
        sigmak = sum(permute(repmat(respb(:,k),1,4,4), [2 3 1]).*sigmaskn,3)/Nks(k);
        sigmas(:,:,k) = sigmak;
    end
    pis = Nks/N;
end
% end
plot(1:length(loglik),loglik)

%% figure out class assignments and plot
classignments = double(bsxfun(@eq, respb, max(respb, [], 2)));
correff = zeros(1,K);
for k = 1:K
    correff(k) = sigmas(1,2,k)/sqrt(sigmas(1,1,k)*sigmas(2,2,k));
end
correff

hold on;
colors = 'rgbp';
for k = 1:K
    scatter(X(classignments(:,K-k+1)==1,1),X(classignments(:,K-k+1)==1,2),colors(k));
end
title('Class assignments after 40 EM cycles')
xlabel('x1')
ylabel('x2')
%% assign classes to new datapoints

data = [11.85,2.2,0.5,4.0;
    11.95,3.1,0.0,1.0;
    12.0,2.5,0.0,2.0;
    12.0,3.0,1.0,6.3];
datarsp = zeros(length(data),K);
for d = 1:length(data)
    sumpxn = 0;
    pxns = zeros(1,K);
    for k = 1:K
        pxn = pis(k)*mvnpdf(data(d,:),mus(k,:),sigmas(:,:,k));
        sumpxn = sumpxn+pxn;
        pxns(k) = pxn;
    end
    for k = 1:K
        datarsp(d,k) = pxns(k)/sumpxn;
    end
end
datarsp