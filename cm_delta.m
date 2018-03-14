%cm_delta determination
Vre = Vreducedequivalent(); %reduced equivalent airspeed
flightdata = load('FTISxprt-20180306_082856.mat');
delta_e = flightdata.flightdata.delta_e.data ;
[~, cg_data] = mass_and_balance();

%Constants
rho0 = 1.225; %Sea level density in Kg/m^3
S = 30; %Wing area in m^2
c = 2.0569; %Mean aerodynamic chord in m
Ws = 60500; %Standard weight in N

%t1 time step where cm_delta measurment procedure starts (person in seat 10 moves up
%to between seats 1&2)
t1 = 31445;
%t2 time step where cm_delta measurment procedure ends (person moves back
%to seat 10)
t2 = 32189;
delta_cg = cg_data(t2)-cg_data(t1); %shift in cg 
delta_delta_e = delta_e(t2)-delta_e(t1); %shift in delta_e to maintain longtitudinal stability
%change in weight due to fuel burn very small and thus neglected
%chnage in V_e very small and thus neglected
C_N = (Ws) /((1/2)*rho0*Vre(t1)^2*S); 
C_m_delta= -(1/delta_delta_e)*C_N*(delta_cg/c); %elevator effectivness
