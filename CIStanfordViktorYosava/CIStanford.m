function Q=CIStanford(T)
% CI STANFORD
% Viktor Yosava

% FASE 0: Inicialización y desacoplo.
% -----------------------------------

d1=0.2 ; d2=0.1 ; d6=0.6;   % Parámetros DH en metros
Q=zeros(8,6);               % Inicialización de vector articular
Pm=T(1:3,4)-d6*T(1:3,3);    % Desacoplo cinemático.

% FASE 1: Resolución del brazo: Q(1), Q(2) y Q(3).
% ------------------------------------------------

% Realizamos el cálculo de todos los posibles ángulos y los insertamos en
% una matriz, donde las columnass 1-6 corresponden con los ángulos Q1-Q6 y
% las filas 1-8 corresponden a las soluciones. Sabemos que son 8 soluciones
% por los calculos que realizamos a continuación.

% Empezamos rellenando los ángulos Q1 Q2 Q3, es más eficiente hacerlo
% individualmente que con un bucle for, ya que harían falta demasiados if

Q(1,3)=sqrt(Pm(1)^2+Pm(2)^2+(Pm(3)-d1)^2-d2^2);
% De la operación anterior se obtienen varias soluciones ya que la raíz
% cuadrada puede ser negativa o positiva, por lo que debemos combinar
% manualmente todas.
Q(1,2)=acos((Pm(3)-d1)/Q(1,3));
% Se da la misma situación al tener que utilizar acos.

Q(2,3)=Q(1,3);
Q(2,2)=-acos((Pm(3)-d1)/Q(1,3));

Q(3,3)=-Q(1,3);
Q(3,2)=acos((Pm(3)-d1)/Q(3,3));

Q(4,3)=-Q(1,3);
Q(4,2)=-acos((Pm(3)-d1)/Q(4,3));

Q(5,3)=Q(1,3);
Q(5,2)=Q(1,2);

Q(6,3)=Q(1,3);
Q(6,2)=-acos((Pm(3)-d1)/Q(6,3));

Q(7,3)=-Q(1,3);
Q(7,2)=acos((Pm(3)-d1)/Q(7,3));

Q(8,3)=-Q(1,3);
Q(8,2)=-acos((Pm(3)-d1)/Q(8,3));


% Para el cálculo de Q(1) se realiza cambio a polares

K1=-Q(1:8,3).*sin(Q(1:8,2));
K2=-d2;
Q(1:8,1)=atan2(Pm(2),Pm(1))-atan2(K2,K1);


% FASE 3: Resolución de la muñeca.
% --------------------------------

% Cáculo de la transformada de {6} visto desde {3}

% Para rellenar los ángulos Q4 Q5 y Q6 se necesita un bucle que recorra las
% filas (soluciones)
for i=1:1:8
    s=sin(Q(i,1:6));c=cos(Q(i,1:6));
    
    T01=[c(1) 0 s(1) 0; s(1) 0 -c(1) 0; 0 1 0 d1;0 0 0 1];
    T12=[c(2) 0 -s(2) 0; s(2) 0  c(2) 0; 0 -1 0 d2;0 0 0 1];
    T23=[1 0 0 0; 0 1 0 0; 0 0 1 Q(i,3); 0 0 0 1];
    T03=T01*T12*T23;
    T36=inv(T03)*T;

    % Resolución de la muñeca por el modelo inverso de la orientación.

    
    if(i<=4)
        s5=sqrt(T36(3,1)^2+T36(3,2)^2);
        % Al aparecer una raiz cuadrada, una vez más tenemos que contemplar
        % las posibles soluciones
    else
        s5=-sqrt(T36(3,1)^2+T36(3,2)^2);
    end
    Q(i,5)=atan2(s5,T36(3,3));
    if(round(s5,5)~=0)
        Q(i,4)=atan2(-T36(2,3)/s5,-T36(1,3)/s5);
        Q(i,6)=atan2(-T36(3,2)/s5,T36(3,1)/s5);
    else
       % Estamos tratando con una solución degenerada, al no poder dividir
       % entre s5 en caso de ser 0, en esos casos Q4 y Q6 tienen infinitas
       % soluciones, igualamos uno de los dos ángulos a 0 y calculamos el
       % otro.
       Q(i,6)=0;
       Q(i,4)=atan2(T36(2,1),T36(1,1));
    end
end



