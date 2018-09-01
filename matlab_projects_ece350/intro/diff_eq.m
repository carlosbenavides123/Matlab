
syms y(t); % be careful performance issue.

eq = diff(y) == exp(-t) - 2*y;

% find genreal solution
dsolve( eq )

% particular solution given intial condition
dsolve( eq, y(0) ==2 )

% draw solution

[tt, yy] = meshgrid(linspace(-2,3,30), linspace(-1,2,32));
sol = exp(-tt) - 2*yy;

figure(2), clf, hold on
L = sqrt(1 + sol.^2);
h = quiver(tt,yy,1./L, sol./L, 0.5);
set(h,'linew',2 , 'color', [.8,.8,.8])

initvals = [ 2 1 .75 ,5];

for i=1:length(initvals)
    h1(i) = ezplot( dsolve(eq,y(0) == initvals(i)), [min(tt(:)) max(tt(:))])
end

axis([ min(tt(:)) max(tt(:)) min(yy(:)) max(yy(:)) ])
set(h1,'linew',3)