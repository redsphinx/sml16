% A3E2P1
function [outs, vals] = newtonraphsonsin(x0, iters)
    x_n = x0;
    outs = [];
    vals = [];
    for i = 1:iters
        x_nn = x_n + (cos(x_n)/sin(x_n));
        outs = [outs, x_nn];
        vals = [vals,sin(x_nn)];
        x_n = x_nn;
    end
        
    hold on
    plot(1:iters, outs, 'b')
    plot(1:iters, vals, 'r.')
end
