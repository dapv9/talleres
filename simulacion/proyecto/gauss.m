function [yestimado, ytest] = gauss( direccion_bd )

    archivos = listar_archivos(direccion_bd);
    n_generos = length(archivos);

    d = 32;
    xtests = {};
    y_estimado = zeros(25,1);
    medias = zeros(5, 32);
    covarianzas = {};

    yestimado = zeros(25, 1);
    ytest = zeros(25, 1);

    for i = 1 : length(archivos)
        archivo = archivos(i).name;
        % strcat(direccion_bd, archivo)

        % leemos la matriz "i" de la base de datos.
        M = dlmread(strcat(direccion_bd, archivo));

        % obtenemos xtrain y xtest
        [xtrain, xtest] = obtenerXtrainXtest(M);

        % normalizamos
        [xtrain, mu, sigma] = zscore(xtrain);
        xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

        xtests{i} = xtest;
        for j = 1:5
            ytest((i-1)*5 + j, 1) = i;
        end

        medias(i,:) = mean(xtrain);
        covarianzas{i} = cov(xtrain);
    end

    % contador  = 1;

    % bucle para los géneros.
    for i = 1: 5

        xtest = xtests{i};

        n = zeros(5);

        % bucle para las canciones.
        for j = 1:5
            % bucle para las medias y convarianzas.
            for k = 1:5
                term1 = (xtest(j,:) - medias(k,:)) * pinv(covarianzas{k});
                term2 = (xtest(j,:) - medias(k,:))';
                expon = term1 * term2;
                term3 = ( 1 / ((2*pi)^(d/2) * det(covarianzas{k})^(1/2)) );
                n(k) = term3 * exp((-0.5)*expon);
            end

            maximo = n(1);
            ind_maximo = 1;

            for k = 2:5
                if n(k) > maximo
                    maximo = n(k);
                    ind_maximo = k;
                end
            end

            yestimado((i-1)*5 + j, 1) = ind_maximo;
        end
    end

end
