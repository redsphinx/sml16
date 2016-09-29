function evec = ERMS2(x,y,l1,l2,xx,yy)
    evec = 0;
    M = 9;
    mcon = 0:M;
    for l=log(l1):log(l2)
        % getting weights
        w = E1Q5PolCurFit(x, y, M, 1/exp(-l));

        % approximation with weights
        z = @(x,w,m) sum((x.^m).*w');
        
        % evaluate error on xx and yy
        E = 0;
        for i=1:length(xx)
            E = E + (z(xx(i), w, mcon) - yy(i))^2;
        end

        E = E/2;

        Erms = sqrt(2 * E/length(x));
        evec = [evec Erms];
        
    end
    evec = evec(2:end);   
end
