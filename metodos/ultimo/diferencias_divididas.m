%Programa para resolver el problema con valor en la frontera
% y''+p(x)y'+q(x)y=r(x) con las condiciones y(a)=alfa,y(b)=beta
%con N intervalos, usando el metodo de las diferencias divididas
%Entrada de informacion

clear all

n=input('numero de intervalos= ');
a=input('abscisa inicial= ');
b=input('abscisa final= ');
alfa=input('ordenada inicial= ');
beta=input('ordenada final= ');
h=(b-a)/n;

% Se genera el vector de abscisas
for i=1:n+1
    xe(i)=a+(i-1)*h;
end

p=input('entre la funcion p(x)=');
q=input('entre la funcion q(x)=');
r=input('entre la funcion r(x)=');

for i=1:n+1
    x=xe(i);
    P(i)=eval(p);
    Q(i)=eval(q);
    R(i)=eval(r);
end

ye(1)=alfa;
ye(n+1)=beta;
%Para hallar las ordenadas resulta un sistema
%tridiagonal de ecuaciones
[P Q R];
m=n-1;
A(1,1)=h^2*Q(2)-2;
A(1,2)=1+0.5*h*P(2);
B(1)=h*h*R(2)-alfa*(1-0.5*h*P(2));
[A(1,1) A(1,2) B(1)];
A(m,m-1)=1-0.5*h*P(n);
A(m,m)=h*h*Q(n)-2;
B(m)=h*h*R(n)-beta*(1+0.5*h*P(n));
[A(m,m-1) A(m,m) B(m)];

for i=2:m-1
A(i,i-1)=1-0.5*h*P(i+2);
A(i,i)=h*h*Q(i+2)-2;
A(i,i+1)=1+0.5*h*P(i+2);
end

for i=2:m-1
    B(i)=h*h*R(i+2);
end

z=inv(A)*B';

for k=2:n
    ye(k)=z(k-1);
end

[xe' ye']
plot(xe,ye)
grid on
