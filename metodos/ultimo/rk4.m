function [T, X, Y, bi] = rk4(n, ti, tf, xi, yi, f, g)

    %Programa para resolver un problema de valor inicial de segundo orden
    %por el metodo Runge-Kutta de orden cuatro
    %La formulacion del problema es: x'=f(t,x,y);x(ti)=xi; y'=g(t,x,y);y(ti)=yi;
    %en el intervalo:[xi,xf] con n iteraciones.
    % Entrada de la informacion
%      n = input('numero de iteraciones = ');
%      ti = input('abscisa inicial = ');
%      tf = input('abscisa final = ');
%      xi = input('primera ordenada inicial = ');
%      yi = input('segunda ordenada inicial = ');
%      f = input('entrar la funcion f(t,x,y) = ');
%      g = input('entrar la funcion g(t,x,y) = ');
    % El tamano de paso se calcula como
    h=(tf-ti)/n;
    %El vector de abscisas se calcula como
    for k=1:n+1
	T(k)=ti+(k-1)*h;
    end
    %Los vectores de ordenadas se calculan como
    X(1)=xi;
    Y(1)=yi;
    for k=1:n
	t=T(k);
	x=X(k);
	y=Y(k);
	M1x(k)=eval(f);
	M1y(k)=eval(g);
	t=t+h/2;

	x=x+h*M1x(k)/2;
	y=y+h*M1y(k)/2;
	M2x(k)=eval(f);
	M2y(k)=eval(g);
	t=t;
	x=x-h*M1x(k)/2+h*M2x(k)/2;
	y=y-h*M1y(k)/2+h*M2y(k)/2;
	M3x(k)=eval(f);
	M3y(k)=eval(g);
	t=t+h/2;
	x=x+h*M3x(k)-h*M2x(k)/2;
	y=y+h*M3y(k)-h*M2y(k)/2;
	M4x(k)=eval(f);
	M4y(k)=eval(g);
	Mx(k)=(M1x(k)+2*M2x(k)+2*M3x(k)+M4x(k))/6;
	My(k)=(M1y(k)+2*M2y(k)+2*M3y(k)+M4y(k))/6;
	X(k+1)=X(k)+h*Mx(k);
	Y(k+1)=Y(k)+h*My(k);
    end

    bi = Y(length(Y));
end
