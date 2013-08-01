function [yestimado, ytest] = dist_gauss( xtraind, xtestd )

    n_generos = length(xtraind);
    
    n_xtest = length(xtestd{1}) * length(xtestd);

    d = length(xtraind{1}(1,:));
    y_estimado = zeros(n_xtest, 1);
    medias = zeros(length(xtraind), d);
    covarianzas = {};

    yestimado = zeros(n_xtest, 1);
    ytest = zeros(n_xtest, 1);

    for i = 1:length(xtraind)
        xtrain = xtraind{i};

        for j = 1:length(xtestd{1})
            ytest((i-1)*length(xtestd{1}) + j, 1) = i;
        end

        medias(i,:) = mean(xtrain);
        covarianzas{i} = cov(xtrain);
    end

    % contador  = 1;

    % bucle para los géneros.
    for i = 1: n_generos

        xtest = xtestd{i};

        n = zeros(length(xtraind));

        % bucle para las canciones.
        for j = 1:length(xtest)
            % bucle para las medias y convarianzas.
            for k = 1:n_generos
                term1 = (xtest(j,:) - medias(k,:)) * pinv(covarianzas{k});
                term2 = (xtest(j,:) - medias(k,:))';
                expon = term1 * term2;
                term3 = ( 1 / ((2*pi)^(d/2) * det(covarianzas{k})^(1/2)) );
                n(k) = term3 * exp((-0.5)*expon);
            end

            maximo = n(1);
            ind_maximo = 1;

            for k = 2:length(xtraind)
                if n(k) > maximo
                    maximo = n(k);
                    ind_maximo = k;
                end
            end

            yestimado((i-1)*length(xtest) + j, 1) = ind_maximo;
        end
    end
end
