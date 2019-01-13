clc;
clear; 
close all;

xs = @(s) cos(s)
ys = @(s) sin(s)
P = [4,2]

syms f(x,y,s)
x = P(1);
y = P(2);
f = @(s) sqrt(((x-xs(s))^2)+((y-ys(s))^2));

% analytical solution = inverse tan(y/x)
sa = atan(2/4);

% Part D
sn1 = fminbnd(f,0,2*pi()); % s = 0.4637
Qn1 = [xs(sn1),ys(sn1)];
Qa = [xs(sa),ys(sa)];

e1 = abs((Qn1-Qa)/Qa); % absolute rel error 6.2794e-11

%{
Part E
Using Newton’s method for minimization, write a function which takes as an 
input x(s), y(s), the bounds on s, an initial guess for smin, and the point 
~p and returns the closest point on the interface, ~q. 
Use this to determine the closest point ~q to the point ~p = (4, 2)
for the unit circle.
%}

smin = 0;
tol = 1E-3;
kmax = 20;
P = [4 2];
bounds = [0 2*pi]

[sn2 Qn2] = NewtonOpt(P,xs,ys,smin,bounds,tol,kmax)

e2 = abs((Qn2-Qa)/Qa); % absolute rel error 6.2794e-11

%{
Part F
Using your Newton’s method for minimization, determine the closest point ~q 
to the point ~p = (1, 1) for 
x(s) = (1 + 0.5 cos(4s))*cos(s)
y(s) = (1 + 0.5 cos(4s))*sin(s)
for s ? [0, 2?] 
using an initial guess of s = 0, s = ?/2, and s = 5?/4. 
Do you get the same result? 
Explain your results using a figure with the interface, the point p and the
solutions.
%}

xs = @(s) (1 + 0.5*cos(4*s))*cos(s)
ys = @(s) (1 + 0.5*cos(4*s))*sin(s)

tol = 1E-3;
kmax = 20;

P = [1 2];
bounds = [0 2*pi]

% Case 1
smin = 0;
[sn3 Qn3] = NewtonOpt(P,xs,ys,smin,bounds,tol,kmax)

% Case 2
smin = pi/2;
[sn4 Qn4] = NewtonOpt(P,xs,ys,smin,bounds,tol,kmax)

% Case 3
smin = 5*pi/2;
[sn5 Qn5] = NewtonOpt(P,xs,ys,smin,bounds,tol,kmax)

PlotResult(0,sn3,'Plot: Case 1: {s_i = 0}')
PlotResult(0,sn4,'Plot: Case 2 & 3: {s_i = \pi/2}, {5\pi/2}')







