function [C_m_alpha, Vre_points_sorted, delta_e_points_sorted, F_e_points_sorted] = Cm_alpha()
%Constants
Ws = 60500; %Standard weight in N
rho0 = 1.225; %Sealevel air density  in Kg/m^3
S = 30; %Wing area in m^2

%Specify at which time the measurements have to be taken
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

time = flightdata.time.data;

%Specify at which time stationary measurements are calculated
hrs = [0, 0, 0, 0, 0, 0, 0]; %Dummy data
min = [38, 39, 40, 41, 42, 43, 4]; %Dummy data
sec = [0, 0, 0, 0, 0, 0, 0]; %Dummy data
total_sec = hrs*3600+min*60+sec;

tind = zeros(1,length(total_sec));
for i = 1:length(total_sec)
    tind(i) = find(time>total_sec(i),1);
end

%Step 1: Retrieve elev deflection from test data and calculate reduced elevator
%deflection.

%Retrieve elevator deflection in degrees
delta_e = flightdata.delta_e.data;

delta_e_eq = delta_e; %PLACEHOLDER 

CmTc = -0.0064; %Dimensionless thrust arm
Cm_delta = cm_delta();
%Tcs = 
%Tc =
%delta_e_points = delta_e(tind)
%delta_e_eq_points = delta_e - CmTc/Cm_delta*(Tcs-Tc)

%Step 2: Retrieve reduced elevator control force
F_e_meas = flightdata.column_fe.data;

g0 = 9.80665; %in m/s^2
Ws = 60500; %Standard weight in N
[weight, ~] = mass_and_balance(); %Mass in kg

W = weight*g0; %Weight in N

F_e_r = F_e_meas.*(Ws*W.^-1); %Reduced elevator control force

F_e_points = F_e_r(tind); %Reduced elevator control force at the measuring points

%Step 3: Retrieve reduced equivalent airspeed.

[Vre, ~] = Vreducedequivalent(); 

Vre_points = Vre(tind); %Reduced equivalent airspeed at the measuring points
delta_e_points = delta_e_eq(tind); %Reduced elevator deflection at the measuring points

%Plot reduced elevator deflection with reduced equivalent airspeed

%Sort x-axis data (Vre) and reorder y-axis data in same manner 
[Vre_points_sorted, Vre_points_order] = sort(Vre_points);
delta_e_points_sorted = delta_e_points(Vre_points_order);
F_e_points_sorted = F_e_points(Vre_points_order);

%Determine reduced elevator deflection with angle of attack
CLa = Cl_alpha();

amina0_points = Ws*(0.5*rho0*Vre_points.^2*S*CLa).^-1;

[amina0_points_sorted, amina0_points_order] = sort(amina0_points);
delta_e_points_sorted = delta_e_points(amina0_points_order);

%figure
%plot(amina0_points_sorted,delta_e_points_sorted,'-o')
% set(gca,'YDir','reverse')
% xlabel('Angle of attack minus zero lift angle of attack [degree]');
% ylabel('Reduced elevator deflection [degree]');
% title('Reduced elevator deflection related to reduced equivalent airspeed');

%Calculate slope of reduced elevator deflection curve with angle of attack
%and calculate longitudinal stability (C_m_alpha)
slope = (delta_e_points_sorted(end)-delta_e_points_sorted(1))/(amina0_points_sorted(end)-amina0_points_sorted(1));
C_m_alpha = -Cm_delta*slope;

