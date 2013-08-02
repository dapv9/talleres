function [X, Y] = rk4( n, xi, xf, yi, f )

    % Programa para resolver un problema de valor inicial de primer orden
    % por el metodo Runge-Kutta de orden cuatro
    % La formulación del problema es: y'=f(x,y);y(xi)=yi en el intervalo:[xi,xf]
    % con n iteraciones.
    % Entrada de la información

    n = input('número de iteraciones = ');
    xi = input('abscisa inicial = ');
    xf = input('abscisa final = ');
    yi = input('ordenada inicial = ');
    f = input('entrar la función f(x,y) = ');
    % El tamano de paso se calcula como
    h = (xf-xi)/n;
    %El vector de abscisas se calcula como
    X = xi:h:xf;
    %El vector de ordenadas se calcula como
    Y(1) = yi;

    for k=1:n
	x = X(k);
	y = Y(k);
	M1(k) = eval(f);
	x= x+h/2;
	y=y+h*M1(k)/2;
	M2(k)=eval(f);
	x=x;
	y=y-h*M1(k)/2+h*M2(k)/2;
	M3(k)=eval(f);
	x=x+h/2;
	y=y+h*M3(k)-h*M2(k)/2;
	M4(k)=eval(f);
	M(k)=(M1(k)+2*M2(k)+2*M3(k)+M4(k))/6;
	Y(k+1)=Y(k)+h*M(k);
    end

%      [X' Y']
%      plot(X,Y,'k')
%      grid on

end
