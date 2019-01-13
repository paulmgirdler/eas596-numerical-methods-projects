function dy = fproblem1a(t,y)
n = length(t);
for i = 1:n
    if (t(i)==0)
        dy(i) = 1;
    else
        dy(i) = y(i)*(-2*t(i)+1/t(i));
    end
end