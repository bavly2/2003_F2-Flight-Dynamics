function C_m_delta = cm_delta()
a = load('FTISxprt-20180320_102524');
%cm_delta determination
[Vre, ~] = Vreducedequivalent(); %reduced equivalent airspeed
flightdata = load('FTISxprt-20180320_102524.mat');
delta_e = flightdata.flightdata.delta_e.data ;
[~, cg_data,~] = mass_and_balance();

%Constants
rho0 = 1.225; %Sea level density in Kg/m^3
S = 30; %Wing area in m^2
c = 2.0569; %Mean aerodynamic chord in m
[w,~] =  mass_and_balance();
W      = w*9.81;
Ws = 60500; %Standard weight in N

%t1 time step where cm_delta measurment procedure starts (person in seat 8 moves up
%to between seats 1&2)

t1 = 27302;
%t2 time step where cm_delta measurment procedure ends (person moves back
%to seat 8)
t2 = 28410;
%t2 = 28499;
delta_cg = cg_data(t1)-cg_data(t2); %shift in cg 
delta_delta_e = delta_e(t1)-delta_e(t2); %shift in delta_e to maintain longtitudinal stability
delta_delta_e = degtorad(delta_delta_e);
%change in weight due to fuel burn very small and thus neglected
%chnage in V_e very small and thus neglected
C_N = W(28000) /((1/2)*rho0*Vre(28000)^2*S); 
C_m_delta= -(1/delta_delta_e)*C_N*(delta_cg/c); %elevator effectivness
