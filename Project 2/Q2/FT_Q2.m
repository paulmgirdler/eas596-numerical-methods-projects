clc;
clear; 
close all;

%{
Part B (i)
Load the time series of ?1(t) given in theta1.dat (use the command
load(’theta1.dat’)).
%}

load('theta1.mat')

%{
Part B (ii)
For each value of a1(t), use a Newton solver to solve the nonlinear system 
of equations for a2 and x. For example, you can use the one posted with the 
homework solutions.
%}

% = [x1, x2]
% = [a1, r3]

F1 = inline('[x(2)-0.5*cos(x(1))-(0.75^2-(0.5*sin(x(1)))^2)^0.5]'); 
J1 = inline('1')

% = [x1, x2]
% = [a1, a2]

F2 = inline('-0.5*sin(x(1))-0.75*sin(x(2))')
J2 = inline('-0.75*cos(x(2))')

% = [a1, r3]
tol = 1E-6;
maxit = 10;

x_t = zeros(2,20);
t_theta2 = zeros(2,20);

for i = 1:length(t_theta)
    % x values
    x0 = [t_theta(2,i),0.75];
    x_t(1,i) = t_theta(1,i);
    xt = NewtonSysTemp(F1,J1,x0,tol,maxit);
    x_t(2,i) = xt(2);
end

tol = 1E-6;
maxit = 10;

for i = 1:length(t_theta)
    % theta values
    x0 = [t_theta(2,i),-2*pi];
    t_theta2(1,i) = t_theta(1,i);
    a2t = NewtonSysTemp(F2,J2,x0,tol,maxit);
    t_theta2(2,i) = -a2t(2)
end

%{
Part B (iii)
Plot a1 vs. t, a2 vs. t, and x vs. t
%}

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),t_theta(2,:),'-k');
plot(t_theta(1,:),t_theta2(2,:),'-r');
title('Plot: {\theta_1} & {\theta_2} vs time')
legend('{\theta_1}','{\theta_2}','location','southeast')
legend('boxoff')
xlabel('time t (s)')
ylabel('{\theta (rad)}')
hold off

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),x_t(2,:),'-b');
title('Plot: Piston position x vs time')
xlabel('time t (s)')
ylabel('{x (m)}')
hold off

%{
Part B (iv)
Compute the velocity and acceleration of the piston based on your x(t). 
Use a central di?erence method when applicable and a forward/backward 
di?erence method when central di?erence is not applicable. 
%}

% Forward difference at the left end;
% Backward difference at the right end;
% Central difference in the interior.
% Using calculated evaluated h values at each point to account for unevenly
% spaced i.e. noisey data.

% Compute the velocity.
v_t = central_diff(x_t(2,:),t_theta(1,:))


figure
% Plot function
hold on
grid on
plot(t_theta(1,:),v_t,'-r');
title('Plot: Piston velocity vs time')
xlabel('time t (s)')
ylabel('{x (m/s)}')
hold off

a_t = central_diff(v_t,t_theta(1,:))

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),a_t,'-r');
title('Plot: Piston acceleration vs time')
xlabel('time t (s)')
ylabel('{a (m/s^2)}')
hold off

%{
Part B (v)
Plot the computed piston force vs. x.
%}

% F = ma
% NOTE: m is a constant so F = 10a

figure
% Plot function
hold on
grid on
plot(x_t(2,:),10*a_t,'-r');
title('Plot: Piston force vs time')
xlabel('{x (m)}')
ylabel('{Force (N)}')
hold off

%{
Part B (vi)
Compute the work done by the piston. You may use the Matlab function, trapz,
for example.
%}

% we can move the constant mass out the front of the integration.

W = 10*trapz(x_t(2,:),a_t);

% W = -13.2220 J

%{
Part C
Write a MATLAB script that uses a least square regression analysis to find 
coefficients c1 and c2 that best fit the data. 
Plot the data and your best curve fit on the same plot.
%}

[p,S] = polyfit(t_theta(1,:),t_theta(2,:),2)

c1 = 5*pi/2; 
c2 = sqrt(2);

t_thetals = zeros(2,20);

%theta_f = @(t) p(1)*t^2+p(2)*t+p(3) 

