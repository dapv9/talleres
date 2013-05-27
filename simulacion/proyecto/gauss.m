function [yestimado, ytest] = gauss( direccion_bd )

    archivos = dir(direccion_bd);

    xtest_matriz = zeros(5,32,5);
    ytest = zeros(25,1);
    yestimado = zeros(25,1);
    media_matriz = zeros(5, 32);
    covarianza_matriz = ones(32, 32, 5);
    indice = 1;
    indice_ytest = 1;

    for i = 1 : length(archivos)
        archivo = archivos(i).name;
        if ~strcmp(archivo, '.') && ~strcmp(archivo, '..')
            strcat(direccion_bd, archivo)

            M = dlmread(strcat(direccion_bd, archivo));

            [media, covarianza, xtest, xtrain] = obtenerXtest(M);

            xtest_matriz(:,:,indice) = xtest;
            for j=1:5
                ytest(indice_ytest) = indice;
                indice_ytest = indice_ytest + 1;
            end
            media_matriz(indice,:) = media;
            covarianza_matriz(:,:,indice) = covarianza;

            indice = indice +1;
        end
    end
    contador =1;
    for i=1: 5
        
        xtest = xtest_matriz(:,:,i);
        
        n = zeros(5);
        
        for j=1: 5
            for k = 1:5
                term1 = (xtest(j,:)' - media_matriz(k,:)')' * pinv(covarianza_matriz(:,:,k));
                term2 = (xtest(j,:)' - media_matriz(k,:)');
                expon = term1 * term2;
                term3 = ( 1 / (2*pi)^16 * det(covarianza_matriz(:,:,k))^(1/2) );
                n(k) =   term3 * exp((-1/2)*expon);
            end
            
            minimo = n(1);
            ind_minimo = 1;

            for k = 2 : 5
                if n(k) > minimo
                    minimo = n(k);
                    ind_minimo = k;
                end
            end
            
            yestimado(contador) = ind_minimo;
            contador = contador + 1;
        end
    end

end
