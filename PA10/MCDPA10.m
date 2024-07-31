function T=MCDPA10(Q)

a=[0 450 0 0 0 0];
alp=[pi/2 0 -pi/2 pi/2 -pi/2 0];
d=[315 0 0 500 0 80];

T01=desp([0 0 d(1)])*rotZ(Q(1))*desp([a(1) 0 0])*rotX(alp(1));
T12=desp([0 0 d(2)])*rotZ(Q(2))*desp([a(2) 0 0])*rotX(alp(2));
T23=desp([0 0 d(3)])*rotZ(Q(3))*desp([a(3) 0 0])*rotX(alp(3));
T34=desp([0 0 d(4)])*rotZ(Q(4))*desp([a(4) 0 0])*rotX(alp(4));
T45=desp([0 0 d(5)])*rotZ(Q(5))*desp([a(5) 0 0])*rotX(alp(5));
T56=desp([0 0 d(6)])*rotZ(Q(6))*desp([a(6) 0 0])*rotX(alp(6));

T=T01*T12*T23*T34*T45*T56;