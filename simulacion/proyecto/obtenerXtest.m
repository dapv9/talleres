function [media, covarianza, xtest, xtrain] = obtenerXtest( m_orig )

    filas = randperm(size(m_orig, 1));

    filasXtest = filas(1:5);
    filasXtrain = filas(6:50);

    % creamos xtrain
    xtrain = m_orig(filasXtrain, :);
    % creamos xtest
    xtest = m_orig(filasXtest, :);

    media = mean(xtrain);
    covarianza = cov(xtrain);

end
