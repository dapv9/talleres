
clear all

n = 3
f = '1+sin(x^2)';

x = 1;

ec = num2str(eval(sym(f)));

der = f;

for i = 1:n
    der = diff(sym(der));
    r = eval(der) / factorial(i);
    ec = strcat(ec, '+', num2str(r), '*(x-1)^', num2str(i));
end

ec
st = expand(sym(ec))


hold on

x = 0:0.01:2;
y = eval(sym(f));

f_g = plot(x, y);

y = eval(st);

s_g = plot(x, y);
set(s_g, 'color', 'r');


title('Polinomio de Taylor');
xlabel('x');
ylabel('y');

legend('Funcion original', 'Polinomio de Taylor');

grid on
