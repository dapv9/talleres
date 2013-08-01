function [err] = filtro(xtrain, ytrain, xtest, ytest)
    yestimado = classify(xtest, xtrain, ytrain, 'diagQuadratic');
    err = sum((ytest - yestimado).^2)/(2*200);
end
