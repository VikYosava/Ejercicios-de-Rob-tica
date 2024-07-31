function T=ZXZ2tr(a)

%Guardamos los valores de seno y coseno de a en s y c respectivamente, para
%acortar la función
s=sin(a); c=cos(a);

%Guadramos en T los valores del giro ZXZ calculados previamente
T=[c(1)*c(3)-c(2)*s(1)*s(3) -c(1)*s(3)-c(2)*c(3)*s(1) s(1)*s(2) 0;
    c(3)*s(1)+c(1)*c(2)*s(3) c(1)*c(2)*c(3)-s(1)*s(3) -c(1)*s(2) 0;
    s(2)*s(3) c(3)*s(2) c(2) 0;
    0 0 0 1];