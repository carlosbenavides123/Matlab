
% limits
% symbolic variable???
% x = x...

syms x

fx = (x-4)^2;

figure(1), clf 
fplot(fx,[-2 8], 'linew', 4)

% compute limie as x -> 1
a = 3
% lim is equal to...
% function(x) as x goes to a
lim = limit(fx,x,a);

% plot the limit with red dashes...
hold on
plot([1 1]*a,get(gca,'ylim'),'r--')
plot(get(gca,'xlim'),[1 1]*lim,'r--')

fx = (x^2-25) / (x^2+x-30)
fplot(fx,[-10 10], 'linew', 2)

limit(fx)
a = 5
lim5 = limit(fx,a)

hold on 
plot([1 1]*a, get(gca, 'ylim'), 'r--')
plot(get(gca, 'xlim'), [1 1]*lim5, 'r--')

limit(fx,x,-6,'left')
limit(fx,x,-6,'right')