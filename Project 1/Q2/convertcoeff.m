function [c] = convertcoeff(e)
% take vector of coefficients e in form from Wolfram Maths website and
% convert into vector c
% e = [b, c, d, f, g]
% c = [a, b, c, d, e]
c = zeros(5,1)
c(1) = e(2); % a = c
c(2) = e(1); % b = b
c(3) = 2*e(3); % c = 2*d
c(4) = 2*e(4); % d = 2*f
c(5) = e(5); % e = g