function [ Matriz ] = escanearGeneros( directorio )

    generos = dir(directorio); // entrega todas las carpetas o directorios contenidos dentro de una carpeta
    
    for i = 1 : length(generos)
        nombre = generos(i).name;
        if ~strcmp(nombre, '.') && ~strcmp(nombre, '..')
            genero = strcat(directorio, nombre, '/')
            Mat = matricesCaracteristicas(genero);
            dlmwrite(strcat('/home/raziel/cursos/simula/bd/', nombre, '.csv'), Mat);
        end
    end

    % M = Matriz;
end
