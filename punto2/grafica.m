
hold on
grid on

f='x^2-x+cos(y)-2*y^2+3';
g='sin(x+y)-2*x-4*y^2+9';

f_g = ezplot(f);
g_g = ezplot(g);

set(f_g, 'color', 'b');
set(g_g, 'color', 'm');

% legend('', '', '');

hold off
