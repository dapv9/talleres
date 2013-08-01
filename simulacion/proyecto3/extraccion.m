function [t] = extraccion(direccion_bd)

    t = 0;
    h = 1;
    k = 3;

    n_caracteristicas = 32;
    caracteristicas = 1:32;

    % leemos la base de datos
    archivos = listar_archivos(direccion_bd);
    n = length(archivos);
    filas = n*50;
    p = 0.7;

    matriz = {};

    for i = 1:n
        archivo = archivos(i).name

        M = dlmread(strcat(direccion_bd, archivo));
        matriz{i} = M;

        for j = 1:50
            y((i-1)*50 + j) = i;
        end
    end

    % aplicamos sequentialfs
    mb = zeros(10, 32);
%      for i = 1:10
%          i
    xtrain = zeros(140, 32);
    ytrain = zeros(140, 1);

    xtest = zeros(60, 32);
    ytest = zeros(60, 1);

    for j = 1:length(matriz)
	m = matriz{j};
	l = randperm(50);
	smxtr = m(l(1:35),:);
	smyte = m(l(36:50), :);

	xtrain((j-1)*35 + 1: j*35, :) = smxtr;
	for k = 1:35
	    ytrain((j-1)*35+k) = j;
	end

	xtest((j-1)*15 + 1: j*15, :) = smyte;

	for k = 1:15
	    ytest((j-1)*15+k) = j;
	end
    end

%      [xtrain70, xtest70, ytrain70, ytest70] = obtenerXtrainXtest( xtrain );
%      ytrain70 = ytrain(ytrain70);
%      ytest70 = ytrain(ytest70);
%  
%      % normalizamos
%      [xtrain70, mu, sigma] = zscore(xtrain70);
%      xtest70 = (xtest70-repmat(mu,size(xtest70,1),1))./repmat(sigma,size(xtest70,1),1);

    dat.X = xtrain';
    dat.y = ytrain';
    dat_test.X = xtest'
    dat_test.y = ytest'

    a_eff = zeros(n_caracteristicas-1, 1);

    for i=1:(n_caracteristicas-1)

	modelo = lda(dat, i);
	xtrain_lda = linproj(dat, modelo);
	xtest_lda = linproj(dat_test, modelo);

	xtrain_r = xtrain_lda.X';
	ytrain_r = xtrain_lda.y';
	xtest_r = xtest_lda.X';
	ytest_r = xtest_lda.y';

	xtraind = obtenerDiccionario(xtrain_r, ytrain_r, n);
	xtestd = obtenerDiccionario(xtest_r, ytest_r, n);

        [yestimado, ytest] = parzen(xtraind, xtestd, h);
        [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
        ef_parzen = eficiencia

        [yestimado, ytest] = dist_gauss(xtraind, xtestd);
        [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
        ef_diss_gauss = eficiencia

	t = cputime;
        [yestimado, ytest] = kvecinos(xtraind, xtestd, k);
        [confucion, eficiencia] = MatrizConfusion(ytest, yestimado);
        ef_kvecinos = eficiencia
        tiempo_kvecinos = cputime - t
;
	a_eff(i) = eficiencia;
    end

    ind_max = 1;
    for i = 2:(n_caracteristicas-1)
	if a_eff(ind_max) < a_eff(i)
	    ind_max = i;
	end
    end
    a_eff(ind_max)
end
