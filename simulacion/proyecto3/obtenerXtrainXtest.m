function [xtrain, xtest, ytrain, ytest] = obtenerXtrainXtest( m_orig )
    n = size(m_orig, 1);
    div = int32(n * 0.3);

    filas = randperm(n)';

    ytest = filas(1:div);
    ytrain = filas(div+1:n);

    % creamos xtrain
    xtrain = m_orig(ytrain,:);

    % creamos xtest
    xtest = m_orig(ytest,:);
end
