
% complex numbers

a = 2; % real
b = -3; % complex/imaginary

% build ins
c1 = complex( a,b ) % 2 - 3i

% or do it by hand

c2 = a + b*1i; % 2 - 3i

% 1i is a const buildin

% euler

m = 3; % magnitude / distance
p = 2 * pi/3; % phase angle


% Eulers formula and its cis/ cosine and imaginary euivalent

e1 = m*exp( 1i * p);
% same
e2 = m *( cos(p) + 1i*sin(p) );

% get magnitude + phase from real + imaginary

m1 = sqrt( real(e1)^2 + imag(e1^2) ); % 3

p1 = atan( imag(e1) / real(e1) )
% or
p2 = angle( e1 )
