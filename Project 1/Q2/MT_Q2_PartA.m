clear;
clc;

A = sym([1/3 1/3 2/3; 2/3 2/3 4/3; 1/3 2/3 3/3; 2/5 2/5 4/5; 3/5 1/5 4/5]);
r = rank(A)

% Rank = 2

% Calculate SVD for a range of precision values

for i=1:69
digits(i+31);
[U,S,V] = svd(A);
e(i) = S(3,3)
end

% Plot 3rd Singular value for a range of precision values
% 3rd Singular value approaches zero
% Rank = 2

x = linspace(32,100,69)
semilogy(x,e);
title('Plot: 3rd Singular Value vs Precision');
xlabel('Digits of Precision');
ylabel('3rd Singular Value');