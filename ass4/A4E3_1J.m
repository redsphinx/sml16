%% EM Algorithm
clc
clearvars -except X
% number of clusters
K = 4;
N = length(X);

dims = size(X,2);
mus = repmat(mean(X),K,1) + (rand(K, dims)-0.5)*2;
sigmas = repmat(eye(4)*(4*rand()+2),1,1,K);
pis = zeros(1,K) + 1/K;

respb = zeros(N,K);

%% log likelihood + E Step
cycles = 100;
loglik = zeros(cycles,1);
for i = 1:cycles
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
        
    
%     for n = 1:N
%         sumpxn = 0;
%         pxns = zeros(1,K);
%         for k = 1:K
%             pxn = pis(k)*mvnpdf(X(n,:),mus(k,:),sigmas(:,:,k));
%             sumpxn = sumpxn+pxn;
%             pxns(k) = pxn;
%         end
%         for k = 1:K
%             respb(n,k) = pxns(k)/sumpxn;
%         end
%         ln_pX = ln_pX + log(sumpxn);
%     end
    loglik(i) = ln_pX;
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