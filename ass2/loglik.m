function logprob = loglik(data, n, as, bs)
    
    loglikdata = 0;
    for k = 1:n
        loglikx = log(bs.^2 + (data(k) - as).^2);
        loglikdata = loglikdata + loglikx;
    end
    
    logprob = k*log(bs) - k*log(pi) - loglikdata;
end
