function x = NewtonSysTemp(F, J, x0, tol, kmax)
e = length(x0);
xold = x0; iter = 1;
while (iter <= kmax);
    y = -feval(J,xold)\feval(F,xold);
    xnew = [xold(1) (xold(2:e) + y')];
    dif = norm(xnew(2:e)-xold(2:e));
    disp([iter xnew dif]);
    if dif <= tol
        x = xnew; disp('Newton method has converged'), return;
    else
        xold = xnew;
    end
    iter = iter + 1;
end
disp('Newton method did not converge')
x = xnew;