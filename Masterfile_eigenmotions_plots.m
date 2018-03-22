%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MASTER PROGRAM FOR PLOTTING EIGENMOTION RESPONSES %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

run('statespace2')

%% Symmetric eigenmotions

t_SP = 0:0.1:10;   
t_SP = t_SP(:,1:end-1);                         % defining SP time and removing last colum to make it compatible with u_SP

t_PH = 0:0.1:200;
t_PH = t_PH(:,1:end-1);                         % defining rest of time vectors with the same story as the above


[x0_SP, u_SP, x0_PH, u_PH] = symmetric_eigenmotions2([50 05],10,[51 48],200);


%------------------------------------- SHORT PERIOD MOTION -----------------------------------------------%
figure

subplot(2,2,1)
lsim(syssym_u_hat,u_SP,t_SP,x0_SP)
title('SP Dimensionless Speed')

subplot(2,2,2)
lsim(syssym_alp,u_SP,t_SP,x0_SP)
title('SP Angle of Attack')

subplot(2,2,3)
lsim(syssym_th,u_SP,t_SP,x0_SP)
title('SP Pitch Attitude')

subplot(2,2,4)
lsim(syssym_q,u_SP,t_SP,x0_SP)
title('SP Pitch Rate')


%------------------------------------- PHUGOID MOTION ----------------------------------------------------%
figure

subplot(2,2,1)
lsim(syssym_u_hat,u_PH,t_PH,x0_PH)
title('PH Dimensionless Speed')

subplot(2,2,2)
lsim(syssym_alp,u_PH,t_PH,x0_PH)
title('PH Angle of Attack')

subplot(2,2,3)
lsim(syssym_th,u_PH,t_PH,x0_PH)
title('PH Pitch Attitude')

subplot(2,2,4)
lsim(syssym_q,u_PH,t_PH,x0_PH)
title('PH Pitch Rate')

%% Assymmetric eigenmotions



t_DR = 0:0.1:50;
t_DR = t_DR(:,1:end-1);

t_DR_YD = 0:0.1:15;
t_DR_YD = t_DR_YD(:,1:end-1);

t_AR = 0:0.1:25;
t_AR = t_AR(:,1:end-1);

t_SPI = 0:0.1:50;
t_SPI = t_SPI(:,1:end-1);


[x0_DR, u_DR, x0_DR_YD, u_DR_YD, x0_AR, u_AR, x0_SPI, u_SPI ] = asymmetric_eigenmotions([55 23],50,[56 26],15,[49 00],25,[58 00],50);

% ------------------------------------ DUTCH ROLL --------------------------------------------------------%

figure
subplot(2,2,1)
lsimplot(sysasym_beta,u_DR,t_DR,x0_DR)
title('DR Sideslip Angle') 

subplot(2,2,2)
lsimplot(sysasym_phi,u_DR,t_DR,x0_DR)
title('DR Roll Angle')

subplot(2,2,3)
lsimplot(sysasym_p,u_DR,t_DR,x0_DR)
title('DR Roll Rate')

subplot(2,2,4)
lsimplot(sysasym_r,u_DR,t_DR,x0_DR)
title('DR Yaw Rate')


% ------------------------------------ DUTCH ROLL YD --------------------------------------------------------%

figure
subplot(2,2,1)
lsimplot(sysasym_beta,u_DR_YD,t_DR_YD,x0_DR_YD)
title('DR YD Sideslip Angle') 

subplot(2,2,2)
lsimplot(sysasym_phi,u_DR_YD,t_DR_YD,x0_DR_YD)
title('DR YD Roll Angle')

subplot(2,2,3)
lsimplot(sysasym_p,u_DR_YD,t_DR_YD,x0_DR_YD)
title('DR YD Roll Rate')

subplot(2,2,4)
lsimplot(sysasym_r,u_DR_YD,t_DR_YD,x0_DR_YD)
title('DR YD Yaw Rate')



% ------------------------------------ APERIODICAL ROLL --------------------------------------------------------%

figure
subplot(2,2,1)
lsimplot(sysasym_beta,u_AR,t_AR,x0_AR)
title('AR Sideslip Angle') 

subplot(2,2,2)
lsimplot(sysasym_phi,u_AR,t_AR,x0_AR)
title('AR Roll Angle')

subplot(2,2,3)
lsimplot(sysasym_p,u_AR,t_AR,x0_AR)
title('AR Roll Rate')

subplot(2,2,4)
lsimplot(sysasym_r,u_AR,t_AR,x0_AR)
title('AR Yaw Rate')


% ------------------------------------ SPIRAL --------------------------------------------------------%

figure
subplot(2,2,1)
lsimplot(sysasym_beta,u_SPI,t_SPI,x0_SPI)
title('SPI Sideslip Angle') 

subplot(2,2,2)
lsimplot(sysasym_phi,u_SPI,t_SPI,x0_SPI)
title('SPI Roll Angle')

subplot(2,2,3)
lsimplot(sysasym_p,u_SPI,t_SPI,x0_SPI)
title('SPI Roll Rate')

subplot(2,2,4)
lsimplot(sysasym_r,u_SPI,t_SPI,x0_SPI)
title('SPI Yaw Rate')