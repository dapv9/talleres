function [yestimado, ytest] = parzen(direccion_bd, h)
    archivos = listar_archivos(direccion_bd);

    ytest = zeros(25, 1);
    yestimado = zeros(25, 1);
    xtest_d = {};
    xtrain_d = {};
%      xtest_completa = zeros(25, 32);

    for i = 1:length(archivos)
        archivo = archivos(i).name;
        strcat(direccion_bd, archivo)

        M = dlmread(strcat(direccion_bd, archivo));

        [xtrain, xtest] = obtenerXtrainXtest(M);

        % normalizamos
        [xtrain, mu, sigma] = zscore(xtrain);
        xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

        xtest_d{i} = xtest;
        xtrain_d{i} = xtrain;

        for j = 1:5
            ytest((i-1)*5 + j) = i;
        end

    end


    % ciclo para los géneros
    for i = 1:5
        xtest = xtest_d{i};

        % ciclo para las canciones
        for j = 1:5

	    f = zeros(5, 1);
	    % ciclo para encontrar la probabilidad de que sea de cada genero
	    for ii = 1:5
		xtrain = xtrain_d{ii};

		% ciclo para el calculo de la sumatoria de los kernel
		suma_k = 0;
		for w = 1:45
		    suma_k = suma_k + kernel((xtrain(w) - xtest) / h);
		end

		f(ii) = (1/(45 * h)) * suma_k;
	    end

	    maximo = f(1);
            ind_maximo = 1;

            for w = 2:5
                if f(w) > maximo
                    maximo = f(w);
                    ind_maximo = w;
                end
            end

            yestimado((i-1)*5 + j, 1) = ind_maximo;
            (i-1)*5 + j

        end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
%          f = zeros(5, 1);
%  
%          for j = 1:5
%              suma = 0;
%  
%              for k = 1:45
%                  xtrain = xtrain_matriz(k,:,j);
%                  u = (xtrain - xtest)/h;
%                  expon = (-1/2)*(u*u');
%                  nucleo = (1/2)*exp(expon);
%                  suma = suma + nucleo;
%              end
%  
%              f(j) = (1/(45*h))*suma;
%          end
%  
%          maximo = f(1);
%          ind_maximo = 1;
%  
%          for k = 2 : 5
%              if f(k) > maximo
%                  maximo = f(k);
%                  ind_maximo = k;
%              end
%          end
%          yestimado(i) = ind_maximo;
    end
end
