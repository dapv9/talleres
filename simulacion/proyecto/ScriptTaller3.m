function [Error, IC] = ScriptTaller3(direccion_archivo)

    t = cputime;

    Data = dlmread(direccion_archivo);

    % Separación de características y variables a predecir
    X = Data(:,1:end-1);
    Y = Data(:,end);
    %--------------------------------------------------------------------------
    Nd = size(X, 1);		% Número de muestras en la base de datos
    Ntr = ceil(Nd*0.7);		% Número de muestras de entrenamiento
    Nc = max(Y);		% Número de clases
    Rept = 10;

    ErrorTest = zeros(1,Rept);
    for fold = 1:Rept
        %Separación de los conjuntos de entrenamiento y validación
        vInd = randperm(Nd);
        Xtrain = X(vInd(1:Ntr),:);
        Xtest = X(vInd(Ntr+1:end),:);
        Ytrain = Y(vInd(1:Ntr));
        Ytest = Y(vInd(Ntr+1:end));
        %----------------------------------------------------------------------
        %------------- Normalización ------------------------------------------
        [XtrainN,mu,sigma] = zscore(Xtrain);
        XtestN = (Xtest - repmat(mu,Nd - Ntr,1))./repmat(sigma,Nd - Ntr,1);
        %----------------------------------------------------------------------
        %------------- Entrenamiento ------------------------------------------

        Modelo = EntrenarGMM(XtrainN,Ytrain,Nc,3);

        %----------------------------------------------------------------------
        %------------- Validación ---------------------------------------------

        Yest = ValidarGMM(Modelo,XtestN);

        %-----------------------------------------------------------------------
        %-------------- Cálculo del error --------------------------------------
        MatrizConfusion = zeros(Nc,Nc);

        for i=1:size(Xtest,1)
            MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
        end

        ErrorTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
    end

    Error = mean(ErrorTest);
    IC = std(ErrorTest);
    strcat('El error obtenido fue = ', num2str(Error), '+-', num2str(IC))

    tiempo_ejecucion = cputime - t
end
