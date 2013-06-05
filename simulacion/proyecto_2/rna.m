function [Error, IC] = rna(direccion_archivo)

    Data = dlmread(direccion_archivo);

    % Separación de características y variables a predecir
    X = Data(:,1:end-2);	% 200x32
    Y = Data(:,end-1:end);	% 200x2

    %--------------------------------------------------------------------------
    Nd = size(X, 1);		% Número de muestras en la base de datos
    Ntr = ceil(Nd*0.7);		% Número de muestras de entrenamiento
    Nc = 4;			% Número de clases
    Rept = 10;
    ErrorTest = zeros(1,Rept);
    TF = {'tansig', 'tansig'};

%      for fold = 1:Rept
        % Separación de los conjuntos de entrenamiento y validación
        vInd = randperm(Nd);
        Xtrain = X(vInd(1:Ntr),:);	% 140x32
        Xtest = X(vInd(Ntr+1:end),:);	% 60x32
        Ytrain = Y(vInd(1:Ntr), :);	% 140x2
        Ytest = Y(vInd(Ntr+1:end), :);	% 60x2

        %----------------------------------------------------------------------
        %------------- Normalización ------------------------------------------
        [XtrainN,mu,sigma] = zscore(Xtrain);
        XtestN = (Xtest - repmat(mu,Nd - Ntr,1))./repmat(sigma,Nd - Ntr,1);

        %----------------------------------------------------------------------
        %------------- Entrenamiento ------------------------------------------
        mired = newff(Xtrain', Ytrain', 64, TF, 'trainbfg');
        view(mired);
        mired.trainParam.epochs = 50;
        mired.trainParam.goal = 0.01;
        
        mired = train(mired, Xtrain', Ytrain');

        %----------------------------------------------------------------------
        %------------- Validación ---------------------------------------------
%          Yest = ValidarGMM(Modelo,XtestN);

        %-----------------------------------------------------------------------
        %-------------- Cálculo del error --------------------------------------
%          MatrizConfusion = zeros(Nc,Nc);
%  
%          for i=1:size(Xtest,1)
%              MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
%          end
%  
%          ErrorTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
%      end

    Error = 0;
    IC = 0;
%      Error = mean(ErrorTest);
%      IC = std(ErrorTest);
%      strcat('El error obtenido fue = ', num2str(Error), '+-', num2str(IC))

end
