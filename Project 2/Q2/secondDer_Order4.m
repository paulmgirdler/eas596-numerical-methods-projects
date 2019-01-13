function [dxx] = secondDer_Order4(h, f)    
    dxx = secondDer_Order2(h, f);
    dx4 = secondDer_Order2(h, dxx);
    dxx = dxx - h*h*dx4/12;
end

