% Prueba CI STANFORD
% Viktor Yosava

Q=[90*pi/180 45*pi/180 0.3 90*pi/180 0 45*pi/180]
T=CDStanford(Q)
Q2=CIStanford(T)
for i=1:1:8
    CDStanford(Q2(i,1:6))-T
end

% El bucle anterior nos da el error entre las 8 soluciones calculadas y T
% Las soluciones 4 y 8 no han podido resolverse correctamente y dan una
% matriz de transformación distinta a la esperada, por lo que el error es
% mucho mayor, no he sido capaz de identificar el por qué de esto.