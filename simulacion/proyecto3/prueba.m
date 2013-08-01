function [t] = prueba(direccion_bd)

    t = 0;

    archivos = listar_archivos(direccion_bd);
    n = length(archivos);

    matrices = {};
    n_caracteristicas = 34;
    x = zeros(n*50, n_caracteristicas);
    y = zeros(n*50, 1);

    for i = 1:n
        archivo = archivos(i).name

        M = dlmread(strcat(direccion_bd, archivo));

        in = (i-1)*50 + 1;
        fn = (i*50);
        x(in:fn, :) = M;
        for j = 1:50
	    y((i-1)*50 + j) = i;
        end
    end

    [xtrain, xtest, ytrain, ytest] = obtenerXtrainXtest(x);

    ytrain = y(ytrain);
    ytest = y(ytest);

    % normalizamos
    [xtrain, mu, sigma] = zscore(xtrain);
    xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

    aplicafiltro(xtrain, ytrain)
end
