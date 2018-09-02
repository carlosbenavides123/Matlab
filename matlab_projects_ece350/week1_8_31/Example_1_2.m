% file name: Example_1_2.m
% Last modified by Carlos Benavides on 9/1/2018

%clear
clc
clear all
format compact 

% symbolic
syms w t p1 p2 

x = cos(w*t + p1) + cos(w*t + p2)

xsq = x*x 

xsq = simplify(expand(xsq));

% output
x = cos(p1 + t*w) + cos(p2 + t*w)
xsq = cos(p1 + t*w) + cos(p2 + t*w).^2

xsq =cos(p1-p2)
    + cos(2*p1 + 2*t*w)/2
    + cos(2*p2 + 2*t*w)/2
    + cos(p1 + p2 + 2*t*w)
    + 1