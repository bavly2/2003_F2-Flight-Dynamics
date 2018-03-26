%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MASTER PROGRAM FOR PLOTTING EIGENMOTION RESPONSES %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

run('statespace2')
run('Eigenmotions_testdata')

%% Symmetric eigenmotions

t_SP = 0:0.1:10;   
t_SP = t_SP(:,1:end-1);                         % defining SP time and removing last colum to make it compatible with u_SP

t_PH = 0:0.1:200;
t_PH = t_PH(:,1:end-1);                         % defining rest of time vectors with the same story as the above

time_phugoid = time(i_start_phugoid);
time_shortp = time(i_start_shortp);
time_Droll = time(i_start_Droll);
time_DrollYD = time(i_start_DrollYD);
time_Aroll = time(i_start_DrollYD);
time_spiral = time(i_start_spiral);

[x0_SP, u_SP, x0_PH, u_PH] = symmetric_eigenmotions2(time_shortp,10,time_phugoid,200);


%------------------------------------- SHORT PERIOD MOTION -----------------------------------------------%
figure

subplot(2,2,1)
a = lsim(syssym_u,u_SP,t_SP,x0_SP);
plot(t_SP,V_shortp,t_SP,a)
title('SP u')

subplot(2,2,2)
a = lsim(syssym_alp,u_SP,t_SP,x0_SP);
plot(t_SP,aoa_shortp,t_SP,a)
title('SP Angle of Attack')

subplot(2,2,3)
a = lsim(syssym_th,u_SP,t_SP,x0_SP);
plot(t_SP,pitch_shortp,t_SP,a)
title('SP Pitch Attitude')

subplot(2,2,4)
a = lsim(syssym_q,u_SP,t_SP,x0_SP);
plot(t_SP,pitchrate_shortp,t_SP,a)
title('SP Pitch Rate')


%------------------------------------- PHUGOID MOTION ----------------------------------------------------%
figure

subplot(2,2,1)
a = lsim(syssym_u,u_PH,t_PH,x0_PH);
plot(t_PH,V_phugoid,t_PH,a)
title('PH u')

subplot(2,2,2)
a = lsim(syssym_alp,u_PH,t_PH,x0_PH);
plot(t_PH,aoa_phugoid,t_PH,a)
title('PH Angle of Attack')

subplot(2,2,3)
a = lsim(syssym_th,u_PH,t_PH,x0_PH);
plot(t_PH,pitch_phugoid,t_PH,a)
title('PH Pitch Attitude')

subplot(2,2,4)
a = lsim(syssym_q,u_PH,t_PH,x0_PH);
plot(t_PH,pitchrate_phugoid,t_PH,a)
title('PH Pitch Rate')

%% Assymmetric eigenmotions



t_DR = 0:0.1:20;
t_DR = t_DR(:,1:end-1);

t_DR_YD = 0:0.1:15;
t_DR_YD = t_DR_YD(:,1:end-1);

t_AR = 0:0.1:25;
t_AR = t_AR(:,1:end-1);

t_SPI = 0:0.1:50;
t_SPI = t_SPI(:,1:end-1);


[x0_DR, u_DR, x0_DR_YD, u_DR_YD, x0_AR, u_AR, x0_SPI, u_SPI ] = asymmetric_eigenmotions(time_Droll,20,time_DrollYD,15,time_Aroll,25,time_spiral,50);

% ------------------------------------ DUTCH ROLL --------------------------------------------------------%

figure 
subplot(3,1,1)
a = lsimplot(sysasym_phi,u_DR,t_DR,x0_DR);
size(a)
plot(t_DR,rollangle_Droll,t_DR,a)
title('DR Roll Angle')

subplot(3,1,2)
a = lsimplot(sysasym_p,u_DR,t_DR,x0_DR);
plot(t_DR,rollrate_Droll,t_DR,a)
title('DR Roll Rate')

subplot(3,1,3)
a = lsimplot(sysasym_r,u_DR,t_DR,x0_DR);
plot(t_DR,yawrate_Droll,t_DR,a)
title('DR Yaw Rate')


% ------------------------------------ DUTCH ROLL YD --------------------------------------------------------%

figure
subplot(3,1,1)
a = lsimplot(sysasym_phi,u_DR_YD,t_DR_YD,x0_DR_YD);
plot(t_DR_YD,rollangle_DrollYD,t_DR_YD,a)
title('DR YD Roll Angle')

subplot(3,1,2)
a = lsimplot(sysasym_p,u_DR_YD,t_DR_YD,x0_DR_YD);
plot(t_DR_YD,rollrate_DrollYD,t_DR_YD,a)
title('DR YD Roll Rate')

subplot(3,1,3)
a = lsimplot(sysasym_r,u_DR_YD,t_DR_YD,x0_DR_YD);
plot(t_DR_YD,yawrate_DrollYD,t_DR_YD,a)
title('DR YD Yaw Rate')



% ------------------------------------ APERIODICAL ROLL --------------------------------------------------------%

figure 
subplot(3,1,1)
a = lsimplot(sysasym_phi,u_AR,t_AR,x0_AR);
plot(t_AR,rollangle_Aroll,t_AR,a)
title('AR Roll Angle')

subplot(3,1,2)
a = lsimplot(sysasym_p,u_AR,t_AR,x0_AR);
plot(t_AR,rollrate_Aroll,t_AR,a)
title('AR Roll Rate')

subplot(3,1,3)
a = lsimplot(sysasym_r,u_AR,t_AR,x0_AR);
plot(t_AR,yawrate_Aroll,t_AR,a)
title('AR Yaw Rate')


% ------------------------------------ SPIRAL --------------------------------------------------------%

figure
subplot(3,1,1)
a = lsimplot(sysasym_phi,u_SPI,t_SPI,x0_SPI);
plot(t_SPI,rollangle_spiral,t_API,a)
title('SPI Roll Angle')

subplot(3,1,2)
a = lsimplot(sysasym_p,u_SPI,t_SPI,x0_SPI);
plot(t_SPI,rollrate_spiral,t_API,a)
title('SPI Roll Rate')

subplot(3,1,3)
a = lsimplot(sysasym_r,u_SPI,t_SPI,x0_SPI);
plot(t_SPI,yawrate_spiral,t_API,a)
title('SPI Yaw Rate')