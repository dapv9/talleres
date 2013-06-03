function [ y_estimado ] = Gauss(xtrain, xtest, ytrain, num_clases)

y_estimado =[];
celda_clases= {};

%%% Se sacan matrices de entrenamiento por clase %%%

for i= 1: num_clases
    matriz_clase= [];
    for j= 1: size(ytrain,1)
       clase= ytrain(j);
       if (i==clase)
           matriz_clase = [matriz_clase; xtrain(j,:)];
       end
    end
    celda_clases{i}= matriz_clase;
end

      
       for k=1:size(xtest,1)
           
           vector_probabilidad=[];
           vectorxts = xtest(k,:);
       
           for c=1:num_clases
           
           matriz_clase= celda_clases{c};
           vector_media = mean(matriz_clase);
           matriz_covarianza = cov(matriz_clase);
           d = size(matriz_covarianza,1);
           
           f1 = 1/(2*pi)^(d/2)*(det(matriz_covarianza)^0.5);
           f2 = (-0.5*(vectorxts-vector_media));
           f3 = inv(matriz_covarianza);
           f4 = f2*f3;
           f5 = f4*(vectorxts-vector_media)';
           probabilidad = f1*exp(f5);                         %%%Función de densidad
           vector_probabilidad(c)= probabilidad;
           end
       [maximo, indice]= max(vector_probabilidad);
       y_estimado(k)= indice;
       end
       
       disp(y_estimado);
end

