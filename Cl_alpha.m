function [Cla] = Cl_alpha ()

%standard atmospher parameters
T0 = 288.15; %in K
p0 = 101325; %in Pa
rho0 = 1.225; %in Kg/m^3
lambda = -0.0065; %in K/m
g0 = 9.80665; %in m/s^2
R = 287.058; %in J/(Kg K)
gamma = 1.4; %Heat capacity ratio

%aircraft properties
S      = 30.00;	          % wing area [m^2]


%flight test data from stationary measurements CL-CD series 1
Cas = [250,221,189,162,130,116];
Cas = Cas * 0.514444;
TAT = [3.2,1.2,-0.5,-2.5,-3.8,-3.8];
TAT = TAT + 273.15;
hp  = [5040,5050,5030,5050,4960,4980];
alpha = [1.2,1.9,3.2,4.8,7.4,10];


CL = [];

[weight, ~] = mass_and_balance(); %Mass of a/c in Kg
W = weight*g0; %Weight of a/c in N

%Calculate pressure in Pa
p = p0*(1+(lambda*hp)/T0).^(-g0/(lambda*R));

%Calculate mach
M = sqrt(2/(gamma-1)*((1+(p0*p.^-1).*((1+((gamma-1)/(2*gamma))*(rho0/p0)*Cas.^2).^(gamma/(gamma-1))-1)).^((gamma-1)/gamma)-1));

%Calculate static temperature
T = TAT.*(1+((gamma-1)/2)*M.^2).^-1;

%Calculate speed of sound
a = sqrt(gamma*R*T);

%Calculate true airspeed
Vt = M.* a;

%Calculate density 
rho = p.*((R*T).^-1);

W = [W(1)-247*0.453592,W(1)-285*0.453592,W(1)-312*0.453592,W(1)-357*0.453592,W(1)-410*0.453592,W(1)-444*0.453592];

CL = 2*W./(rho.*Vt.^2*S);               % Lift coefficient [ ]

mdl = fitlm(alpha,CL,'linear');

%plot(mdl)

coefficients = mdl.Coefficients.Estimate;
Cla = radtodeg(coefficients(2));
a_0 = coefficients(1);
