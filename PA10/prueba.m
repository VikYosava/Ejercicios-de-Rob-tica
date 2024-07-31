Q=[pi/4, pi/6, pi/3, 5*pi/12, pi/12, pi/4]
T=MCDPA10(Q)
%Q2=MCIPA10(T)
Q2=MCIPA10_v2(T)
for i=1:1:4
    MCDPA10(Q2(i,1:6))-T
end