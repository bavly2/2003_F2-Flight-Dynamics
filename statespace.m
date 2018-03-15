Cit_par;

%symmetrical motion

C1s = [-2*muc*(c/V0^2),0,0,0;
    0,(CZadot-2*muc)*(c/V0),0,0;
    0,0,-(c/V0),(c/V0);
    0,Cmadot*(c/V0),0,-2*muc*KY2*(c^2/V0^2)];

C2s = [CXu/V0,CXa,CZ0,0;
    CZu/V0,CZa,-CX0,(CZq+2*muc)*(c/V0);
    0,0,0,c/V0;
    Cmu/V0,Cma,0,Cmq*(c/V0)];

C3s = [CXde;CZde;0;Cmde];

As = -C1s^-1*C2s;
Bs = -C1s^-1*C3s;
Cs = [0,0,1,0];
Ds = 0;

syssym = ss(As,Bs,Cs,Ds);

%asymmetrical motion

C1a = [(CYbdot-2*mub)*b/V0,0,0,0;
    0,-0.5*b/V0,0,0;
    0,0,-2*mub*KX2*(b/V0)^2,2*mub*KXZ*(b/V0)^2;
    Cnbdot,0,2*mub*KXZ*(b/V0)^2,-2*mub*KZ2*(b/V0)^2];

C2a = [CYb,CL,CYp*b/(2*V0),(CYr-4*mub)*b/(2*V0);
    0,0,b/(2*V0),0;
    Clb,0,Clp*b/(2*V0),Clr*b/(2*V0);
    Cnb,0,Cnp*b/(2*V0),Cnr*b/(2*V0)];

C3a = [CYda,CYdr;
    0,0;
    Clda,Cldr;
    Cnda,Cndr];

Aa = -C1a^-1*C2a;
Ba = -C1a^-1*C3a;
Ca = [0,1,0,0];
Da = 0;

sysasym = ss(Aa,Ba,Ca,Da);

% eigenvaluessym = eig(As)
% eigenvaluesasym = eig(Aa)


