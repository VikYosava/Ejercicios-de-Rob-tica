%Insertmos los ángulos en radianes que queremos utilizar para el giro ZXZ
%como ejemplo:
a=([0,90,0])*pi/180;

%Eso nos da la matriz de rotación:
T=ZXZ2tr(a)
%Podemos ver dicha matriz en la Command Window

%A continuación calculamos los tres ángulos que se han usado para formar la
%matriz, es decir, hacemos los pasos anteriores pero a la inversa:
[alpha,beta,gamma]=invZXZ2tr(T)

%podemos comprobar que alpha, beta y gamma son los mismos ángulos que hemos
%insertado en a, en radianes:

alpha1=alpha*180/pi
beta1=beta*180/pi
gamma1=gamma*180/pi