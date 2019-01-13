function [x] = AdjustRange(x,bounds)
lower  = bounds(1);
upper  = bounds(2);
range  = upper - lower;

while x < lower
    x = x + range;
    disp('adjusted upwards')
end
while x > upper
    x = x - range;
    disp('adjusted downwards')
end