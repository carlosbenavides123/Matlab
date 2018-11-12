% file_name : M_7.m
% Last modified by Carlos Benavides on 11/11/2018

% clear
clear all
format compact
clc 

% idx = index
% xxApprox(idx,:) = eval(xApprox(t))
% basically with idx, it creates a row in xxApprox, and stores the many column values wrt to iteration
idx = 1
max = 0
% alpha varies from 0.70 to 0.98 in steps of 0.02
for alpha = 0.70:0.02:0.98

    % define symbolics
    syms w t x(t) X(w) T W; 

    % define heaviside and both Time/2 for limits of integral
    x(t) = heaviside(t+T/2) - heaviside(t-T/2);

    % compute fourier on the symbolics
    % creates a string of the equation
    X(w) = simplify(fourier(x(t),w));

    % plug in T=2 and evaluate the expression
    T = 2;
    X(w) = eval(X(w));

    % X(w) * complex conjugate of the same X(w)
    Xsq(w) = X(w)*conj(X(w))

    % Energy total of a signal
    Etot = int(Xsq(w) ,- inf, inf) / ( 2 * pi );

    % fraction of energy between -W, W
    E(W) = int(Xsq(w), -W, W) / (2 * pi);

    maxW = 10;

    % plot
    figure(idx)
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


    Web = vpa(vpasolve(E(W) == alpha*Etot),3)
    plot([0 maxW], [alpha alpha], '--')
    plot([Web Web], [0 1], '--')
    hold off
    subplot(3,1,3)
    
    xApprox(t) = (1/(2*pi))*int(X(w)*exp(j*w*t),w,-Web,Web);
    t=-10:0.1:10;

    xxApprox(idx,:) = eval(xApprox(t));
    
    temp = nansum(xxApprox(idx,:))
    
    if (max < temp)
        max = temp
        id = idx
    end
    
    plot(t,xxApprox(idx,:))
    grid on
    hold on
    xx = eval(x(t));
    plot(t,xx);
    txt = ['The alpha valus is ',num2str(alpha)];
    ylabel(txt)
    hold off;

    % increment idx to add xxAprox to next row in the matrix
    idx = idx + 1

    % reset every symbolic to avoid issues
    reset(symengine)
end

