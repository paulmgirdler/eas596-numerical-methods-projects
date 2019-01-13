clc;
clear; 
close all;

% Part A
n = 1000;
tspan = [0,1]
y0 = 0;

y1_true = exp(-1)

[ts,ys] = RK4s(@fproblem1a,tspan,y0,n);
y_t1_a = ys(end); %  Numerical Soln 0.4330
%plot(ts,ys,'o-');

error1 = (y_t1_a-y1_true)*100/y1_true

% Part C
% Compute the exact solution y(1) by computing the integrals from the 
% previous part

% Exact solution = e^-1 = 0.3679

y1_true = exp(-1)

% Part D

g = @(t) t.*exp(-(t.^2));

Id1 = Simp(g,0,1,1000);

y_t1_d1 = Id1 %  Numerical Soln 0.3161

error2 = (y_t1_d1-y1_true)*100/y1_true

h = @(x) 0.5*(x+1).*exp(-(0.25*(x+1).^2));

Id2 = GaussQuad(h,-0.5,0.5,2);

y_t1_d2 = Id2 %  Numerical Soln 0.3712, n = 5

error3 = (y_t1_d2-y1_true)*100/y1_true % 0.4149 %, n = 2














