% function evec = ERMS(x,y,M,l)
function evec = ERMS(x,y,M,xx,yy)
    evec = 0;
    for m=0:M
        mcon = 0:m;
        
        % getting weights
        w = E1Q2PolCurFit(x, y, m);
%         w = E1Q5PolCurFit(x, y, m, l);

        % approximation with weights
        z = @(x,w,m) sum((x.^m).*w');
        
        % calculate error
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
