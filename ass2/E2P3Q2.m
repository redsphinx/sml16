E2P2Q2 % generate data

ns = [1,2,3,20];
as = -10:0.1:10;
bs = 0.1:0.1:5;

[as,bs] = meshgrid(as,bs);

for i = 1:length(ns)
    logprob = loglik(data,ns(i),as,bs)
    surf(as,bs,logprob);
    title(sprintf('Data Log-Likelihood after %d datapoints.', ns(i)));
    xlabel('\alpha');
    ylabel('\beta');
    saveas(gcf,sprintf('E2P3Q2_loglik_%dPoints.png',ns(i)));
    
    prob = exp(logprob-max(max(logprob)));
    surf(as,bs,prob);
    title(sprintf('Data Likelihood after %d datapoints.', ns(i)));
    xlabel('\alpha');
    ylabel('\beta');
    saveas(gcf,sprintf('E2P3Q2_lik_%dPoints.png',ns(i)));
end
    

