%file name: M_6e.m
%Last modified by David Schwartz on 10/11/2018
clear all
format compact
clc

% THIS IS FOR C

syms t n aSym(n) bSym(n) x(t) f(t)

tStart = 0;
tStop = 1;
To =  3;
f(t) = t;
wo = 2 * pi / To;
x(t) = f(t) * (heaviside(t - tStart) - heaviside(t - tStop));

a0 = int(x(t), t, tStart, tStop) / To
aSym(n) = simplify(int(x(t) * cos(n * wo * t), t, tStart, tStop) / (To / 2))
bSym(n) = simplify(int(x(t) * sin(n * wo * t), t, tStart, tStop) / (To / 2))

pretty(aSym(n))
pretty(bSym(n))

nMax = 20;
n = 1:nMax;
a = eval(aSym(n));
b = eval(bSym(n));

figure
subplot(3, 1, 1)
stem(n, a)
ylabel('a(n)');
subplot(3, 1, 2);
stem(n, b)
ylabel('b(n)');

xApprox = a0;

for m = 1:nMax
    xApprox = xApprox + a(m) * cos(m * wo * t) + b(m) * sin(m * wo * t);
end

t = -20 * pi:0.1:20 * pi;

xCalc = eval(xApprox);
subplot(3, 1, 3);
plot(t, xCalc)
grid on
ylabel('x(t)')
