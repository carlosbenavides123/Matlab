
% derivatives

syms x 
f = sin(x)
% derivative of f...df , function is diff(f)
df = diff(f)

% plot the function and derivate
figure(1), clf
subplot(211)
fplot(f), hold on
fplot(df)

%legend

legend([ 'f(x)= ' char(f)], ['df(x)=' char(df)]) 

a = pi/3
% substitute into f the value of a
subs(f,a)
subs(df,a)

% same thing numberic variables

t = -5:.001:5;
q = sin(t)
dq = diff(q)*1000;
subplot(212)
plot(t,q), hold on
plot(t(1:end-1),dq) 
legend([ 'f(q)', 'dq'])

% nother one

f = ( exp(sin(x))^x ) / ( 3^x*cos(x) );

df = diff(f);

pretty(df)

figure(2), clf
fplot(f, 'linew', 2), hold on
fplot(df, 'linew',2)
legend(['f(x)', 'df'])
set(gca,'ylim',[-300 300])