% file name: matlab_assignment_3.m
% last modified by Carlos Benavides on 9/17/2018
% clear 
clc 
clear all 
format compact 

% define functions
u = @(t) 1.0.*(t>=0);
h = @(t) exp(-t) .* (u(t));
x = @(t) exp(-t) .* (u(t));

%define animation
curve = animatedline('Color','b','LineStyle','--','LineWidth',3)
set(gca,'XLim', [0,5], 'YLim',[-1,1]);
grid on;

tMax = 5;
tCountMax = 100;
dt = ( tMax / tCountMax )


% will loop tCountMax^2 times
for tCount = 1:tCountMax
    % assign t and initialize y at point tCount
    t(tCount) = tCount*dt;
    y(tCount) = 0;
    for tauCount = 1:tCountMax
        % increase tau wrt tauCount
        tau = tauCount*dt;
        % update each element of vector y
        % loop will continue even if y(tCount) doesnt exist
        y(tCount) = y(tCount) + x(tau)*h(t(tCount)-tau)*dt;
    end 
    addpoints(curve,t(tCount),y(tCount));
    pause(0.01);
    drawnow
end 

figure;
subplot(3,1,1)
plot(t,x(t),'linewidth',2)
ylabel('x(t)')
grid on 
subplot(3,1,2)
plot(t,h(t),'linewidth',2)
ylabel('h(t)')
grid on 
subplot(3,1,3)
plot(t,y,'linewidth',2)
ylabel('y(t)')
xlabel('time (s)')
grid on