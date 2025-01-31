a = load('FTISxprt-20180320_102524');

run('start_index_plots')

time = a.flightdata.time.data ; %sec
pitchangle = a.flightdata.Ahrs1_Pitch.data ; %deg
rollangle = a.flightdata.Ahrs1_Roll.data ; %deg
TAS = a.flightdata.Dadc1_tas.data*0.514444444 ; %
aoa = a.flightdata.vane_AOA.data ; %deg
rollrate = a.flightdata.Ahrs1_bRollRate.data; %
pitchrate = a.flightdata.Ahrs1_bPitchRate.data; %
yawrate = a.flightdata.Ahrs1_bYawRate.data; %

%elevator, aileron and rudder deflection

% delta_e = a.flightdata.delta_e.data;
% delta_a = a.flightdata.delta_a.data;
% delta_r = a.flightdata.delta_r.data;
% % de = [];
% % da = [];
% % dr = [];
% 
% for i = 1:length(delta_e)-1
%     slope_e = (delta_e(i+1)-delta_e(i))/0.1;
%     de = [de,slope_e];
% end
% for i = 1:length(delta_a)-1
%     slope_a = (delta_a(i+1)-delta_a(i))/0.1;
%     da = [da,slope_a];
% end
% for i = 1:length(delta_r)-1
%     slope_r = (delta_r(i+1)-delta_r(i))/0.1;
%     dr = [dr,slope_r];
% end


%%phugoid plots

%check start elevator input

% i_phugoid = find(abs(time-start_phugoid)<0.001); %index number where the eigenmotion starts
% range = (i_phugoid-100:i_phugoid+99);
% minde_phugoid = min(de(range));
% i_start_phugoid = find(de==minde_phugoid);

%time_phugoid = (1:t_phugoid*10)/10;
pitch_phugoid = pitchangle(i_start_PH:i_start_PH+length_phugoid*10);
V_phugoid = TAS(i_start_PH:i_start_PH+length_phugoid*10)-TAS(5904);
aoa_phugoid = aoa(i_start_PH:i_start_PH+length_phugoid*10);
pitchrate_phugoid = pitchrate(i_start_PH:i_start_PH+length_phugoid*10);

% phugoid1 = subplot(2,2,1);
% plot(phugoid1,time_phugoid,pitch_phugoid);
% xlabel(phugoid1,'t [sec]');
% ylabel(phugoid1,'theta [deg]');
% title(phugoid1,'Phugoid');
% 
% phugoid2 = subplot(2,2,2);
% plot(phugoid2,time_phugoid,V_phugoid);
% xlabel(phugoid2,'t [sec]');
% ylabel(phugoid2,'V [m/s]');
% 
% phugoid3 = subplot(2,2,3);
% plot(phugoid3,time_phugoid,aoa_phugoid);
% xlabel(phugoid3,'t [sec]');
% ylabel(phugoid3,'alpha [deg]');
% 
% phugoid4 = subplot(2,2,4);
% plot(phugoid4,time_phugoid,pitchrate_phugoid);
% xlabel(phugoid4,'t [sec]');
% ylabel(phugoid4,'q [deg/s]');
% figure();

%short period plots

%check start elevator input

% i_shortp = find(abs(time-start_shortp)<0.001); %index number where the eigenmotion starts
% range = (i_shortp-100:i_shortp+99);
% % plot(time(range),delta_e(range))
% % figure()
% minde_shortp = min(de(range));
% i_start_shortp = find(de==minde_shortp);

%time_shortp = (1:t_shortp*10)/10;
pitch_shortp = pitchangle(i_start_SP:i_start_SP+length_shortp*10);
V_shortp = -TAS(5904)+TAS(i_start_SP:i_start_SP+length_shortp*10);
aoa_shortp = aoa(i_start_SP:i_start_SP+length_shortp*10);
pitchrate_shortp = pitchrate(i_start_SP:i_start_SP+length_shortp*10);

% shortp1 = subplot(2,2,1);
% plot(shortp1,time_shortp,pitch_shortp);
% xlabel(shortp1,'t [sec]');
% ylabel(shortp1,'theta [deg]');
% title(shortp1,'Short period');
% 
% % shortp2 = subplot(2,1,2);
% % plot(shortp2,time_shortp,de(i_start_shortp:i_start_shortp+t_shortp*10-1))
% 
% shortp2 = subplot(2,2,2);
% plot(shortp2,time_shortp,pitchrate_shortp);
% xlabel(shortp2,'t [sec]');
% ylabel(shortp2,'q [deg/s]');
% 
% shortp3 = subplot(2,2,3);
% plot(shortp3,time_shortp,aoa_shortp);
% xlabel(shortp3,'t [sec]');
% ylabel(shortp3,'alpha [deg]');
% 
% shortp4 = subplot(2,2,4);
% plot(shortp4,time_shortp,V_shortp);
% xlabel(shortp4,'t [sec]');
% ylabel(shortp4,'V [m/s]');
% 
% figure();

% Dutch roll plots

% i_Droll = find(abs(time-start_Droll)<0.001); %index number where the eigenmotion starts
% range = (i_Droll-200:i_Droll+99);
% maxdr_Droll = max(dr(range));
% i_start_Droll = find(dr==maxdr_Droll);

