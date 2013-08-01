function [t] = seleccion(direccion_bd)

    h = 4;
    k = 4;

    n_caracteristicas = 32;
    caracteristicas = 1:32;

    % leemos la base de datos
    archivos = listar_archivos(direccion_bd);
    n = length(archivos);
    filas = n*50;
    p = 0.7;

    matriz = {};

    for i = 1:n
        archivo = archivos(i).name

        M = dlmread(strcat(direccion_bd, archivo));
        matriz{i} = M;

        for j = 1:50
            y((i-1)*50 + j) = i;
        end
    end

    % aplicamos sequentialfs
    mb = zeros(10, 32);
    for i = 1:2
        i
        xtrain = zeros(140, 32);
        ytrain = zeros(140, 1);

        xtest = zeros(60, 32);
        ytest = zeros(60, 1);

        for j = 1:length(matriz)
            m = matriz{j};
            l = randperm(50);
            smxtr = m(l(1:35),:);
            % smyte = m(l(36:50, :);

            xtrain((j-1)*35 + 1: j*35, :) = smxtr;
            for k = 1:35
                ytrain((j-1)*35+k) = j;
            end
            % xtest((j-1)*15 + 1: j*15, :) = smyte;
        end

        % normalizamos
        [xtrain, mu, sigma] = zscore(xtrain);
        % xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

        mb(i, :) = sequentialfs(@filtro, xtrain, ytrain);
    end

    % de la matriz resultante obtenemos los nuevos xtrain y
    % aplicamos los algoritmos vistos en clase
    for i = 1:2
        xtraind = {};
        xtestd = {};
        for j = 1:length(matriz)
            m = matriz{j};
            [xtrain, xtest] = obtenerXtrainXtest(m);

            % normalizamos
            [xtrain, mu, sigma] = zscore(xtrain);
            xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

            xtraind{j} = xtrain(:, mb(i, :) == 1);
            xtestd{j} = xtest(:, mb(i, :) == 1);
        end

        caract = caracteristicas(mb(i, :)==1)

%          [yestimado, ytest] = parzen(xtraind, xtestd, h);
%          [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
%          ef_parzen = eficiencia
%  
%          [yestimado, ytest] = dist_gauss(xtraind, xtestd);
%          [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
%          ef_diss_gauss = eficiencia

        [yestimado, ytest] = kvecinos(xtraind, xtestd, k);
        [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
        ef_kvecinos = eficiencia
    end
end
