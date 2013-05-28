function [ yestimado, ytest] = kvecinos(direccion_bd,k)
    archivos = listar_archivos(direccion_bd);

    ytest = zeros(25,1);
    yestimado = zeros(25,1);
    xtrain_completa = zeros(225,32);
    xtest_completa = zeros(25,32);
    genero_completa= zeros(225,1);

    for i = 1 : length(archivos)
        archivo = archivos(i).name;

        strcat(direccion_bd, archivo)

        M = dlmread(strcat(direccion_bd, archivo));

        [xtrain, xtest] = obtenerXtrainXtest(M);

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
    Kvec = [100 * ones(k, 1), zeros(k, 1)];
    distancias = zeros(225, 1);

    for i = 1:25
        entrada = xtest_completa(i,:);

        for l = 1:225
            muestra = xtrain_completa(l,:);
            gen = genero_completa(l);
            distancias(l) = distancia(entrada, muestra);
            for j = 1:k
                if distancias(l) < Kvec(j,1)
                    Kvec(j, 1) = distancias(l);
                    Kvec(j, 2) = gen;
                end
            end
            yestimado(i) = mode(Kvec(:,2));
        end

        %Se haya yestimado con los kvecinos mas cercanos
        %yestimado(i) = mode(Kvec(:,2));
    end
end
