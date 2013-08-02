

clear all

funcion = 'D2y=(x-2*Dy+x*y)/x';
r1 = 'y(1)=0';
r2 = 'y(3)=2';

s = dsolve(funcion, r1, r2, 'x');

pretty(s);

syms x
x = 0:0.01:2;
y = eval(s);

%  f_g = ezplot(s);
plot(x, y)

title(funcion);
xlabel('x');
ylabel('y');

grid on
