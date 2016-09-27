function print(a)
    
    if isa(a, 'char')
        disp(sprintf(a))
    else
        disp(sprintf('error: input must be char'))
    
end