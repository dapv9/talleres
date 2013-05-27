function [w,Xtest] = ModeloGaussiano(X) %La variable de entrada es la matriz de datos que representa a un género.

%Organizamos los datos de la matriz de manera aleatoria
%Nota esto hay que corregirlo, porque no me esta tomando los valores de
%toda la matriz original
neworder = randperm(size(X,2));



for i=1:size(X,1)
    for j=1:size(X,2)
        A(j)=X(neworder(j));
    end
    Anew(i,:)=A;
end
Anew

%Separamos la matriz con los datos aleatorios en dos matrices, Xtest y
%Xtrain. Xtest=Matriz con menor nùmero de datos, usada para probar; Xtrain,
%Matriz con los datos a los cuales se les aplicará el método de
%clasificación.
tamanofi=size(Anew,1); %variable con el número de filas de la matriz Anew
muestra = tamanofi/2; %Se divide por 2, ya que si lo divido por 10 como 
%como se debería quedaría u index decimal.
%prueba = tamanofi - muestra;
Xtest = [];
Xtrain = [];

%Se crea la matriz Xtrain
for i=1:muestra
    Xtrain(i,:)=Anew(i,:);
end
Xtrain
%Se crea la matriz Xtest
for i=muestra:tamanofi
    Xtest(i,:)=Anew(i,:);
end
Xtest

%Se calculan media y covarianza de la muestra para entrenamiento (Xtrain)
med = mean(Xtrain);
cova = cov(Xtrain);

%Se aplica la formula del método ?¿?¿?¿?¿?¿?, no la comprendo bien.
end
