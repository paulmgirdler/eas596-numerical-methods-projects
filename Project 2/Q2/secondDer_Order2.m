function [dxx] = secondDer_Order2(h, f)
    n = length(f);    
    m = [n-1 1:n-1];
    p = [2:n 2];     
    dxx = (f(p) - 2*f + f(m))./(h*h);    
end

