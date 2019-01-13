function [e, ra, rb, x0, y0, phi] = ellipse_fit_tol(x, y, tol)
% Adapted from:
% https://www.mathworks.com/matlabcentral/fileexchange/22423-ellipse-fit
% ellipse_fit - Given a set of points (x,y), ellipse_fit returns the
% best-fit ellipse
%
% Input:                  
%                       x - a vector of x measurements
%                       y - a vector of y measurements
%
% Output:
%
%                   ra  - Magnitude of ellipse semimajor (longer) axis
%                   rb  - Magnitude of ellipse semiminor (shorter) axis                  
%                   x0  - x coordinate of ellipse center 
%                   y0  - y coordinate of ellipse center 
%                   phi - counterclockwise angle of rotation from the x-axis 
%                         to the major axis of the ellipse
%                   
%
% Algorithm used:
%
% Given the quadratic form of an ellipse: 
%  
%       a*x^2 + 2*b*x*y + c*y^2  + 2*d*x + 2*f*y + g = 0   (1)
%
%       http://mathworld.wolfram.com/Ellipse.html Equation 15
%                      
%  we need to find the best (in the Least Square sense) parameters a,b,c,d,f,g. 
%  To transform this into the usual way in which such estimation problems are presented,
%  divide both sides of equation (1) by a and then move x^2 to the
% other side. This gives us:
%
%       2*b'*x*y + c'*y^2  + 2*d'*x + 2*f'*y + g' = -x^2   (2)
%
%   where the primed parameters are the original ones divided by a.
%   Now the usual estimation technique is used where the problem is
%   presented as:
%
%       NOTE: This equation is different from the equation given in the
%       homework assignment as it agrees more with traditional methods for
%       calculating the various properties of ellipses.
%
%           - bxy - ay^2 - cx - dy - e = -x^2  [HW]
%
%    M * p = b,  where M = [2*x*y y^2 2*x 2*y ones(size(x))], 
%    p = [ b c  d f g], and b = -x^2.
%    p = [2b a 2f 2d e] [HW]
% 
%     We seek the vector p, given by:
% 
%    p = pseudoinverse(M) * b.
%  
%    From here on I used formulas (19) - (24) in Wolfram Mathworld:
%    http://mathworld.wolfram.com/Ellipse.html
%
%
% Programmed by: Tal Hendel <thendel@tx.technion.ac.il>
% Faculty of Biomedical Engineering, Technion- Israel Institute of Technology     
% 12-Dec-2008
%
%--------------------------------------------------------------------------
x = x(:);
y = y(:);

%Construct M

M = [2*x.*y y.^2 2*x 2*y ones(size(x))];

% Multiply (-X.^2) by pseudoinverse(M)

e = pinv(M, tol)*(-x.^2);

%Extract parameters from vector e

a = 1;
b = e(1);
c = e(2);
d = e(3);
f = e(4);
g = e(5);

%Use formulae from Mathworld to find ra, rb, x0, y0, and phi.

delta = b^2-a*c;
x0 = (c*d - b*f)/delta;
y0 = (a*f - b*d)/delta;
phi = 0.5 * acot((a-c)/(2*b)); 
if (a > c)
    phi = phi + pi/2; 
end
nom = 2 * (a*f^2 + c*d^2 + g*b^2 - 2*b*d*f - a*c*g);
s = sqrt(1 + (4*b^2)/(a-c)^2);
a_prime = sqrt(nom/(delta* ( (c-a)*s -(c+a))));
b_prime = sqrt(nom/(delta* ( (a-c)*s -(c+a))));
ra = max(a_prime, b_prime);
rb = min(a_prime, b_prime);
end