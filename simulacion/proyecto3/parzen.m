function [yestimado, ytest] = parzen(xtrain_d, xtestd, h)

    n = length(xtestd);
    lxt = length(xtestd{1});
    n_caracteristicas = length(xtrain_d{1}(1,:));
    
    ytest = zeros(lxt*n, 1);
    yestimado = zeros(lxt*n, 1);
    xtest_c = zeros(lxt*n, n_caracteristicas);

    for i = 1:length(xtestd)
        xtest = xtestd{i};
        for j = 1:lxt
            xtest_c((i-1)*lxt + j,:) = xtest(j, :);
            ytest((i-1)*lxt + j) = i;
        end
    end

    % ciclo para los xtest
    for i = 1:length(xtest_c)
        xtest = xtest_c(i,:);

        f = zeros(5, 1);
        % ciclo para encontrar la probabilidad de que sea de cada genero
        for j = 1:length(xtrain_d)
            xtrain = xtrain_d{j};

            % ciclo para el calculo de la sumatoria de los kernel
            suma_k = 0;
            for w = 1:length(xtrain)
                suma_k = suma_k + kernel(norm(xtrain(w, :) - xtest) / h);
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
