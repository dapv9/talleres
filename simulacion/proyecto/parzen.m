function [yestimado, ytest] = parzen(direccion_bd, h)
    archivos = listar_archivos(direccion_bd);

    ytest = zeros(25, 1);
    yestimado = zeros(25, 1);
    % todos los xtest
    xtest_c = zeros(25, 32);
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

        xtrain_d{i} = xtrain;

        for j = 1:5
            xtest_c((i-1)*5 + j,:) = xtest(j, :);
            ytest((i-1)*5 + j) = i;
        end

    end


    % ciclo para los xtest
    for i = 1:25
        xtest = xtest_c(i,:);

        f = zeros(5, 1);
        % ciclo para encontrar la probabilidad de que sea de cada genero
        for j = 1:5
            xtrain = xtrain_d{j};

            % ciclo para el calculo de la sumatoria de los kernel
            suma_k = 0;
            for w = 1:45
                suma_k = suma_k + kernel((xtrain(w, :) - xtest) / h);
            end

            f(j) = (1/(45 * h)) * suma_k;
        end

        maximo = f(1);
        ind_maximo = 1;

        for w = 2:5
            if f(w) > maximo
                maximo = f(w);
                ind_maximo = w;
            end
        end

        yestimado(i, 1) = ind_maximo;
    end
end