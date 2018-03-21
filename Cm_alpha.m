function [C_m_alpha, Vre_points_sorted, delta_e_eq_points_sorted, F_e_r_points_sorted] = Cm_alpha()


%Constants
Ws = 60500; %Standard weight in N
rho0 = 1.225; %Sealevel air density  in Kg/m^3
S = 30; %Wing area in m^2

%Import time vector
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

time = flightdata.time.data;

%Specify at which time stationary measurements are calculated
hrs = [0, 0, 0, 0, 0, 0, 0]; %Dummy data
min = [39, 41, 42, 45, 47, 48, 50]; %Dummy data
sec = [50, 8, 25, 20, 10, 45, 8]; %Dummy data
total_sec = hrs*3600+min*60+sec;

tind = zeros(1,length(total_sec));
for i = 1:length(total_sec)
    tind(i) = find(time>total_sec(i),1);
end

%Step 1: Retrieve elev deflection from test data and calculate reduced elevator
%deflection.

%Reduce elevator deflection

CmTc = -0.0064; %Dimensionless thrust arm
Cm_delta = cm_delta(); %Elevator effectiveness 
dTc = thrust_nd(tind); %Difference between standard thrust coefficient and trhust coefficient Tcs - Tc
delta_e_points = [0.1 -0.4 -0.8 -1.4 0.4 0.7 1]; %Elevator deflection at measurement points in degrees
delta_e_eq_points = delta_e_points' - CmTc/Cm_delta*(dTc'); %Reduced elevator deflection in degrees

%Step 2: Retrieve reduced elevator control force
g0 = 9.80665; %in m/s^2
Ws = 60500; %Standard weight in N
[weight, ~] = mass_and_balance(); %Mass in kg
W = weight*g0; %Weight in N
W_points = W(tind);

F_e_points = [ 0 -16.5 -26.5 -43.5 17 41 80 ]; %Elevator control force at measurement points in N

F_e_r_points = F_e_points'.*(Ws*W_points.^-1); %Reduced elevator control force at measurement points in N

%Step 3: Retrieve reduced equivalent airspeed.
hp_points = [13250; 13600; 13900; 13890; 13180; 12890; 12430];
TAT_points = [-9.3; -10.6; -12; -12.3; -8.35; -7.8; 6.2];
VIAS_points = [161; 151; 141; 130.5; 171; 180.5; 190.5];

[Vre_points, ~] = Vreducedequivalent_points(hp_points, TAT_points, VIAS_points, W_points); %Reduced equivalent airspeed at measurement points in m/s

%Plot reduced elevator deflection with reduced equivalent airspeed

%Sort x-axis data (Vre) and reorder y-axis data in same manner 
[Vre_points_sorted, Vre_points_order] = sort(Vre_points);
delta_e_eq_points_sorted = delta_e_eq_points(Vre_points_order);
F_e_r_points_sorted = F_e_r_points(Vre_points_order);

%Determine reduced elevator deflection with angle of attack
CLa = Cl_alpha();

amina0_points = Ws*(0.5*rho0*Vre_points.^2*S*CLa).^-1;

[amina0_points_sorted, amina0_points_order] = sort(amina0_points);
delta_e_eq_points_sorted_alpha = delta_e_eq_points(amina0_points_order);

%figure
%plot(amina0_points_sorted,delta_e_eq_points_sorted,'-o')
%set(gca,'YDir','reverse')
%xlabel('Angle of attack minus zero lift angle of attack [degree]');
%ylabel('Reduced elevator deflection [degree]');
%title('Reduced elevator deflection related to reduced equivalent airspeed');

%Calculate slope of reduced elevator deflection curve with angle of attack
%and calculate longitudinal stability (C_m_alpha)
slope = (delta_e_eq_points_sorted_alpha(end)-delta_e_eq_points_sorted_alpha(1))/(amina0_points_sorted(end)-amina0_points_sorted(1));
C_m_alpha = -Cm_delta*slope;

