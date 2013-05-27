

%Newton 2x2
clear all

n = 15;

F=sym('((x^2)+4)*y-8');
G=sym('x^3+y^3-6*x*y');


Fx=diff(F,'x');
Fy=diff(F,'y');
Gx=diff(G,'x');
Gy=diff(G,'y');


xi = [-4 0 2];
yi = [ 0 2 1.5];

for i = 1:3
    xe(1)=xi(i);
    ye(1)=yi(i);

    for k=1:n
        x=xe(k);
        y=ye(k);
        H(k)=eval(Fx)*eval(Gy)-eval(Gx)*eval(Fy);
        Hx(k)=eval(F)*eval(Gy)-eval(G)*eval(Fy);
        Hy(k)=eval(Fx)*eval(G)-eval(Gx)*eval(F);
        xe(k+1)=xe(k)-Hx(k)/H(k);
        ye(k+1)=ye(k)-Hy(k)/H(k);
    end

    [xe' ye']

end
