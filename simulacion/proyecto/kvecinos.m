function [ yestimado, ytest] = kvecinos(direccion_bd,k)
    archivos = listar_archivos(direccion_bd);

    ytest = zeros(25,1);
    yestimado = zeros(25,1);
    xtrain_completa = zeros(225,32);
    xtest_completa = zeros(25,32);
    genero_completa = zeros(225,1);

    for i = 1 : length(archivos)
        archivo = archivos(i).name;

        % strcat(direccion_bd, archivo)

        M = dlmread(strcat(direccion_bd, archivo));

        [xtrain, xtest] = obtenerXtrainXtest(M);

        % normalizacion
        [xtrain, mu, sigma] = zscore(xtrain);
        xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

        for j = 1:5
            xtest_completa((i-1)*5 + j,:) = xtest(j,:);
            ytest((i-1)*5 + j, 1) = i;
        end

        for j = 1:45
            xtrain_completa((i-1)*45 + j,:) = xtrain(j,:);
            genero_completa((i-1)*45 + j) = i;
        end
    end

    %Se ejecuta el metodo k vecinos
    % Kvec = [100 * ones(k, 1), zeros(k, 1)];
    distancias = zeros(225, 1);

    for i = 1:25
        entrada = xtest_completa(i,:);

        for j = 1:225
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
