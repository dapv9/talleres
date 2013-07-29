function [ Matriz ] = matricesCaracteristicas( directorio )

    canciones = listar_archivos(directorio);

    for i = 1 : length(canciones)
        nombre = canciones(i).name;
        nombre
        [y, Fs, nbits] = wavread(strcat(directorio, nombre));
        fila = caracteristicasXcancion(y, Fs, nbits);
        % fila = ones(32)
        Matriz(i,:) = fila;
        % length(fila)
        % length(Matriz)
        % nombre
    end
    % M = Matriz;
end
