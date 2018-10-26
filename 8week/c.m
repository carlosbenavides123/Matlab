%file name: M_6c.m
clear all%clears the command window
format compact
clc

%creates variables and clears all assumptions
syms t n aSym(n) bSym(n) x(t) f(t)

% THIS IS FOR C

tStart = 0; %the start of 1 wave
tStop = 2 * pi; %the end of 1 wave
To = 2 * pi; % the period
f(t) = t / (2 * pi); %this is the amplitude
wo = 2 * pi / To; %just pluging in the normal formula of wo
x(t) = f(t) * (heaviside(t - tStart) - heaviside(t - tStop));

a0 = int(x(t), t, tStart, tStop) / To%return a0
aSym(n) = simplify(int(x(t) * cos(n * wo * t), t, tStart, tStop) / (To / 2))%plug vals into an
bSym(n) = simplify(int(x(t) * sin(n * wo * t), t, tStart, tStop) / (To / 2))%tplug vals into bn

nMax = 20; %the number of points we want
n = 1:nMax;
a = eval(aSym(n));
b = eval(bSym(n));

figure%creates a new window using defualt values
subplot(3, 1, 1)%the subplot chooses the location and how many graphs
stem(n, a)%plots the data a into specified n
ylabel('a(n)'); %labels the y axis
subplot(3, 1, 2);
stem(n, b)
ylabel('b(n)');

xApprox = a0;

for m = 1:nMax%plots more points to make the graph smoother
    %each loop plots another point
    xApprox = xApprox + a(m) * cos(m * wo * t) + b(m) * sin(m * wo * t);
end

t = -20 * pi:0.1:20 * pi;

xCalc = eval(xApprox); % evaluates xApprox
subplot(3, 1, 3);
plot(t, xCalc)
grid on
ylabel('x(t)')
