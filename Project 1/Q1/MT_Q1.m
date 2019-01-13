clear;
clc;

x = [1.02 0.95 0.87 0.77 0.67 0.56 0.44 0.3 0.16 0.01];
y = [0.39 0.32 0.27 0.22 0.18 0.15 0.13 0.12 0.13 0.15];

[coeff, ra, rb, x0, y0, phi] = ellipse_fit(x,y);
figure(1)
plot(x,y,'r--o');
ellipse(ra, rb, phi, x0, y0);
title('Plot: Linear Regression of Elliptical Orbit');

% Convert coeff to nice form
coeff = convertcoeff(coeff);