% write a matlab script to model a receiver system
% with a impulse response defined by h(t)
% subjected to 4 pulses, of duraction 0.1 seconds
% for every 2 seconds

%  h(t) = 2 * exp(t/tc)*u(t)
% a possible way
% x = @(t) ((u(t-2)-u(t-2.1))+(u(t-4)-u(t-4.1))+(u(t-6)-u(t-6.1))+(u(t-8)-u(t-8.1)));

% Requirements
% Make tc an input field -> generate sequence of plots for different tc vals

% file name: matlab_assignment_3.m
% last modified by Carlos Benavides on 9/26/2018
% clear 
clc 
clear all 
format compact 

% define functions
u = @(t) 1.0.*(t>=0);
h = @(t,tc) 2 * exp(-t/tc).*u(t)
x = @(t) ((u(t-2)-u(t-2.1))+(u(t-4)-u(t-4.1))+(u(t-6)-u(t-6.1))+(u(t-8)-u(t-8.1)));

% Define dialog properties
prompt = {
            'Enter a value for t_c',
        };
title = 'MatLab Assignment 4';
opts.Resize='on'
opts.WindowStyle = 'normal'
answer = inputdlg(prompt,title)

% extract values from input 
% convert to num
tc = str2num(answer{1})

tMax = 5;
tCountMax = tc;
dt = ( tMax / tCountMax )

for tCount = 1:tCountMax
    t(tCount) = tCount*dt
    y(tCount) = 0
    for tauCount = 1:tCountMax
        tau = tauCount*dt
        y(tCount) = y(tCount) + x(tau)*h(t(tCount)-tau,tCountMax)*dt
    end 
end 

figure;
subplot(3,1,1)
plot(t,x(t),'linewidth',2)
ylabel('x(t)')
grid on 
subplot(3,1,2)
plot(t,h(t,tc),'linewidth',2)
ylabel('h(t)')
grid on 
subplot(3,1,3)
plot(t,y,'linewidth',2)
ylabel('y(t)')
xlabel('time (s)')
grid on
