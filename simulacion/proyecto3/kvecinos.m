function [ yestimado, ytest] = kvecinos(xtraind, xtestd, k)

    n_xtrain = length(xtraind) * length(xtraind{1});
    n_test = length(xtestd) * length(xtestd{1});
    n_caracteristicas = length(xtraind{1}(1, :))

    ytest = zeros(n_test, 1);
    yestimado = zeros(n_test, 1);
    xtrain_completa = zeros(n_xtrain, n_caracteristicas);
    xtest_completa = zeros(n_test, n_caracteristicas);
    genero_completa = zeros(n_xtrain, 1);

    for i = 1 : length(xtraind)
        xtrain = xtraind{i};
        xtest = xtestd{i};

        for j = 1:15
            xtest_completa((i-1)*15 + j, :) = xtest(j, :);
            ytest((i-1)*15 + j, 1) = i;
        end

        for j = 1:length(xtrain)
            xtrain_completa((i-1)*length(xtrain) + j,:) = xtrain(j,:);
            genero_completa((i-1)*length(xtrain) + j) = i;
        end
    end

    %Se ejecuta el metodo k vecinos
    % Kvec = [100 * ones(k, 1), zeros(k, 1)];
    distancias = zeros(n_xtrain, 1);

    for i = 1:n_test
        entrada = xtest_completa(i,:);

        for j = 1:n_xtrain
            muestra = xtrain_completa(j,:);
            distancias(j) = distancia(entrada, muestra);
        end

        % ordenamos el arreglo de distancias de menor a mayor
        distancias_generos = sortrows([ distancias genero_completa ]);

        % revisamos los primeros k del arreglo ordenado.
        % sacamos la moda del arreglo encontrado anteriormente y
        % lo guardamos en yestimado
        kdistancias = distancias_generos(1:k, :);
        yestimado(i) = mode(kdistancias(:, 2));
    end
end
