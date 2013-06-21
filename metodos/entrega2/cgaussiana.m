
% Cuadratura Gaussiana para n=2,3,4,5,6
clear all

% Se entra la matriz de las raices
%  r = [0       0       0      0      0       0;
%  -0.5774  0.5774  0      0      0       0;
%  -0.7746  0       0.7746 0      0       0;
%  -0.8611 -0.34    0.34   0.8611 0       0;
%  -0.9062 -0.5385  0      0.5385 0.9062  0;
%  -0.9325 -0.6612 -0.2386 0.2386 0.6612 0.9325];

% Número de intervalos
% 4 intervalos para 5 puntos
n_5 = 4;
% 5 intervalos para 6 puntos
n_6 = 5;

% Calculamos el tamaño del paso
h_5 = 2.0/n_5;
h_6 = 2.0/n_6;

% Encontramos los valores de X y Y
r = [0:h_5:2 0;     % 5 puntos
     0:h_6:2  ];    % 6 puntos

c = [0.2369   0.4786   0.5689   0.4786   0.2369   0;        % 5 puntos
     0.1713   0.3608   0.4679   0.4679   0.3608   0.1713];  % 6 puntos

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
