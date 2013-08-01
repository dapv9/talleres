function [t] = seleccion70(x, y)

%      n_subconjuntos = 5;
%      n_sub = length(x(:,1)) / n_subconjuntos;
%  
%      for i = 1:n_subconjuntos
%          posicion = ((i - 1) * n_sub);
%  
%          m = x(posicion+1:posicion+n_sub, :);

%          [xtrain, xtest, ytrain, ytest] = obtenerXtrainXtest(m);
%          ytrain = y(ytrain);
%          ytest = y(ytest);

%          % normalizamos
%          [xtrain, mu, sigma] = zscore(xtrain);
%          xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);
%  
%          sequentialfs(@filtro, xtrain, ytrain)
%      end

    [xtrain, xtest, ytrain, ytest] = obtenerXtrainXtest(x);
    ytrain = y(ytrain);
    ytest = y(ytest);

    % normalizamos
    [xtrain, mu, sigma] = zscore(xtrain);
    xtest = (xtest-repmat(mu,size(xtest,1),1))./repmat(sigma,size(xtest,1),1);

    sequentialfs(@filtro, xtrain, ytrain)
end
