function dt = fproblem1c(t)
n = length(t);
for i = 1:n
    if (t(i)==0)
        dt(i) = 0;
    else
        dt(i) = (-2*t(i));
    end
end