
clear all
% Solucion de un sistema de orden tres diagonalmente dominante
% x=g1(y,z); y=g2(x,z); z=g3(x,y)
% n número de iteraciones
% Todas las semillas se inicializan de acuerdo con la recomendación previa

n=15;

g1='x^2-x+cos(y)-2*y^2+3';
g2='sin(x+y)-2*x-4*y^2+9';
% g3=input('g3(x,y)=');
xi=-4;
yi=4;

% zi=input('zinicial=');

% Se genera una matriz M cuya primera fila es la semilla
M(1,1)=xi;
M(1,2)=yi;
% M(1,3)=zi;

for k=1:n;
    x=M(k,1);
    y=M(k,2);
    % z=M(k,3);
    M(k+1,1) = eval(g1);
    x=M(k+1,1);
    M(k+1,2) = eval(g2);
    % y=M(k+1,2);
    % M(k+1,3) = eval(g3);
end

M
