function [ lista_bds ] = listar_archivos( direccion_bd )

    lista_bds = dir(direccion_bd);

    % indice que se usará para recorrer el arreglo.
    i = 1;
    % tamaño máximo de elementos del arreglo.
    n = length(lista_bds);

    while 1
        if i > n
            break;
        end

        % si estamos leyendo "." ó ".." los eliminamos del arreglo.
        if strcmp(lista_bds(i).name, '.') || strcmp(lista_bds(i).name, '..')
            lista_bds(i) = [];
            n = n-1;
        else
            i = i + 1;
        end
    end

end
