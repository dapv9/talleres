
% Cuadratura Gaussiana para n=5,6
clear all

% Se entra la matriz de las raices

% Número de intervalos
% 4 intervalos para 5 puntos
n_5 = 4;
% 5 intervalos para 6 puntos
n_6 = 5;

% Calculamos los tamaños del paso
h_5 = 2.0/n_5;
h_6 = 2.0/n_6;

% Establecemos los valores de r y c para 5 y 6 puntos.
r = [0:h_5:2 0;     % 5 puntos
     0:h_6:2  ];    % 6 puntos

c = [0.2369   0.4786   0.5689   0.4786   0.2369   0;        % 5 puntos
     0.1713   0.3608   0.4679   0.4679   0.3608   0.1713];  % 6 puntos

% Función a evaluar
f = '1 + sin(x.^2)';

I_5 = 0;
I_6 = 0;

for i = 1:n_6
    if i < 6
        x = r(1, i);
        s = eval(f);
        I_5 = I_5 + s * c(1, i);
    end

    x = r(2, i);
    s = eval(f);
    I_6 = I_6 + s * c(2, i);
end

I_5
I_6
