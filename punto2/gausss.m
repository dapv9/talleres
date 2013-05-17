


% Sistemas no lineales 2x2. Solución iterativa.
clear all
% Solucion de un sistema de orden dos diagonalmente dominante
% x=g1(x,y); y=g2(x,y);
n=10;

g1='x^2-x+cos(y)-2*y^2+3';
g2='sin(x+y)-2*x-4*y^2+9';
% g3=input('g3(x,y)=');
xi = 1.41421356237;
yi = 1.73205080757;


% Se genera una matriz M cuya primera fila es la semilla
M(1,1)=xi;
M(1,2)=yi;

for k=1:n;
    x=M(k,1);
    y=M(k,2);
    M(k+1,1)=eval(g1);
    x=M(k+1,1);
    M(k+1,2)=eval(g2);
end

M

