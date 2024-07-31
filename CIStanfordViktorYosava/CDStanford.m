function T=CDStanford(Q)

d1=0.2 ; d2=0.1 ; d6=0.6; % en metros
s=sin(Q);c=cos(Q);

T01=[c(1) 0 s(1) 0; s(1) 0 -c(1) 0; 0 1 0 d1;0 0 0 1];
T12=[c(2) 0 -s(2) 0; s(2) 0  c(2) 0; 0 -1 0 d2;0 0 0 1];
T23=[1 0 0 0; 0 1 0 0; 0 0 1 Q(3); 0 0 0 1];
T34=[c(4) 0 s(4) 0; s(4) 0 -c(4) 0;0 1 0 0;0 0 0 1];
T45=[c(5) 0 -s(5) 0; s(5) 0 c(5) 0; 0 -1 0 0;0 0 0 1];
T56=[c(6) -s(6) 0 0;s(6) c(6) 0 0; 0 0 1 d6;0 0 0 1];

T=T01*T12*T23*T34*T45*T56;