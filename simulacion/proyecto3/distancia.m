function [r] = distancia( a, b )
    r = sqrt(sum((b-a).^2));
end
