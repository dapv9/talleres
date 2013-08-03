
clear all

n = 10;
ti = 1;
tf = 3;
p1 = 1;
p2 = 2;
yi = 3;
f = '(4-3*t*x-2*y)/(t^2)';
g = 'x';

b = 3;

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

funcion = 'D2y=(4-3*x*Dy-2*y)/(x^2)';
r1 = 'y(1)=3';
r2 = 'y(3)=-1';

s = dsolve(funcion, r1, r2, 'x');

s = simplify(s);

pretty(s);

syms x
x = 1:0.01:3;
y = eval(s);

%  f_g = ezplot(s);
plot(x, y);

title(funcion);
xlabel('x');
ylabel('y');

grid on
