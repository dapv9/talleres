%intercu
%programa para efectuar interpolacion cubica por segmentos para datos
% no igualmente espaciados
clear all
%Entrada de informacion
n = input('numero de datos=');
x = input('vector de abscisas=');
y = input('vector de ordenadas=');
W1 = input('segunda derivada al principio=');
WN = input('segunda derivada al final=');

%Calculo de los tamaños de paso
for i = 1:n-1
    h(i) = x(i + 1) - x(i);
end

%calculo de las segundas diferencias divididas
for k = 1:n-2
    b(k) = 6 * ((y(k + 2) - y(k + 1)) / h(k + 1) - (y(k + 1) - y(k)) / h(k));
end

%Sistema de ecuaciones para hallar las segundas derivadas, desde w(2) hasta w(n-1)
% M*W=B
M(1, 1) = 2 * (h(1) + h(2));
M(1, 2) = h(2);
B(1) = b(1) - h(1) * W1;
M(n-2, n-3) = h(n - 2);
M(n-2, n-2) = 2 * (h(n - 2) + h(n - 1));
B(n-2) = b(n - 2) - h(n - 1) * WN;

for k=2:n-3
    M(k, k-1) = h(k);
    M(k, k)=2 * (h(k) + h(k + 1));
    M(k, k+1) = h(k + 1);
    B(k) = b(k);
end

aux = inv(M) * B';
W(1) = W1;
W(n) = WN;

for j = 2:n-1;
    W(j) = aux(j - 1);
end

%Calculo de las primeras derivadas
for k=1:n-1
    U(k)=(y(k+1)-y(k))/h(k)-(h(k)/6)*(2*W(k)+W(k+1));
end

% Calculo de los coeficientes de los polinomios
for k=1:n-1
    c(k,1)=(W(k+1)-W(k))/(6*h(k));
    c(k,2)=W(k)/2-3*x(k)*c(k,1);
    c(k,3)=U(k)-x(k)*W(k)+3*c(k,1)*x(k)^2;
    c(k,4)=-c(k,1)*x(k)^3+(x(k)^2)*W(k)/2-x(k)*U(k)+y(k);
end

c

%Representacion grafica de los polinomios
for i=1:n-1
    t(i,:)=x(i):0.01*h(i):x(i+1);
    p(i,:)=c(i,1).*(t(i,:).^3)+c(i,2).*(t(i,:).^2)+c(i,3).*t(i,:)+c(i,4);
    plot(t(i,:),p(i,:),'k')
    grid on
    hold on
end

plot (x,y,'o')

for j=1:n-1
    for i=1:4
        s(i)=c(j,i);
    end

    disp(strcat('p',num2str(j),'=',poly2str(s,'t')));
end

