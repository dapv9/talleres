%Script para pruebas de clasificación Taller No 3. Asignatura Simulación de
%Sistemas, Dpto. Ingeniería de Sistemas, Universidad de Antioquia.

function [Error, IC] = RNA(direccion_archivo, S)

    t = cputime;

    % Lectura del archivo
    Data = dlmread(direccion_archivo);

    % Separación de características y variables a predecir
    X = Data(:,1:end-2); %200*32
    Y = Data(:,end-1:end);%200*2
    %--------------------------------------------------------------------------
    Nd = size(X,1); % Número de muestras en la base de datos   200
    Ntr = ceil(Nd*0.7); % Número de muestras de entrenamiento  140
    Nc =4; %Número de clases
    Rept = 5;
    ErrorTest = zeros(1,Rept);
    TF = {'logsig','tansig'};

    for fold = 1:Rept
        %Separación de los conjuntos de entrenamiento y validación
        vInd = randperm(Nd);
        Xtrain = X(vInd(1:Ntr),:);    %140 * 32
        Xtest = X(vInd(Ntr+1:end),:); %60 *32
        Ytrain = Y(vInd(1:Ntr),:);    % 140 * 2
        Ytest = Y(vInd(Ntr+1:end),:); % 60 * 2

        %----------------------------------------------------------------------
        %------------- Normalización -----------------------------------------
        [XtrainN,mu,sigma] = zscore(Xtrain);
        XtestN = (Xtest - repmat(mu,Nd - Ntr,1))./repmat(sigma,Nd - Ntr,1);

        %----------------------------------------------------------------------
        %------------- Entrenamiento ------------------------------------------
        mired = newff(Xtrain', Ytrain', S, TF, 'trainbfg');
        %%view(mired);
        mired.trainParam.epochs = 50;
        mired.trainParam.goal = 0.01;
        mired =  train(mired, Xtrain', Ytrain');

        %----------------------------------------------------------------------
        %------------- Validación --------------------------------------------
        Yest = sim(mired, XtestN');
        Yest2 = floor(Yest);
        ind =(Yest2 == 0);
        Yest2(ind) = 1;
        Yest3 = obtenerClase(Yest2);

        %-----------------------------------------------------------------------
        %-------------- Cálculo del error -------------------------------------
        Ytest2 = obtenerClase(Ytest');
        MatrizConfusion = zeros(Nc,Nc);

        for i=1:size(Xtest,1)
            MatrizConfusion(Yest3(i),Ytest2(i)) = MatrizConfusion(Yest3(i),Ytest2(i)) + 1;
        end
        ErrorTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
    end

    Error = mean(ErrorTest);
    IC = std(ErrorTest);
    disp(strcat('El error obtenido fue = ', num2str(Error),'+-',num2str(IC)));

    tiempo_ejecucion = cputime - t
end
