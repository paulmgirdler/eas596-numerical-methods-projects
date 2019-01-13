function x = NewtonSys(F, J, x0, tol, kmax)
xold = x0; iter = 1;
while (iter <= kmax);
    y = -feval(J,xold)\feval(F,xold);
    xnew = xold + y';
    dif = norm(xnew - xold);
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