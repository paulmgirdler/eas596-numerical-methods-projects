function a = ThetaFit(t)
c1 = 5*pi/2;
c2 = sqrt(2);
for i = length(t);
    a(i) = c1*t/(t+c2);
end


