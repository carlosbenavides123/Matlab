% filename: Matlab_Assignment_M_2.m
% last modified: Carlos Benavides 9/9/2018
% This is assignment 2.

% clear the screen...
clc 
clear all
format compact

% Define dialog properties
prompt = {
            'Enter coefficient of dy/dt:',
            'Enter coefficient of y:',
            'Enter y(0):',
            'Enter dy(0)/dt:',
        };
title = 'MatLab Assignment 2';
opts.Resize='on'
opts.WindowStyle = 'normal'
answer = inputdlg(prompt,title)

% extract values from input 
% convert to num
b = str2num(answer{1})
c = str2num(answer{2})
yO = str2num(answer{3})
yDotO = str2num(answer{4})

% symbolic function
syms y(t); % be careful performance issue.
Dy = diff(y)

% ordinary differential eq
ode = diff(y,t,2) == -b*diff(y,t,1)-c*y

cond1 = y(0) == yO
cond2 = Dy(0) == yDotO

% the initial conditions in a vector...
conds = [cond1 cond2]
% particular solution given intial condition
ySol(t) = dsolve(ode,conds)
% simplify the solution, make it look pretty...
ySol = simplify(ySol);
% define the amount of numbers after the decimal...
ySol = vpa(ySol,3)