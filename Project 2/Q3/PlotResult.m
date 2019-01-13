function [x] = PlotResult(s,e,ptitle)

theta = 0:0.01:2*pi;
xs = @(s) (1 + 0.5*cos(4*s))*cos(s)
ys = @(s) (1 + 0.5*cos(4*s))*sin(s)

for i = 1:length(theta)
    x_fs(i) = xs(theta(i));
    y_fs(i) = ys(theta(i));
end

theta = s:0.01:e;
xs = @(s) (1 + 0.5*cos(4*s))*cos(s)
ys = @(s) (1 + 0.5*cos(4*s))*sin(s)


for i = 1:length(theta)
    x_s(i) = xs(theta(i));
    y_s(i) = ys(theta(i));
end
xlist = [x_s(1) x_s(end)];
ylist = [y_s(1) y_s(end)];

figure
hold on
% Plot function
plot(x_fs,y_fs,'-k');
% Plot pt from Si to Sf
plot(x_s,y_s,'-.b');
plot(xlist,ylist,'bo')
text(xlist+0.15,ylist+0.15,{'{S_i}','{S_f}'},'NE')
% Plot pt P
plot(1,2,'or');
legend('f(x,y)','Soln path','S','P(x,y)')
plot([1 xlist(1)],[2 ylist(1)],'--r');
plot([1 xlist(2)],[2 ylist(2)],'--r');
title(ptitle);
xlim([-3 3]);
ylim([-3 3]);
grid on;
axis equal;
hold off;
