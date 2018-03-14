%Inputs:
%
%Measured elev deflection
%Cmdelta
%CmTC
%Tcs
%Tc
%Ve tilde which is gotten from:
%hp
%Vc
%W

%Standard atmosphere values in SI units
T0 = 288.15; %in K
p0 = 101325; %in Pa
rho0 = 1.225; %in Kg/m^3
lambda = -0.0065; %in K/m
g0 = 9.80665; %in m/s^2
R = 287.058; %in J/(Kg K)
gamma = 1.4; 

%Specify at which time the measurements have to be taken
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

time = flightdata.time.data;

%Specify at which time stationary measurements are calculated
hrs = [0, 0, 0, 0, 0, 0]; %Dummy data
min = [23, 24, 25, 26, 27, 28]; %Dummy data
sec = hrs*3600+min*60;

tind = zeros(1,length(sec));
for i = 1:length(sec)
    tind(i) = find(time>sec(i),1);
end


%Step 1: Retrieve elev deflection from test data and calculate reduced elevator
%deflection.

%Elevator deflection in degrees
delta_e = flightdata.delta_e.data;

%Step 2: Retrieve hp, Vc and W from test data and calculate Ve tilde.

hp = 0.3048*flightdata.Dadc1_alt.data; %in m
tat = flightdata.Dadc1_tat.data+273.15; %in K
Vc = 0.514444444*flightdata.Dadc1_cas.data; %in m/s

p = p0*(1+(lambda*hp)/T0).^(-g0/(lambda*R));

M = sqrt(2/(gamma-1)*((1+(p0/p)*((1+((gamma-1)/(2*gamma))*(rho0/p0)*Vc.^2).^(gamma/(gamma-1))-1)).^((gamma-1)/gamma)-1))
