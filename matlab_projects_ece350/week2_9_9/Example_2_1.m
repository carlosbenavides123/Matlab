% FileName:Example_2_1.m
% Last modified by carlos benavides 9/9/2018
% clear screen, clear variables
clc 
clear all 
format compact 

prompt = 'Enter coefficient of dx/dt';
b = input(prompt)

prompt = 'Enter coefficient of x:';
c = input(prompt)

prompt = 'Enter y(0):';
y0 = input(prompt)

prompt = 'Enter dy(0)/dt:';
yDot0 = input(prompt)

syms y(t); % be careful performance issue.
Dy = diff(y)
ode = diff(y,t,2) == -b*diff(y,t,1)-c*y;

cond1 = y(0) == y0;
cond2 = Dy(0) == yDot0;

% solve ode for y
conds = [cond1 cond2];
ySol(t) = dsolve(ode,conds);
ySol = simplify(ySol);
ySol = vpa(ySol,3)
