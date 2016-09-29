function evec = ERMS(x,y,M,xx,yy)
    evec = 0;
    for m=0:M
        mcon = 0:m;
        
        % getting weights
        w = E1Q2PolCurFit(x, y, m);

        % approximation with weights
        z = @(x,w,m) sum((x.^m).*w');
        
        % evaluate error on xx and yy
        E = 0;
        for i=1:length(xx)
            E = E + (z(xx(i), w, mcon) - yy(i))^2;
        end

        E = E/2;

        Erms = sqrt(2 * E/length(xx));
        evec = [evec Erms];
        
    end
    evec = evec(2:end);   
end
