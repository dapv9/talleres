

clear all

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
plot(x, y)

title(funcion);
xlabel('x');
ylabel('y');

grid on
