function [x0_sp, u_sp_rad, x0_ph, u_ph_rad] = symmetric_eigenmotions(t_init_sp, t_length_sp, t_init_ph, t_length_ph, Vt_stat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% RELEVANT RESPONSES FOR ALL EIGENMOTIONS %%%%%%%%%%%%%%%%%%%
%%%%%%%% SHORT PERIOD, PHUGOID, DUTCH ROLL, APERIODIC ROLL, SPIRAL %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % wether the plot of importance considers control input or disturbance input depends on the A-matrix
 % A_asymmetric corresponds to the disturbance input
 % A_symmetric corresponds to the control input
 
 a = load('FTISxprt-20180306_082856');                  % loading flight test data

 %% Short period motion
 
 delta_e = a.flightdata.delta_e.data;
 time = a.flightdata.time.data;
 
 t_init_sp = [55 50];
 t_init_sp_sec = t_init_sp(1)*60+t_init_sp(2);
 t_ind_init_sp = find(time>t_init_sp_sec,1);
 t_length_sp = t_length_sp*10;
 
 u_sp = delta_e(t_ind_init_sp:(t_ind_init_sp+t_length_sp));
 
 u_sp_rad = deg2rad(u_sp);
 
 t_sp = 0:0.1:10;   
 
 % first knots, then ISA units
 Vt = a.flightdata.Dadc1_tas.data;
 
 u_hat_sp = (Vt_stat-Vt)./Vt;
 u_hat_sp_isa = u_hat_sp * 0.511111111111;
 
 x0_sp = [u_hat_sp_isa(t_ind_init_sp);
          deg2rad(a.flightdata.vane_AOA.data(33411));
          deg2rad(a.flightdata.Ahrs1_Pitch.data(33411));
          deg2rad(a.flightdata.Ahrs1_bPitchRate.data(33411))];
 
 
 %% Phugoid motion
 
 
 t_init_ph = [60 00];
 t_init_ph_sec = t_init_ph(1)*60+t_init_ph(2);
 t_ind_init_ph = find(time>t_init_ph_sec,1);
 t_length_ph = t_length_ph*10;
 
 u_ph = delta_e(t_ind_init_ph:(t_ind_init_ph+t_length_ph));
 
 u_ph_rad = deg2rad(u_ph);
 
 t_ph = 0:0.1:25;
 
 % first knots, then ISA units
 u_hat_ph = (Vt_stat-Vt)./Vt;
 u_hat_ph_isa = u_hat_ph * 0.5111111111;
 
 x0_ph = [u_hat_ph_isa(t_ind_init_ph);
          deg2rad(a.flightdata.vane_AOA.data(35919));
          deg2rad(a.flightdata.Ahrs1_Pitch.data(35919));
          deg2rad(a.flightdata.Ahrs1_bPitchRate.data(35919))];

% sample values ss
      
A = [-0.2  0.06  0  -1;             
      0    0     1  0;
     -17   0   -3.8 1;
      9.4  0   -0.4  -0.6];
B = [-0.01  0.06;
      0     0    ;
      -32   5.4  ;
      2.6   -7];
  
B = B(:,2);                     

C = [0 0 0 1];
D = 0;    
 
sys = ss(A,B,C,D);
     
%%%%%%%%%%%%%%%%%%%%% ADD STATE SPACE DATA !!!!!!
    

SP = lsimplot(sys,u_sp_rad,t_sp,x0_sp);

PH = lsimplot(sys,u_ph_rad,t_ph,x0_ph);


