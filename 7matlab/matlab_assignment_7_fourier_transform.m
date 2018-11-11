% file_name : M_7.m
% Last modified by Carlos Benavides on 11/11/2018

% clear
clear all
format compact
clc 

% define symbolics
% this test value is used to be the index for 
% xxApprox(test,:) = eval(xApprox(t))
% I noticed that xxAprox was creating 1 row and like 200 columns
% so I use test to create a matrix
test = 1

% step through everything with respect to i
% i is suppose to mimic alpha
% we will be creating a lot of figures...
for i = 0.70:0.02:0.98

    syms w t x(t) X(w) T W; % be careful performance issue.

    x(t) = heaviside(t+T/2) - heaviside(t-T/2);
    X(w) = simplify(fourier(x(t),w));
    T = 2;
    
    X(w) = eval(X(w));
    Xsq(w) = X(w)*conj(X(w));
    Etot = int(Xsq(w) ,- inf, inf) / ( 2 * pi );
    E(W) = int(Xsq(w), -W, W) / (2 * pi);

    maxW = 10;

    % plot
    figure(test)
    subplot(3,1,1)
    fplot(Xsq(w),[0 maxW])
    grid on
    ylabel('|X(w)|^2');
    xlabel('w ');

    subplot(3,1,2)
    fplot(E(W)/Etot, [0 maxW])
    grid on

    ylabel('E(w)')
    xlabel('W (radians/sec)')
    hold on

    Web = vpa(vpasolve(E(W) == i*Etot),3);
    plot([0 maxW], [i i], '--')
    plot([Web Web], [0 1], '--')
    hold off
    subplot(3,1,3)
    
    xApprox(t) = (1/(2*pi))*int(X(w)*exp(j*w*t),w,-Web,Web)
    t=-10:0.1:10;

    xxApprox(test,:) = eval(xApprox(t))
    plot(t,xxApprox(test,:))
    grid on
    hold on
    xx = eval(x(t));
    plot(t,xx);
    txt = ['The alpha valus is ',num2str(i)];
    ylabel(txt)
    hold off;

    % increment test to add xxAprox to next row in the matrix
    test = test + 1

    % reset every symbolic to avoid issues
    reset(symengine)
end
