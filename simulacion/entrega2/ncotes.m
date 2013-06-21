function [IT, ET] = ncotes(x, y, h)

    N = length(x);

    % Se generan la integral IT y el error ET por la regla del trapecio
    IT = 0;
    ET = 0;

    for i = 1:N-1
        IT = IT + (h / 2) * (y(i) + y(i + 1));
    end

    for i = 2:N-1
        ET = ET - (h / 12) * (y(i - 1) - 2 * y(i) + y(i + 1));
    end

    IT
    ET

    % Se generan la integral IS1 y el error ES1 por la regla del Simpson 1/3
    IS1 = 0;
    ES1 = 0;

    for i = 1:N/2
        IS1 = IS1 + (h / 3) * (y(2 * i - 1) + 4 * y(2 * i) + y(2 * i + 1));
    end

    for i = 3:N-2
        ES1 = ES1 - (h / 90) * (y(i - 2) - 4 * y(i - 1) + 6 * y(i) - 4 * y(i + 1) + y(i + 2));
    end

    IS1
    ES1

    % Se generan la integral IS3 y el error ES3 por la regla del Simpson 3/8
    IS3 = 0;
    ES3 = 0;

    for i = 1:N/3
        IS3 = IS3 + (3 * h / 8) * (y(3 * i - 2) + 3 * y(3 * i - 1) + 3 * y(3 * i) + y(3 * i + 1));
    end

    for i = 3:N-2
        ES3 = ES3 - (3 * h / 80) * (y(i - 2) - 4 * y(i - 1) + 6 * y(i) - 4 * y(i + 1) + y(i + 2));
    end

    IS3
    ES3
end

