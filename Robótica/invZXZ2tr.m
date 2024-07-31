function [alpha,beta,gamma]=invZXZ2tr(T)

%Calculamos beta a partir de la matriz transformada T según hemos calculado
%anteriormente
beta=atan2(sqrt((T(3,1)^2)+(T(3,2))^2),T(3,3));

%En el caso de que el seno de beta no sea 0, podemos calcular alpha y gamma
%directamente, sin embargo, si el seno de beta fuera 0, debemos sustituir
%los valores en la matriz T y calcularlos de nuevo, ya que sen(beta)
%aparece como denominador en algunas ecuaciones.
if sin(beta)~=0
    alpha=atan2(T(1,3)/sin(beta),-T(2,3)/sin(beta));
    gamma=atan2(T(3,1)/sin(beta),T(3,2)/sin(beta));
else
    alpha=0;
    gamma=atan2(T(2,1),T(1,1));
    %En el caso de la transformada ZXZ existen infinitas soluciones para
    %alpha y gamma, por lo que determinamos un valor arbitrario de una de
    %las dos variables para calcular la otra, alpha=0 en este caso.
end