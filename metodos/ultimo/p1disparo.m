
clear all

funcion_original = 'D2y=(x-2*Dy+x*y)/x';
r1 = 'y(1)=0';
r2 = 'y(3)=2';

n = 10;
ti = 1;
tf = 3;
p1 = 1;
p2 = 3;
yi = 0;
f = '(t+t*y-2*x)/t';
g = 'x';

b = 2;

% disparo 1
[T, X, Y, b1] = rk4(n, ti, tf, p1, yi, f, g);
% disparo 2
[T, X, Y, b2] = rk4(n, ti, tf, p2, yi, f, g);

% encontramos p3
p = p1 + ((b - b1)/(b2 - b1))*(p2 - p1);

% disparo 3
[T, X, Y, b2] = rk4(n, ti, tf, p, yi, f, g)

[T' X' Y']

grid on
hold on
f_g = plot(T, X)

s = dsolve(funcion_original, r1, r2, 'x');

s = simplify(s);

pretty(s);

syms x
x = 1:0.01:3;
y = eval(s);

%  f_g = ezplot(s);
g_g = plot(x, y)

set(f_g, 'color', 'b');
set(g_g, 'color', 'm');

legend('Metodo del disparo', 'Solucion por dsolve');

%  title(funcion);
%  xlabel('x');
%  ylabel('y');

%  grid on
