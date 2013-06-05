function [ eficiencia ] = fold( direccion_bd, h, k)
    eficiencia = zeros(3, 1);
    media_eficiencia = zeros(10, 3);

    for i = 1:10
        disp(strcat('Iteracción:', num2str(i)));
        [Yestimado, Ytest] = dist_gauss(direccion_bd);
        [confucion, eficiencia] = MatrizConfusion(Ytest, Yestimado);
        media_eficiencia(i, 1) = eficiencia;

        [Yestimado,Ytest] = kvecinos(direccion_bd,k);
        [confucion, eficiencia] = MatrizConfusion(Ytest, Yestimado);
        media_eficiencia(i, 2) = eficiencia;

        [Ytest, Yestimado] = parzen(direccion_bd,h);
        [confucion, eficiencia] = MatrizConfusion(Ytest,Yestimado);
        media_eficiencia(i, 3) = eficiencia;
    end

    for i = 1:3
        eficiencia(i,:) = mean(media_eficiencia(:, i));
    end

    disp('Eficiencias');
    disp(strcat('Gauss:', num2str(eficiencia(1,1))));
    disp(strcat('knn:', num2str(eficiencia(2))));
    disp(strcat('parzen:', num2str(eficiencia(3))));
end

