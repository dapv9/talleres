
clear all

n = 10;
ti = 1;
tf = 3;
p1 = 1;
p2 = 3;
yi = 0;
f = '';
g = 'x';

b = 2;

% disparo 1
[T, X, Y, b1] = rk4(n, ti, tf, p1, yi, f, g);
% disparo 2
[T, X, Y, b2] = rk4(n, ti, tf, p2, yi, f, g);

% encontramos p3
p = p1 + ((b - b1)/(b2 - b1))*(p2 - p1);

% disparo 3
[T, X, Y, b3] = rk4(n, ti, tf, p, yi, f, g);

[T' X' Y']

grid on
hold on
plot(T, X);
