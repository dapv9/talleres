
hold on
grid on

% bruja de agnesi
f='(x^2+4)*y-8';

% folio de Descartes
g='x^3+y^3-6*x*y';

f_g = ezplot(f);
g_g = ezplot(g);

set(f_g, 'color', 'b');
set(g_g, 'color', 'm');

legend('bruja de Agnesi', 'folio de Descartes');

hold off
