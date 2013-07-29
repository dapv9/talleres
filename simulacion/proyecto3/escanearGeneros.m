function [ Matriz ] = escanearGeneros( directorio )

    generos = listar_archivos(directorio); % entrega todas las carpetas o directorios contenidos dentro de una carpeta
    
    for i = 1 : length(generos)
        nombre = generos(i).name;
        genero = strcat(directorio, nombre, '/')
        Mat = matricesCaracteristicas(genero);
        dlmwrite(strcat('/tmp/raziel/tmp/', nombre, '.csv'), Mat);
    end

    % M = Matriz;
end
