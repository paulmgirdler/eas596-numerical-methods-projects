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

hold on
title('Comparison of LS solution of an Elliptical Orbit')
plot(x,y,'b--o');
plot(xn,yn,'r--o');
[coeff, ra, rb, x0, y0, phi] = ellipse_fit(x,y);
ellipse(ra, rb, phi, x0, y0,'b');
[coeffn, ra, rb, x0, y0, phi] = ellipse_fit( xn,yn);
ellipse(ra, rb, phi, x0, y0,'r');
legend('x,y','x,y (with noise)','LS fit','LS fit (with noise)');

% Convert coeff to nice form
coeff = convertcoeff(coeff)';
coeffn = convertcoeff(coeffn)';
