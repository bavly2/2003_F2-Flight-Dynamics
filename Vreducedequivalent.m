function [Vre, Ve] = Vreducedequivalent()
%Retrieve flightdata
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

%Standard atmosphere values in SI units
T0 = 288.15; %in K
p0 = 101325; %in Pa
rho0 = 1.225; %in Kg/m^3
lambda = -0.0065; %in K/m
g0 = 9.80665; %in m/s^2
R = 287.058; %in J/(Kg K)
gamma = 1.4; %Heat capacity ratio

%Retrieve hp, Tm, Vc and W from test data and calculate Ve tilde.
hp = 0.3048*flightdata.Dadc1_alt.data; %in m
Tm = flightdata.Dadc1_tat.data+273.15; %in K
Vc = 0.514444444*flightdata.Dadc1_cas.data; %in m/s
[M, ~] = mass_and_balance(); %Mass of a/c in Kg
W = M*g0; %Weight of a/c in N

%Calculate pressure in Pa
p = p0*(1+(lambda*hp)/T0).^(-g0/(lambda*R));

% M1 = 1+((gamma-1)/(2*gamma))*(rho0/p0)*Vc.^2;
% M2 = M1.^(gamma/(gamma-1))-1;
% M3 = 1+(p0*p.^-1).*M2;
% M4 = M3.^((gamma-1)/gamma)-1;
% Mver = sqrt((2/(gamma-1))*M4);

%Calculate mach
M = sqrt(2/(gamma-1)*((1+(p0*p.^-1).*((1+((gamma-1)/(2*gamma))*(rho0/p0)*Vc.^2).^(gamma/(gamma-1))-1)).^((gamma-1)/gamma)-1));

%Calculate static temperature
T = Tm.*(1+((gamma-1)/2)*M.^2).^-1;

%Calculate speed of sound
a = sqrt(gamma*R*T);

%Calculate true airspeed
Vt = M.*a;

%Calculate density 
rho = p.*((R*T).^-1);

%Calculate equivalent airspeed
Ve = Vt.*sqrt(rho/rho0);

%Calculate reduced equivalent airspeed

Ws = 60500; %Standard aircraft weight in N

Vre = Ve.*sqrt(Ws*(W.^-1));


