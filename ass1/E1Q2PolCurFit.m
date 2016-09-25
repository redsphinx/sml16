function w = E1Q2PolCurFit(x, t, m)

T = zeros(m+1,1);

for i = 0:m
    T(i+1) = sum(t.*x.^(i));
end

A = zeros(m+1, m+1);

for r = 0:m
    for c = 0:m
        A(r+1,c+1) = sum(x.^(r+c));
    end
end

w = A\T;

% z = @(x,w,m) sum((x.^m).*w');
% mcon = [0:m];
% fun = @(x) z(x,w,mcon);
% fplot(fun, [0, 1])

end