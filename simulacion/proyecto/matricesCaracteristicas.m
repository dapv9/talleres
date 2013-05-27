function [ Matriz ] = matricesCaracteristicas( directorio )

    canciones = dir(directorio);

    for i = 1 : length(canciones)
        nombre = canciones(i).name;
        if ~strcmp(nombre, '.') && ~strcmp(nombre, '..')
            nombre
            [y, Fs, nbits] = wavread(strcat(directorio, nombre));
            fila = caracteristicasXcancion(y, Fs, nbits);
            % fila = ones(32)
            Matriz(i,:) = fila;
            % length(fila)
            % length(Matriz)
            % nombre
        end
    end
    
    % M = Matriz;
end
