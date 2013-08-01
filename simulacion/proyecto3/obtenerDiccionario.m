function [xtraind] = obtenerDiccionario(x, y, generos)
    xtraind = {};
    for j = 1:generos
	xtraind{j} = [];
    end

    for j = 1:length(x(:,1))
	f = x(j,:);
	ind = y(j);
	xtraind{ind} = [xtraind{ind}; f];
    end
end
