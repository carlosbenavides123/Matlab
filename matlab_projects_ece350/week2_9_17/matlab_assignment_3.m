% file name: matlab_assignment_3.m
% last modified by Carlos Benavides on 9/17/2018
% clear 
clc 
clear all 
format compact 

% define functions
u = @(t) 1.0.*(t>=0);
h = @(t) t.^2 .* (u(t) - u(t-3));
x = @(t) (u(t) - u(t-2));

tMax = 5;
tCountMax = 100;
dt = ( tMax / tCountMax )

for tCount = 1:tCountMax
    % assign t and initialize y at point tCount
    t(tCount) = tCount*dt 
    y(tCount) = 0;
    for tauCount = 1:tCountMax
        % increase tau wrt tauCount
        tau = tauCount*dt
        % update each element of vector y
        % loop will continue even if y(tCount) doesnt exist
        % will loop tCountMax^2 times
        y(tCount) = y(tCount) + x(tau)*h(t(tCount)-tau)*dt;
    end 
end 

% figure;
% subplot(3,1,1)
% plot(t,x(t),'linewidth',2)
% ylabel('x(t)')
% grid on 
% subplot(3,1,2)
% plot(t,h(t),'linewidth',2)
% ylabel('h(t)')
% grid on 
% subplot(3,1,3)
% plot(t,y,'linewidth',2)
% ylabel('y(t)')
% xlabel('time (s)')
% grid on