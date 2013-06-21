
% Gráfica
x = 0:0.01:2;
y = func(x);
% plot(x, y);
% title('f(x) = 1 + sen(x^2); 0 <= x <= 2');
% xlabel('x');
% ylabel('y');

% tabla de datos
paso = 2.0/6.0;
x = 0:paso:2
y = func(x)

% imprimimos la tabla
disp(' ')
disp(' Tabla ')
disp(' ')
disp('         i         x         y ')
disp(' ')
disp([ [1:length(x)]' x' y'])

% newton-cotes
ncotes(x, y, paso)
