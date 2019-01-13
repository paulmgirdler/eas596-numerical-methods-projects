function [sq Q] = NewtonOpt(P,xs,ys,smin,bounds,tol,kmax)
syms f(x,y,s)
x = P(1);
y = P(2);
f(s) = sqrt(((x-xs(s))^2)+((y-ys(s))^2));
fun  = diff(f,s);
funpr = diff(fun,s);
x(1) = AdjustRange(smin,bounds);
y(1) = feval(fun, x(1));
ypr(1) = feval(funpr, x(1));

for k = 2:kmax
    x(k) = x(k-1) - y(k-1)/ypr(k-1);
    x(k-1) = AdjustRange(x(k-1),bounds);
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
sq = x(end);
Q = [xs(sq),ys(sq)];