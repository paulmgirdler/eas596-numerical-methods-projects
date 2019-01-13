function s = LS_Line(x,y)
m = length(x);
x = x(:);
y = x(:); %convert to column form if necessary
sx = sum(x);
sy = sum(y);
sxx = sum(x.*x);
sxy = sum(x.*y);
c = m*sxx - sx^2;
a = (m*sxy - sx*sy)/c
b = (sxx*sy - sxy*sx)/c
table = [x        y        (a*x*b)        (y - (a*x*b))];
disp('x        y        (a*x*b)        (y - (a*x*b))')
disp(table);
err = sum(table(:,4).^2)
s(1) = a;
s(2) = b;