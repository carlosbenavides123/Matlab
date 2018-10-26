%file name: M_6.m
%Last modified by Carlos Benavides on 10/24/2018
clear all
format compact
clc

%define the symbolic variables that we will need
syms t n aSym(n) bSym(n) f(t)


%Using the heaviside built-in function instead of an in-line u(t)
%This appears to b needed to work with the symbolic toolbox 
%for this application

% for 6.1a
tStart = -1;
tStop = 1;
To = 4;
f(t) = 1;
wo = 2*pi/To;
x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

tStart = 1;
tStop = 3;
To = 4;
f(t) = -1;
wo = 2*pi/To;
x2(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

% %This is a specifice example for 6.1-b
% tStart = -pi;
% tStop = pi;
% To = 10*pi;
% f(t) = 1;
% wo = 2*pi/To;
% x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));
% 
% % For 6.1-c
% tStart = 0;
% tStop = 2*pi;
% To = 2*pi;
% f(t) = 1;
% wo = 2*pi/To;
% x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));
% 
% % for 6.1-d
% tStart = -pi/4;
% tStop = pi/4;
% To = pi;
% f(t) = 1;
% wo = 2*pi/To;
% x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

% for 6.1-e
% tStart = 0;
% tStop = 1;
% To = t;
% f(t) = 4;
% wo = 2*pi/To;
% x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));
% 

a0       = int(x(t),t,tStart,tStop)/To
aSym(n)  = simplify(int((x(t))*cos(n*wo*t),t,tStart,tStop)/(To/2))
bSym(n)  = simplify(int((x(t))*sin(n*wo*t),t,tStart,tStop)/(To/2))

a20       = int(x2(t),t,tStart,tStop)/To
aSym2(n)  = simplify(int((x2(t))*cos(n*wo*t),t,tStart,tStop)/(To/2))
bSym2(n)  = simplify(int((x2(t))*sin(n*wo*t),t,tStart,tStop)/(To/2))

nMax    = 20;
n       = 1:nMax;
a       = eval(aSym(n)+aSym2(n));
b       = eval(bSym(n)+bSym2(n));

figure
subplot(3,1,1)
stem(n,a)
ylabel('a(n)');
subplot(3,1,2);
stem(n,b)
ylabel('b(n)');

xApprox = a0+a20;
for m = 1:nMax
    xApprox = xApprox + a(m)*cos(m*wo*t) + b(m)*sin(m*wo*t);
end
t = -20*pi:0.1:20*pi;

xCalc = eval(xApprox);
subplot(3,1,3);
plot(t,xCalc)
grid on
ylabel('x(t)')
xlim([-7 7])
