%cm_delta determination
V_e = 123 ; %equivalent airspeed
delta_e = a.flightdata.delta_e.data ;
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
C_N = (W(t1)) /((1/2)*rho0*V^2*S); 
C_m_delta= -(1/delta_delta_e)*C_N*(delta_cg/c); %elevator effectivness