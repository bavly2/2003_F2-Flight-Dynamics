%Constants
Ws = 60500; %Standard weight in N
rho0 = 1.225; %Sealevel air density  in Kg/m^3
S = 30; %Wing area in m^2

%Specify at which time the measurements have to be taken
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

time = flightdata.time.data;

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

CmTc = -0.0064; %Dimensionless thrust arm
%delta_e_eq = delta_e - CmTc/Cm_delta*(Tcs-Tc)

%Step 2: Retrieve reduced equivalen airspeed.

Vre = Vreducedequivalent();

Vre_plot = Vre(tind);
delta_e_plot = delta_e_eq(tind);

%Plot reduced elevator deflection with reduced equivalent airspeed

%Sort x-axis data (Vre) and reorder y-axis data in same manner 
[Vre_plot_sorted, Vre_plot_order] = sort(Vre_plot);
delta_e_plot_sorted = delta_e_plot(Vre_plot_order);

%Make figure and plot
figure
plot(Vre_plot_sorted,delta_e_plot_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Reduced equivalent airspeed [m/s]');
ylabel('Equivalent elevator deflection [degree]');
title('Reduced elevator deflection related to reduced equivalent airspeed');

%Plot reduced elevator deflection with angle of attack
CLa = 5.084;

amina0_plot = Ws/(0.5*rho0*Vre_plot.^2*S*CLa);

[amina0_plot_sorted, amina0_plot_order] = sort(amina0_plot);
delta_e_plot_sorted = delta_e_plot(amina0_plot_order);

figure
plot(amina0_plot_sorted,delta_e_plot_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Angle of attack minus zero lift angle of attack [degree]');
ylabel('Reduced elevator deflection [degree]');
title('Reduced elevator deflection related to reduced equivalent airspeed');


