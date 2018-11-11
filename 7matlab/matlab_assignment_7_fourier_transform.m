% file_name : M_7.m
% Last modified by Carlos Benavides on 11/11/2018

% clear
clear all
format compact
clc 

% define symbolics
syms w t x(t) X(w) T W; % be careful performance issue.

% write comment
x(t) = heaviside(t+T/2) - heaviside(t-T/2);
X(w) = simplify(fourier(x(t),w));
alpha = 0.90;
T = 2;
X(w) = eval(X(w));
Xsq(w) = X(w)*conj(X(w));
Etot = int(Xsq(w) ,- inf, inf) / ( 2 * pi );
E(W) = int(Xsq(w), -W, W) / (2 * pi);

maxW = 10;

% plot
subplot(3,1,1)
fplot(Xsq(w),[0 maxW])
grid on
ylabel('|X(w)|^2');
xlabel('w ');

subplot(3,1,2)
fplot(3,1,2)
fplot(E(W)/Etot, [0 maxW])
grid on
ylabel('E(w)')
xlabel('W (radians/sec)')
hold on

Web = vpa(vpasolve(E(W) == alpha*Etot),3);
plot([0 maxW], [alpha alpha], '--')
plot([Web Web], [0 1], '--')
hold off
subplot(3,1,3)

xApprox(t) = (1/(2*pi))*int(X(w)*exp(j*w*t),w,-Web,Web);
t=-10:0.1:10;

xxApprox = eval(xApprox(t));
plot(t,xxApprox)
grid on
hold on
xx = eval(x(t));
plot(t,xx);
hold off;
