
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
expand(sym(ec))
