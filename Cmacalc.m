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
gamma = 1.4; %Heat capacity ratio

%Specify at which time the measurements have to be taken
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

time = flightdata.time.data;

%Retrieve true airspeed from flight test data
Vtasdata = flightdata.Dadc1_tas.data*0.514444444; %in m/s

%Specify at which time stationary measurements are calculated
hrs = [0, 0, 0, 0, 0, 0]; %Dummy data
min = [44, 45, 46, 47, 48, 49]; %Dummy data
sec = hrs*3600+min*60;

tind = zeros(1,length(sec));
for i = 1:length(sec)
    tind(i) = find(time>sec(i),1);
end

%Step 1: Retrieve elev deflection from test data and calculate reduced elevator
%deflection.

%Retrieve elevator deflection in degrees
delta_e = flightdata.delta_e.data;

delta_e_eq = delta_e; %PLACEHOLDER 
%delta_e_eq = delta_e - CmTc/Cmdelta*(Tcs-Tc)

%Step 2: Retrieve hp, Tm, Vc and W from test data and calculate Ve tilde.

hp = 0.3048*flightdata.Dadc1_alt.data; %in m
Tm = flightdata.Dadc1_tat.data+273.15; %in K
Vc = 0.514444444*flightdata.Dadc1_cas.data; %in m/s

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
[W, ~] = mass_and_balance();
Ws = 60500/g0; %Standard aircraft mass in kg

Vre = Ve.*sqrt(Ws*(W.^-1));

Vre_plot = Vre(tind);
delta_e_plot = delta_e_eq(tind);

[Vre_plot_sorted, Vre_plot_order] = sort(Vre_plot);
delta_e_plot_sorted = delta_e_plot(Vre_plot_order);

plot(Vre_plot_sorted,delta_e_plot_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Reduced equivalent airspeed [m/s]');
ylabel('Measured elevator deflection [degree]');
title('Elevator deflection related to reduced equivalent airspeed');



