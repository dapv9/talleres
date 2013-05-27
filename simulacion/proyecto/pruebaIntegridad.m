
function [ M ] = pruebaIntegridad()

    Mat1 = matricesCaracteristicas('/home/raziel/cursos/simula/musica/electronica/');
    Mat2 = auread('/home/raziel/cursos/simula/bd/electronica.au');

    if Mat1 == Mat2
        M = Mat1
        disp('son iguales');
    else
        M = Mat2
        disp('no son iguales');
    end

    % M = Matriz;
end

