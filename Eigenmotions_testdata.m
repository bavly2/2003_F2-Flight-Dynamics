a = load('FTISxprt-20180306_082856');

t_phugoid = 150; %sec, duration of the phugoid
t_shortp = 7;
t_spiral = 100;

time = a.flightdata.time.data ; %sec
pitchangle = a.flightdata.Ahrs1_Pitch.data ; %deg
rollangle = a.flightdata.Ahrs1_Roll.data ; %deg
TAS = a.flightdata.Dadc1_tas.data*0.514444444 ; %
aoa = a.flightdata.vane_AOA.data ; %deg
rollrate = a.flightdata.Ahrs1_bRollRate.data; %
pitchrate = a.flightdata.Ahrs1_bPitchRate.data; %
yawrate = a.flightdata.Ahrs1_bYawRate.data; %

%elevator, aileron and rudder deflection

delta_e = a.flightdata.delta_e.data;
delta_a = a.flightdata.delta_a.data;
delta_r = a.flightdata.delta_r.data;
de = [];
da = [];
dr = [];

for i = 1:length(delta_e)-1
    slope_e = (delta_e(i+1)-delta_e(i))/0.1;
    de = [de,slope_e];
end
for i = 1:length(delta_a)-1
    slope_a = (delta_a(i+1)-delta_a(i))/0.1;
    da = [da,slope_a];
end
for i = 1:length(delta_r)-1
    slope_r = (delta_r(i+1)-delta_r(i))/0.1;
    dr = [dr,slope_r];
end

start_phugoid = 60*60 + 48 ; %min:sec
start_shortp = 55*60 + 50 ;
start_Droll = 57*60 + 4 ;
start_DrollYD = 57*60 + 45 ;
start_Aroll = 59*60 + 13 ;
start_spiral = 64*60 + 57 ;

%phugoid plots

%check start elevator input

i_phugoid = find(abs(time-start_phugoid)<0.001); %index number where the phugoid starts
range = (i_phugoid-100:i_phugoid+99);
minde_phugoid = min(de(range));
i_start_phugoid = find(de==minde_phugoid);

time_phugoid = (1:t_phugoid*10)/10;
pitch_phugoid = pitchangle(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);
V_phugoid = TAS(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);
aoa_phugoid = aoa(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);
pitchrate_phugoid = pitchrate(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);

phugoid1 = subplot(2,2,1);
plot(phugoid1,time_phugoid,pitch_phugoid)
xlabel(phugoid1,'t [sec]')
ylabel(phugoid1,'theta [deg]')
title(phugoid1,'Phugoid')

phugoid2 = subplot(2,2,2);
plot(phugoid2,time_phugoid,V_phugoid)
xlabel(phugoid2,'t [sec]')
ylabel(phugoid2,'V [m/s]')

phugoid3 = subplot(2,2,3);
plot(phugoid3,time_phugoid,aoa_phugoid)
xlabel(phugoid3,'t [sec]')
ylabel(phugoid3,'alpha [m/s]')

phugoid4 = subplot(2,2,4);
plot(phugoid4,time_phugoid,pitchrate_phugoid)
xlabel(phugoid4,'t [sec]')
ylabel(phugoid4,'q [deg/s]')
figure()

%short period plots

%check start elevator input

i_shortp = find(abs(time-start_shortp)<0.001); %index number where the phugoid starts
range = (i_shortp-100:i_shortp+99);
% plot(time(range),delta_e(range))
% figure()
minde_shortp = min(de(range));
i_start_shortp = find(de==minde_shortp);

time_shortp = (1:t_shortp*10)/10;
pitch_shortp = pitchangle(i_start_shortp:i_start_shortp+t_shortp*10-1);
% V_phugoid = TAS(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);
% aoa_phugoid = aoa(i_start_phugoid:i_start_phugoid+t_phugoid*10-1);
pitchrate_shortp = pitchrate(i_start_shortp:i_start_shortp+t_shortp*10-1);

shortp1 = subplot(2,1,1);
plot(shortp1,time_shortp,pitch_shortp)
xlabel(shortp1,'t [sec]')
ylabel(shortp1,'theta [deg]')
title(shortp1,'Short period')

% shortp2 = subplot(2,1,2);
% plot(shortp2,time_shortp,de(i_start_shortp:i_start_shortp+t_shortp*10-1))

shortp2 = subplot(2,1,2);
plot(shortp2,time_shortp,pitchrate_shortp)
xlabel(shortp2,'t [sec]')
ylabel(shortp2,'q [deg]')

figure()

% Dutch roll plots

% Aperiodic roll plots

% Spiral plots

% check start aileron input

i_spiral = find(abs(time-start_spiral)<0.001); %index number where the phugoid starts
range = (i_spiral-200:i_spiral+99);
maxda_spiral = max(da(range));
i_start_spiral = find(da==maxda_spiral);

time_spiral = (1:t_spiral*10)/10;
rollangle_spiral = rollangle(i_start_spiral:i_start_spiral+t_spiral*10-1);

spiral1 = subplot(1,1,1);
plot(spiral1,time_spiral,rollangle_spiral)
xlabel(spiral1,'t [sec]')
ylabel(spiral1,'roll angle [deg]')


