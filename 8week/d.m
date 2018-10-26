%file name: M_6d.m
%Last modified by Carlos Benavides on 10/24/2018
clear all
format compact
clc

%define the symbolic variables that we will need
syms t n aSym(n) bSym(n) f(t)

% for 6.1d
tStart = -pi/4;
tStop = 0;
To = pi;
f(t) = 4/pi;
wo = 2*pi/To;
x(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

tStart = 0;
tStop = pi/4;
To = pi;
f(t) = 4/pi;
wo = 2*pi/To;
x2(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

tStart = pi/4;
tStop = (3*pi)/4;
To = pi;
f(t) = 0;
wo = 2*pi/To;
x2(t) = f(t) * (heaviside(t-tStart)-heaviside(t-tStop));

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
