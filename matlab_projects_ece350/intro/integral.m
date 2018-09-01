
syms x
f = x^4;

% integral function is int(params)

intf = int(f)

figure(1), clf, hold on
fplot(f,[-2 2])
fplot(intf, [-2 2])
legend({ ['f(x)=' char(f) ],['\int f=' char(intf)] })


% partial integration

syms x y
fxy = x^2 * y^3;

% compute integral wrt x
int(fxy,x)

% compute integral wrt y
int(fxy,y)

%actual value wrt x at x=4 y = 2.3

a = subs( int(fxy, x), [x y], [4 -2.3] )

% kinda like float precision
vpa(a, 7)

% realistic prob
f = sec(x) * log(tan(x)*sin(x)+sin(x))/ exp(x);

figure(2), clf, hold on
fplot(f, [-20 10], 'linew', 3)

intf = int(f)

% keep computing this integral
% -20 to 10 range
% 100 discrete points of calculations in this range
intvec = linspace(-20,10,100);
intf2 = zeros(size(intvec));

funcf = @(x) sec(x) .* log(tan(x).*sin(x)+sin(x)) ./ exp(x);

for i=1:length(intvec)
    intf2(i) = integral(funcf, intvec(1), intvec(i));
end

plot(intvec, real(intf2), 'linew',3)