%time_Droll = (1:t_Droll*10)/10;
rollangle_Droll = rollangle(i_start_DR:i_start_DR+length_Droll*10);
rollrate_Droll = rollrate(i_start_DR:i_start_DR+length_Droll*10);
yawrate_Droll = yawrate(i_start_DR:i_start_DR+length_Droll*10);

% Droll1 = subplot(3,2,1);
% plot(Droll1,time_Droll,rollangle_Droll);
% xlabel(Droll1,'t [sec]');
% ylabel(Droll1,'roll angle [deg]');
% title(Droll1,'Dutch roll');
% 
% Droll2 = subplot(3,2,3);
% plot(Droll2,time_Droll,rollrate_Droll);
% xlabel(Droll2,'t [sec]');
% ylabel(Droll2,'roll rate [deg/s]');
% 
% Droll3 = subplot(3,2,5);
% plot(Droll3,time_Droll,yawrate_Droll);
% xlabel(Droll3,'t [sec]');
% ylabel(Droll3,'yaw rate [deg/s]');

% compare with the yaw demper

% i_DrollYD = find(abs(time-start_DrollYD)<0.001); %index number where the eigenmotion starts
% range = (i_DrollYD-200:i_DrollYD+99);
% maxdr_DrollYD = max(dr(range));
% i_start_DrollYD = find(dr==maxdr_DrollYD);

%time_DrollYD = (1:t_DrollYD*10)/10;
rollangle_DrollYD = rollangle(i_start_DR_YD:i_start_DR_YD+length_DrollYD*10);
rollrate_DrollYD = rollrate(i_start_DR_YD:i_start_DR_YD+length_DrollYD*10);
yawrate_DrollYD = yawrate(i_start_DR_YD:i_start_DR_YD+length_DrollYD*10);

% DrollYD1 = subplot(3,2,2);
% plot(DrollYD1,time_DrollYD,rollangle_DrollYD);
% xlabel(DrollYD1,'t [sec]');
% ylabel(DrollYD1,'roll angle [deg]');
% title(DrollYD1,'Dutch roll YD');
% 
% DrollYD2 = subplot(3,2,4);
% plot(DrollYD2,time_DrollYD,rollrate_DrollYD);
% xlabel(DrollYD2,'t [sec]');
% ylabel(DrollYD2,'roll rate [deg/s]');
% 
% DrollYD3 = subplot(3,2,6);
% plot(DrollYD3,time_DrollYD,yawrate_DrollYD);
% xlabel(DrollYD3,'t [sec]');
% ylabel(DrollYD3,'yaw rate [deg/s]');
% 
% figure();

% Aperiodic roll plots

% i_Aroll = find(abs(time-start_Aroll)<0.001); %index number where the eigenmotion starts
% range = (i_Aroll-200:i_Aroll+99);
% maxda_Aroll = max(da(range));
% i_start_Aroll = find(da==maxda_Aroll);
% % plot(delta_a(i_start_Aroll:i_start_Aroll+t_Aroll*10-1))
% % figure()

%time_Aroll = (1:t_Aroll*10)/10;
rollangle_Aroll = rollangle(i_start_AR:i_start_AR+length_Aroll*10);
rollrate_Aroll = rollrate(i_start_AR:i_start_AR+length_Aroll*10);
yawrate_Aroll = yawrate(i_start_AR:i_start_AR+length_Aroll*10);

% Aroll1 = subplot(3,1,1);
% plot(Aroll1,time_Aroll,rollangle_Aroll);
% xlabel(Aroll1,'t [sec]');
% ylabel(Aroll1,'roll angle [deg]');
% title(Aroll1,'Aperiodic roll');
% 
% Aroll2 = subplot(3,1,2);
% plot(Aroll2,time_Aroll,rollrate_Aroll);
% xlabel(Aroll2,'t [sec]');
% ylabel(Aroll2,'roll rate [deg/s]');
% 
% Aroll3 = subplot(3,1,3);
% plot(Aroll3,time_Aroll,yawrate_Aroll);
% xlabel(Aroll3,'t [sec]');
% ylabel(Aroll3,'yaw rate [deg/s]');
% 
% figure();

% Spiral plots

% check start aileron input

% i_spiral = find(abs(time-start_spiral)<0.001); %index number where the eigenmotion starts
% range = (i_spiral-200:i_spiral+99);
% maxda_spiral = max(da(range));
% i_start_spiral = find(da==maxda_spiral);

%time_spiral = (1:t_spiral*10)/10;
rollangle_spiral = rollangle(i_start_SPI:i_start_SPI+length_spiral*10);
rollrate_spiral = rollrate(i_start_SPI:i_start_SPI+length_spiral*10);
yawrate_spiral = yawrate(i_start_SPI:i_start_SPI+length_spiral*10);

% spiral1 = subplot(3,1,1);
% plot(spiral1,time_spiral,rollangle_spiral);
% xlabel(spiral1,'t [sec]');
% ylabel(spiral1,'roll angle [deg]');
% title(spiral1,'Spiral');
% 
% spiral2 = subplot(3,1,2);
% plot(spiral2,time_spiral,rollrate_spiral);
% xlabel(spiral2,'t [sec]');
% ylabel(spiral2,'roll rate [deg/s]');
% 
% spiral3 = subplot(3,1,3);
% plot(spiral3,time_spiral,yawrate_spiral);
% xlabel(spiral3,'t [sec]');
% ylabel(spiral3,'yaw rate [deg/s]');
