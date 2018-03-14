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
%delta_e_eq = delta_e - CmTc/Cmdelta*(Tcs-Tc)

%Step 2: Retrieve reduced equivalen airspeed.

Vre = Vreducedequivalent();

Vre_plot = Vre(tind);
delta_e_plot = delta_e_eq(tind);

[Vre_plot_sorted, Vre_plot_order] = sort(Vre_plot);
delta_e_plot_sorted = delta_e_plot(Vre_plot_order);

plot(Vre_plot_sorted,delta_e_plot_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Reduced equivalent airspeed [m/s]');
ylabel('Measured elevator deflection [degree]');
title('Elevator deflection related to reduced equivalent airspeed');



