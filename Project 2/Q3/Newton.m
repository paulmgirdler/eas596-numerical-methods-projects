function [x,y] = Newton(fun, funpr, x1, tol, kmax)

x(1) = x1;
y(1) = feval(fun, x(1));
ypr(1) = feval(funpr, x(1));
for k = 2:kmax
    x(k) = x(k-1) - y(k-1)/ypr(k-1);
    y(k) = feval(fun, x(k));
    if abs(x(k) - x(k-1)) < tol
        disp('Newtons method has converged'); break;
    end
    ypr(k) = feval(funpr,x(k));
    iter = k;
end
if (iter >= kmax)
    disp('Zero not found to desired tolerance');
end
n = length(x);
k = 1:n;
out = [k' x' y'];
disp('          step        x        y')
disp(out)