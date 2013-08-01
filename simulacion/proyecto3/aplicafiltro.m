function [model] = aplicafiltro(xtrain, ytrain)
    model = sequentialfs(@filtro, xtrain, ytrain);
end