for i = 1:length(t_theta)
    t_thetals(1,i) = t_theta(1,i);
    t_thetals(2,i) = ThetaFit(t_theta(1,i));
end

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),t_theta(2,:),'-k');
plot(t_thetals(1,:),t_thetals(2,:),'-r');
title('Plot: {\theta_1} & {\theta_1(t)} vs time')
legend('{\theta_1}','{\theta_1(t) LS}','location','southeast')
legend('boxoff')
xlabel('time t (s)')
ylabel('{\theta (rad)}')
hold off

%{
Part D
Now repeat steps 2(b)ii–2(b)vi using your curve fit for ?1(t).
%}

%{
For each value of a1(t), use a Newton solver to solve the nonlinear system 
of equations for a2 and x. For example, you can use the one posted with the 
homework solutions.
%}

% Now need to make F1 a function of t and x

% = [x1, x2]
% = [t, r3]

F1 = inline('[x(2)-0.5*cos(ThetaFit(x(1)))-(0.75^2-(0.5*sin(ThetaFit((x(1))))^2))^0.5]'); 
J1 = inline('1')

% Now need to make F2 a function of t and a2

% = [x1, x2]
% = [a1, a2]

F2 = inline('0.5*sin(ThetaFit(x(1)))+0.75*sin(x(2))')
J2 = inline('0.75*cos(x(2))')

tol = 1E-6;
maxit = 10;

x_t_2 = zeros(2,20);
t_theta2_2 = zeros(2,20);

for i = 1:length(t_theta)
    % x values
    x0 = [t_theta(1,i),0.75];
    x_t_2(1,i) = t_theta(1,i);
    xt = NewtonSysTemp(F1,J1,x0,tol,maxit);
    x_t_2(2,i) = xt(2);
end


tol = 1E-6;
maxit = 10;

for i = 1:length(t_theta)
    % theta values
    x0 = [t_theta(1,i),-2*pi];
    t_theta2_2(1,i) = t_theta(1,i);
    a2t = NewtonSysTemp(F2,J2,x0,tol,maxit);
    t_theta2_2(2,i) = -a2t(2);
end
%}

% Compute the velocity.
v_t_2 = central_diff(x_t_2(2,:),t_theta(1,:));

% Compute the acceleration.

a_t_2 = central_diff(v_t_2,t_theta(1,:));

%{
Compute the work done by the piston. You may use the Matlab function, trapz,
for example.
%}

% we can move the constant mass out the front of the integration.

W = 10*trapz(x_t_2(2,:),a_t_2);

% W = -14.2496 J

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),t_thetals(2,:),'-k');
plot(t_theta(1,:),t_theta2_2(2,:),'-r');
title('Plot: {\theta_1} & {\theta_2} vs time')
legend('{for \theta_1}','{for \theta_1(t) LS Fit}')
legend('boxoff')
xlabel('time t (s)')
ylabel('{\theta (rad)}')
hold off

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),x_t(2,:),'-b');
plot(t_theta(1,:),x_t_2(2,:),'-r');
title('Plot: Piston position x vs time')
legend('{for \theta_1}','{for \theta_1(t) LS Fit}')
xlabel('time t (s)')
ylabel('{x (m)}')
hold off

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),v_t,'-r');
plot(t_theta(1,:),v_t_2,'-b');
title('Plot: Piston velocity vs time')
legend('{for \theta_1}','{for \theta_1(t) LS Fit}')
xlabel('time t (s)')
ylabel('{x (m/s)}')
hold off

figure
% Plot function
hold on
grid on
plot(t_theta(1,:),a_t,'-r');
plot(t_theta(1,:),a_t_2,'-b');
title('Plot: Piston acceleration vs time')
xlabel('time t (s)')
ylabel('{a (m/s^2)}')
legend('{for \theta_1}','{for \theta_1(t) LS Fit}')
hold off

figure
% Plot function
hold on
grid on
plot(x_t(2,:),10*a_t,'-r');
plot(x_t_2(2,:),10*a_t_2,'-b');
title('Plot: Piston force vs x')
xlabel('{x (m)}')
ylabel('{Force (N)}')
legend('{for \theta_1}','{for \theta_1(t) LS Fit}')
hold off
