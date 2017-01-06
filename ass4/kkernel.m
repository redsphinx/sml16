function kk = kkernel(th,x1,x2)
   kk = th(1)*exp(-th(2)/2 * sqrt((x1-x2).^2))+th(3)+th(4)*x1'*x2;
end