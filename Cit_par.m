% % Citation 550 - Linear simulation
a = load('FTISxprt-20180320_102524');

[~,xcg] = mass_and_balance();
% 
% % Stationary flight condition
% 
 hp0    =  a.flightdata.Dadc1_alt.data*0.3048 ;      	  % pressure altitude in the stationary flight condition [m]
 V0     =  a.flightdata.Dadc1_tas.data*0.514444 ;     % true airspeed in the stationary flight condition [m/sec]
 alpha0 =  a.flightdata.vane_AOA.data   ;   % angle of attack in the stationary flight condition [deg]
 th0    =  a.flightdata.Ahrs1_Pitch.data ;       	  % pitch angle in the stationary flight condition [rad]
% % 
% % % Aircraft mass
 [m,~]      = mass_and_balance() ;         	  % mass [kg]
% % 



% % % aerodynamic properties
cd 'ClCd' 
 [~,~,~,e,~,~,~,~]=CalAeroPara();
% e      = 0.8 ;            % Oswald factor [ ]
[~,~,CD0,~,~,~,~,~]=CalAeroPara();
%CD0 = Cd0;
% CD0    = 0.04 ;            % Zero lift drag coefficient [ ]
[CLa,~,~,~,~,~,~,~]=CalAeroPara();
%CLa     = Clalpha; 
% CLa    = Cl_alpha() ;            % Slope of CL-alpha curve [ ]
% % 
cd ..\..
% % % Longitudinal stability
cd '2003_F2-Flight-Dynamics-master'
Cma = Cm_alpha();         % longitudinal stabilty [ ]
Cmde   = cm_delta () ;            % elevator effectiveness [ ]
% 
% % Aircraft geometry

S      = 30.00;	          % wing area [m^2]
Sh     = 0.2*S;           % stabiliser area [m^2]
Sh_S   = Sh/S;	          % [ ]
lh     = 0.71*5.968;      % tail length [m]
c      = 2.0569;	  % mean aerodynamic cord [m]
lh_c   = lh/c;	          % [ ]
b      = 15.911;	  % wing span [m]
bh     = 5.791;	          % stabilser span [m]
A      = b^2/S;           % wing aspect ratio [ ]
Ah     = bh^2/Sh;         % stabilser aspect ratio [ ]
Vh_V   = 1;		  % [ ]
ih     = -2*pi/180;       % stabiliser angle of incidence [rad]
% 
% % Constant values concerning atmosphere and gravity

rho0   = 1.2250;          % air density at sea level [kg/m^3] 
lambda = -0.0065;         % temperature gradient in ISA [K/m]
Temp0  = 288.15;          % temperature at sea level in ISA [K]
R      = 287.05;          % specific gas constant [m^2/sec^2K]
g      = 9.81;            % [m/sec^2] (gravity constant)

rho = [];
for n = 1:43611
    rho_1 = rho0*((1+(lambda*(hp0(n)/Temp0))))^(-((g/(lambda*R))+1));
    rho =[rho, rho_1];
end

rho = rho (:);                          % [kg/m^3]  (air density)
W      = m*g;                          % [N]       (aircraft weight)

% 
%  
% % Constant values concerning aircraft inertia
muc =[];
mub=[];
for n = 1:43611
    muc_1    = m(n)/(rho(n)*S*c);
    mub_1    = m(n)/(rho(n)*S*b);
    muc = [muc, muc_1];
    mub = [mub, mub_1];
end
muc = muc(:);
mub = mub(:);

KX2    = 0.019;
KZ2    = 0.042;
KXZ    = 0.002;
KY2    = 1.25*1.114;

% % Aerodynamic constants
% 
Cmac   = 0;                     % Moment coefficient about the aerodynamic centre [ ]
CNwa   = CLa;   		        % Wing normal force slope [ ]
CNha   = 2*pi*Ah/(Ah+2);        % Stabiliser normal force slope [ ]
depsda = 4/(A+2);               % Downwash gradient [ ]

% % Lift and drag coefficient
% 
% 
% %CD = CD0 + (CLa*alpha0.)^2/(pi*A*e);  % Drag coefficient [ ]
CD = [];
CL = [];
[Vre,~] = Vreducedequivalent();
for n = 1:43661
    CL_1 = 2*W(n)/(rho0*Vre(n)^2*S);               % Lift coefficient [ ]
    CD_1 = CD0 + (CLa*alpha0(n))^2/(pi*A*e);
    CL = [CL, CL_1];
    CD = [CD, CD_1];   
end
CL = CL (:);
CD = CD (:);


% % Stabiblity derivatives
CX0 =[];
for n = 1:43611
    CX0_1   = W(n)*sin(th0(n))/(0.5*rho(n)*V0(n)^2*S);
    CX0 = [CX0_1, CX0];
end
CX0 = CX0(:);

CXu    = -0.02792;
CXa    = -0.47966;
CXadot = +0.08330;
CXq    = -0.28170;
CXde   = -0.03728;

CZ0 =[];
for n = 1:43611
    CZ0_1    = -W(n)*cos(th0(n))/(0.5*rho(n)*V0(n)^2*S);
    CZ0 = [CZ0_1, CZ0];
end
CZ0 = CZ0(:);

CZu    = -0.37616;
CZa    = -5.74340;
CZadot = -0.00350;
CZq    = -5.66290;
CZde   = -0.69612;

Cmu    = +0.06990;
Cmadot = +0.17800;
Cmq    = -8.79415;

CYb    = -0.7500;
CYbdot =  0     ;
CYp    = -0.0304;
CYr    = +0.8495;
CYda   = -0.0400;
CYdr   = +0.2300;

Clb    = -0.10260;
Clp    = -0.71085;
Clr    = +0.23760;
Clda   = -0.23088;
Cldr   = +0.03440;

Cnb    =  +0.1348;
Cnbdot =   0     ;
Cnp    =  -0.0602;
Cnr    =  -0.2061;
Cnda   =  -0.0120;
Cndr   =  -0.0939;
