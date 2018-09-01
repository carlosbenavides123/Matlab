%  plotting.m

% ezplot, fplot, fimplicit3, ezpolar
% will use some calc and diff eq


figure(1) , clf

% notice how its a string for ezplot
% chooses its own range...
fx = '10*sin(x)';
h = ezplot(fx);
set(h,'linew', 2)

% using fplot

% @ defines its a function...very ugly
% (y) is its arguement... very ugly
fy = @(y) 10*sin(y) + tan(y/2)/10;
figure(2)
h = fplot(fy)
% define ur own range
% h = fplot(fy,[-15,5]);
set(h,'linew',2)

% implicit functions

fts = @(r,t,s) 2.^(t.*s) + r.*s - t.*s.^(1/3);
h = fimplicit3(fts) 
rotate3d on, axis image
set(h,'linestyle','none')

% polar plot

cardioid = @(t) 2*(1-cos(t));
h = ezpolar(cardioid)
set(h,'linew',2,'color','r')

