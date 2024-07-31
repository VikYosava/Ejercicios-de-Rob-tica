% Jacobiano 
% Viktor Yosava

% Inicialización de variables
Q=zeros(1,3);
syms Q1 Q2 Q3 L1 L2 L3 VQ1 VQ2
Q=[Q1 Q2 Q3]; 
s=sin(Q);c=cos(Q);

% Modelo CD
T01=[c(1) -s(1) 0 L1*c(1); s(1) c(1) 0 L1*s(1); 0 0 1 0; 0 0 0 1];
T12=[c(2) -s(2) 0 L2*c(2); s(2) c(2) 0 L2*s(2); 0 0 1 0; 0 0 0 1];
T23=[c(3) -s(3) 0 L3*c(3); s(3) c(3) 0 L3*s(3); 0 0 1 0; 0 0 0 1];

T03=T01*T12*T23;

P03=T03(1:3,4);
JP=jacobian(P03,Q); % Jacobiano de posicion  

phi=(Q(1)+Q(2)+Q(3));
R03=[0 0 phi];
JR=jacobian(R03,Q); % Jacobiano de rotación 

J=[JP;JR]; % Conjuntamos jacobianos 

% Evaluamos valores
Q1=30*pi/180; Q2=45*pi/180; Q3=60*pi/180;
L1=210; L2=210; L3=320; 
J=eval(J);

% A) Calculamos la velocidad del extremo del instrumento quirúrgico {3} con
% respecto al sistema {0}
Qvel=[0.02; 0.02; 0.01];
V03=J*Qvel;

% No existen singularidades en la situación descrita

Vlin=V03(1:3,1) 
Vrot=V03(4:6,1)



% B) Calculamos las velocidades del efector final descritas en el punto
% anterior, pero desde el punto de vista del sistema {W}
Rwo=rotZ(0)*rotY(-90*pi/180)*rotZ(0); 
Rwo=Rwo(1:3,1:3);

Vlw3=(Rwo*Vlin) % V lineal
Vrw3=(Rwo*Vrot)  % V angular





