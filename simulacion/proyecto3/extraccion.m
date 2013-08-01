function [t] = extraccion(direccion_bd)

    h = 4;
    k = 4;

    n_caracteristicas = 32;
    caracteristicas = 1:n_caracteristicas;

    % leemos la base de datos
    archivos = listar_archivos(direccion_bd);
    n = length(archivos);
    n_filas = n*50;

    xtrain = zeros(n_filas, n_caracteristicas);
    ytrain = zeros(n_caracteristicas, 1);

    for i = 1:n
        archivo = archivos(i).name

        M = dlmread(strcat(direccion_bd, archivo));
        n_m = length(M);
        xtrain((i-1)*n_m+1:i*n_m, :) = M;

        for j = 1:n_m
            ytrain((i-1)*n_m + j) = i;
        end
    end

    dat.X = xtrain';
    dat.y = ytrain';

    w = lda(dat)
    w = linproj(dat, w)
    
    n_xtrain = w.X * xtrain
    n_ytrain = w.y * ytrain
    
end
