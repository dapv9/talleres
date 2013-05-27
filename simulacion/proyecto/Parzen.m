function [yestimado, ytest] = Parzen(direccion_bd,h)
 archivos = dir(direccion_bd);

    xtest_matriz = zeros(5,32,5);
    ytest = zeros(25,1);
    yestimado = zeros(25,1);
    xtest_completa = zeros(25,32);
    indice = 1;
    indice_ytest = 1;
    indice_xtest = 1;

    for i = 1 : length(archivos)
        archivo = archivos(i).name;
        if ~strcmp(archivo, '.') && ~strcmp(archivo, '..')
            strcat(direccion_bd, archivo)

            M = dlmread(strcat(direccion_bd, archivo));

            [media, covarianza, xtest, xtrain] = obtenerXtest(M);

            for j = 1:5
                xtest_completa(indice_xtest,:) = xtest(j,:);
                xtest(indice_xtest) = indice;
            end
            
            xtrain_matriz(:,:,indice) = xtrain;
            
            for j=1:5
                ytest(indice_ytest) = indice;
                indice_ytest = indice_ytest + 1;
            end
            indice = indice +1;
        end
    end
    
    %Calculo del metodo parzen
    for i = 1:25
        xtest =  xtest_completa(i,:);
        f = zeros(5,1);
        
        for j = 1:5            
            suma = 0;
            
            for k = 1:45
                xtrain = xtrain_matriz(k,:,j);
                u = (xtrain - xtest)/h;                
                expon= (-1/2)*(u*u');
                nucleo = (1/2)*exp(expon);
                suma = suma + nucleo;               
            end  
            
            f(j) = (1/(45*h))*suma;
            
        end
         minimo = f(1);
            ind_minimo = 1;

            for k = 2 : 5
                if f(k) > minimo
                    minimo = f(k);
                    ind_minimo = k;
                end
            end
        yestimado(i)= ind_minimo;
    end
end

