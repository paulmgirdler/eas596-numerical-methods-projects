clear;
clc;
rng(123123);

x = [1.02 0.95 0.87 0.77 0.67 0.56 0.44 0.30 0.16 0.01];
y = [0.39 0.32 0.27 0.22 0.18 0.15 0.13 0.12 0.13 0.15];
n = 0.005 % amplitude of noise
nx = -n + 2*n*rand(1,10);
ny = -n + 2*n*rand(1,10);

xn = x + nx
yn = y + nx

% Computing coeff for (no noise) with varying tolerances
% Plot results
coeff = zeros(5,5);
figure(1)
hold on
title('Comparison of LS solution of an Elliptical Orbit (no noise)')
plot(x,y,'b--o');
for i=1:5;
tol = 10^(-i);
[e, ra, rb, x0, y0, phi] = ellipse_fit_tol(x,y,tol);
c = convertcoeff(e);
coeff(i,:) = c'
ellipse(ra, rb, phi, x0, y0,'b');
end
hold off

% Computing coeff for (no noise) with varying tolerances
% Plot results
coeffn = zeros(5,5);
figure(2)
hold on
title('Comparison of LS solution of an Elliptical Orbit (noise)')
plot(xn,yn,'r--o');
for i=1:5;
tol = 10^(-i);
[e, ra, rb, x0, y0, phi] = ellipse_fit_tol(xn,yn,tol);
c = convertcoeff(e);
coeffn(i,:) = c'
ellipse(ra, rb, phi, x0, y0,'r');
end
hold off


    
    
    

