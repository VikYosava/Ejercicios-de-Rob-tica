function Q=MCIPA10(T)

% Inicialización y desacoplo.
% -----------------------------------

d1=315; d4=500; d6=80; a2=450;
Q=zeros(4,6);
Pm=T(1:3,4)-d6*T(1:3,3);    % Desacoplo cinemático.

% Resolución del brazo: Q(1), Q(2) y Q(3).
% ------------------------------------------------

% Q codo arriba muñeca +
r=sqrt(Pm(1)^2+Pm(2)^2);
Q(1,1)=atan2(Pm(2)/r,Pm(1)/r);

L=sqrt(r^2+(Pm(3)-d1)^2);
ang1=atan2((Pm(3)-d1)/L,r/L);
ang2=acos((a2^2+L^2-d4^2)/(2*a2*L));
Q(1,2)=ang1+ang2;

fi=acos((d4^2+a2^2-L^2)/(2*a2*d4));
Q(1,3)=pi/2+fi;

% Q codo arriba muñeca -
Q(2,1)=Q(1,1);
Q(2,2)=Q(1,2);
Q(2,3)=Q(1,3);

% Q codo abajo muñeca +
Q(3,1)=atan2(Pm(2)/r,Pm(1)/r);
Q(3,2)=ang1-ang2;
Q(3,3)=pi/2-fi;

% Q codo abajo muñeca -
Q(4,1)=Q(3,1);
Q(4,2)=Q(3,2);
Q(4,3)=Q(3,3);

% Resolución del brazo: Q(4), Q(5) y Q(6).
% ------------------------------------------------

for i=1:1:4
    T01=desp([0 0 d1])*rotZ(Q(i,1))*desp([0 0 0])*rotX(pi/2);
    T12=desp([0 0 0])*rotZ(Q(i,2))*desp([a2 0 0])*rotX(0);
    T23=desp([0 0 0])*rotZ(Q(i,3))*desp([0 0 0])*rotX(-pi/2);
    T03=T01*T12*T23;
    T36=inv(T03)*T;
    
    if(i==1)|(i==3)
        s5=sqrt(T36(3,1)^2+T36(3,2)^2);
        % Al aparecer una raiz cuadrada, puede ser - o +
    else
        s5=-sqrt(T36(3,1)^2+T36(3,2)^2);
    end
    Q(i,5)=atan2(s5,T36(3,3));
    if(round(s5,5)~=0)
        Q(i,4)=atan2(T36(2,3)/-s5,T36(1,3)/-s5);
        Q(i,6)=atan2(-T36(3,2)/s5,T36(3,1)/s5);
    else
       % Estamos tratando con una solución degenerada, al no poder dividir
       % entre s5 en caso de ser 0, en esos casos Q4 y Q6 tienen infinitas
       % soluciones, igualamos uno de los dos ángulos a 0 y calculamos el
       % otro.
       Q(i,6)=0;
       Q(i,4)=atan2(T36(1,1),T36(1,2));
    end
end


