
clear all

% Gráfica
f = '1 + sin(x.^2)';
x = 0:0.01:2;
y = eval(f);


% Gráfica de la función completa
subplot(2, 1, 1);

f_g = ezplot(f);
set(f_g, 'color', 'r');

title('f(x) = 1 + sen(x^2)');
xlabel('x');
ylabel('y');

grid on


% Gráfica de la función en la región de interes
subplot(2, 1, 2);

plot(x, y);

title('f(x) = 1 + sen(x^2); 0 <= x <= 2');
xlabel('x');
ylabel('y');

grid on
