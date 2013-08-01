function [clases] = obtenerClase(Yest)

    clases = zeros(1, length(Yest));

    for i = 1:length(Yest)
        if Yest(1, i) == -1
            if Yest(2, i) == -1
                clases(1, i) = 1; % pop
            else
                clases(1, i) = 2; % regaeton
            end
        else
            if Yest(2, i) == -1
                clases(1, i) = 3; % rock
            else
                clases(1, i) = 4; % salsa
            end
        end
    end

    clases = clases';

end
