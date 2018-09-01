% fileName: MatlabExample_1.m
% last modified by Carlos Benavides
% 9/1/2018

% objective:
% z(t) = 3cos(1000*pi*t)*e^(-1000t)[u(t+0.001)-u(t-0.003)]

% clear the screen 
clc;
clear all;
format compact

%define the unit step function:
u = @(t) 1.0 .* (t >= 0)
t = (-10:0.1:10) * 0.001

% init figure
figure;
% set up to put two plots in one window
subplot(2,1,1)

plot(t,u(t+0.004) - u(t-0.004), '-*')
% activate grid
grid on; 
% Axis labels
xlabel('t (sec)');
ylabel('f(t) Volts');

% definte function g(t)
g = sin(1000*pi*t).* (u(t+0.004) - u(t-0.004));
subplot(2,1,2)
plot(t,g,'-*')

% activate grid
grid on;

% Axis
xlabel('t (sec)')
ylabel('g(t) Volts')