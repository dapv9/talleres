
% Gráfica
x = 0:0.01:2;
y = func(x);
% plot(x, y);
% title('f(x) = 1 + sen(x^2); 0 <= x <= 2');
% xlabel('x');
% ylabel('y');

% tabla de datos
paso = 2.0/6.0;
x = 0:paso:2;
y = func(x);

% imprimimos la tabla
disp(' ')
disp(' Tabla ')
disp(' ')
disp('         i         x         y ')
disp(' ')
disp([ [1:length(x)]' x' y'])

% newton-cotes
%  ncotes(x, y, paso)

% interpolación cúbica

% segunda derivada
syms xx
der1 = diff(diff(1+sin(xx^2), xx), xx);

% segunda derivada evaluada en 0
xx = 0;
d1 = eval(der1);
% segunda derivada evaluada en 2
xx = 2;
dn = eval(der1);

coeficientes = icubica(x, y, d1, dn)

% calculamos la integral
integral = 0;
for i = 1:n-1
    ec = '0';
    for j = 1:4
        ec = strcat(num2str(coeficientes(i, j)), '*x^', num2str(4-j), ' + ', ec);
    end
    % integral = integral + int(poly2str(coeficientes(i,:), 'xx'), xx, x(i), x(i+1));
    integral = integral + int(sym(ec), x(i), x(i+1));
    % poly2str(coeficientes(i,:), 'x')
end

integral
