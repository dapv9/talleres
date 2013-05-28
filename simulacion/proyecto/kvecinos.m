function [ ytest, yestimado] = kvecinos(direccion_bd,k)
    archivos = dir(direccion_bd);

    xtest_matriz = zeros(5,32,5);
    ytest = zeros(25,1);
    yestimado = zeros(25,1);
    xtrain_completa = zeros(225,32);
    xtest_completa = zeros(25,32);
    genero_completa= zeros(225,1);
    contador_genero = 1;
    indice = 1;
    indice_ytest = 1;
    indice_xtrain = 1;

    for i = 1 : length(archivos)
        archivo = archivos(i).name;
        if ~strcmp(archivo, '.') && ~strcmp(archivo, '..')
            strcat(direccion_bd, archivo)

            M = dlmread(strcat(direccion_bd, archivo));

            [media, cov, xtest, xtrain] = obtenerXtest(M);

%             xtest_matriz(:,:,indice) = xtest;
%             xtrain_matriz(:,:,indice)= xtrain;

            for j = 1:5
                xtest_completa(indice_ytest,:) = xtest(j,:);
                ytest(indice_ytest) = indice;
            end

            for j = 1:45
                xtrain_completa(indice_xtrain,:) = xtrain(j,:);
                genero_completa(contador_genero) = indice;
                contador_genero = contador_genero + 1;
                indice_xtrain = indice_xtrain + 1;
            end

            indice = indice +1;
        end
    end

    %Se ejecuta el metodo k vecinos
    Kvec = [100*ones(k,1),zeros(k,1)];
    distancias = zeros(225,1);
    contador = 1;

    for i = 1:25
        entrada = xtest_completa(i,:);

        for l = 1:225
            muestra = xtrain_completa(l,:);
            gen = genero_completa(l);
            % entrada = xtest_matriz(m,:,i);
            distancias(l)=sqrt(sum((muestra-entrada).^2));
            for j = 1:k
                if distancias(l) < Kvec(j,1)
                    Kvec(j,1) = distancias(l);
                    Kvec(j,2) = gen;
                    % break
                end
            end
            yestimado(contador) = mode(Kvec(:,2));
        end

        %Se haya yestimado con los kvecinos mas cercanos
        %yestimado(contador) = mode(Kvec(:,2));
        contador = contador + 1;
    end
end

