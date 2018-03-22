%%%%%%%% Alternative %%%%%%%%%%%%%%%%%%%

run('Cit_par')

V = V0(31181)*.514444444444;              % STATIONARY VELOCITY TAS >>> TO BE CHANGED FOR OWN TESTFLIGHT !!!!!!!!!!!!!!!!!! 

MUC = 123.6842;                           % Assumption : change in inertia small between [55 50] & [60 4 57], hence avg. of
MUB = 15.9893;                            % inertia was taken between these
                                          % times

CX0 = 0.0078;                             % avg. taken of CX0 column vector during eigenmotions
CZ0 = -0.2598;                            % avg. taken of CZ0 column vector during eigenmotions
CL = 0.4915;                              % avg. taken of CL column vector during eigenmotions

%symmetrical motion

C1s = [-2*MUC*(c/V^2),0,0,0;
    0,(CZadot-2*MUC)*(c/V),0,0;
    0,0,-(c/V),(c/V);
    0,Cmadot*(c/V),0,-2*MUC*KY2*(c^2/(V)^2)];

C2s = [CXu/V,CXa,CZ0,0;
    CZu/V,CZa,-CX0,(CZq+2*MUC)*(c/V);
    0,0,0,c/V;
    Cmu/V,Cma,0,Cmq*(c/V)];

C3s = [CXde;CZde;0;Cmde];

As = -C1s^-1*C2s;
Bs = -C1s^-1*C3s;
Cs_u_hat = [1,0,0,0];
Cs_alp = [0,1,0,0];
Cs_th = [0,0,1,0];
Cs_q = [0,0,0,1];
Ds = 0;

syssym_u_hat = ss(As,Bs,Cs_u_hat,Ds);
syssym_alp = ss(As,Bs,Cs_alp,Ds);
syssym_th = ss(As,Bs,Cs_th,Ds);
syssym_q = ss(As,Bs,Cs_q,Ds);

%asymmetrical motion

C1a = [(CYbdot-2*MUB)*b/V,0,0,0;
    0,-0.5*b/V,0,0;
    0,0,-2*MUB*KX2*(b/V)^2,2*MUB*KXZ*(b/V)^2;
    Cnbdot,0,2*MUB*KXZ*(b/V)^2,-2*MUB*KZ2*(b/V)^2];

C2a = [CYb,CL,CYp*b/(2*V),(CYr-4*MUB)*b/(2*V);
    0,0,b/(2*V),0;
    Clb,0,Clp*b/(2*V),Clr*b/(2*V);
    Cnb,0,Cnp*b/(2*V),Cnr*b/(2*V)];

C3a = [CYda,CYdr;
    0,0;
    Clda,Cldr;
    Cnda,Cndr];

Aa = -C1a^-1*C2a;
Ba = -C1a^-1*C3a;
Ca_beta = [1,0,0,0];
Ca_phi = [0,1,0,0];
Ca_p = [0,0,1,0];
Ca_r = [0,0,0,1];
Da = 0;

sysasym_beta = ss(Aa,Ba,Ca_beta,Da);
sysasym_phi = ss(Aa,Ba,Ca_phi,Da);
sysasym_p = ss(Aa,Ba,Ca_p,Da);
sysasym_r = ss(Aa,Ba,Ca_r,Da);


% eigenvaluessym = eig(As)
% eigenvaluesasym = eig(Aa)