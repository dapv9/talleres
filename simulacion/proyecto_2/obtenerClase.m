function [clase] = obtenerClase(n1, n2)

    if n1 == -1
	if n2 == -1
	    clase = 0; % pop
	else
	    clase = 1; % regaeton
	end
    else
	if n2 == -1
	    clase = 2; % rock
	else
	    clase = 3; % salsa
	end
    end

end
