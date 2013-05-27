
clear all

n=15;

g1 = '-(3-cos(y)-z)^(1/2)';
g2 = '((6-x-z)/2)^(1/2)';
g3 = '(3-sin(x+y))/2';

xi=3;
yi=2;
zi=1;

%Se genera una matriz cuya primera fila es la semilla
M(1,1)=xi;
M(1,2)=yi;
M(1,3)=zi;

for k=1:n;
    x=M(k,1);
    y=M(k,2);
    z=M(k,3);
    M(k+1,1)=eval(g1);
    x=M(k+1,1);
    M(k+1,2)=eval(g2);
    y=M(k+1,2);
    M(k+1,3)=eval(g3);
end

M
