%Specify starting times of eigenmotions as: [mm ss]
Dutch_Roll_init_time = [57 00];
Dutch_Roll_YD_init_time = [57 45];
Aper_Roll_init_time = [59 13];
Spiral_init_time = [ 60 4];

%Load flight test data and import parameter vectors
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

%Time vector in s
time = flightdata.time.data;
%Roll angles in rad
phi = deg2rad(flightdata.Ahrs1_Roll.data);
%Roll rates in rad/s
p = deg2rad(flightdata.Ahrs1_bRollRate.data);
%Yaw rates in rad/s
r = deg2rad(flightdata.Ahrs1_bYawRate.data);
%Elevator deflections in rad
delta_e = deg2rad(flightdata.delta_e.data);
%Rudder deflections in rad
delta_r = deg2rad(flightdata.delta_r.data);


%Calculate initial time of each eigenmotion in seconds
init_time = [ Dutch_Roll_init_time(1)*60+Dutch_Roll_init_time(2) Dutch_Roll_YD_init_time(1)*60+Dutch_Roll_YD_init_time(2) Aper_Roll_init_time(1)*60+Aper_Roll_init_time(2) Spiral_init_time(1)*60+Spiral_init_time(2)];

%Determine index of initital time of each eigenmotion
t_ind = [ find(time>init_time(1),1) find(time>init_time(2),1) find(time>init_time(3),1) find(time>init_time(4),1)];

%Initial values matrix. Column depicts respective eigenmotion and row the
%parameter (Sideslip, Roll, Roll rate, Yaw rate)
init_values = [ 
    0 0 0 0;
    phi(t_ind(1)) phi(t_ind(2)) phi(t_ind(3)) phi(t_ind(4));
    p(t_ind(1)) p(t_ind(2)) p(t_ind(3)) p(t_ind(4));
    r(t_ind(1)) r(t_ind(2)) r(t_ind(3)) r(t_ind(4))
    ];

%Length of each eigenmotion in s
t_lengths = [40 75 50 80];
t_lengths = t_lengths*10;

%Time vector for each eigenmotion (in cs/10Hz). First column is first
%eigenmotion second column is second eigenmotion etc.
t_sample_DR = 1:t_lengths(1);
t_sample_DR_YD = 1:t_lengths(2);
t_sample_AR = 1:t_lengths(3);
t_sample_SPI = 1:t_lengths(4);

%Retrieve inputs
%Inputs Dutch Roll
inputs_DR = [ delta_e(t_ind(1):(t_ind(1)+t_lengths(1)-1))'; delta_r(t_ind(1):(t_ind(1)+t_lengths(1)-1))' ]; 
%Inputs Dutch Roll YD
inputs_DR_YD = [ delta_e(t_ind(2):(t_ind(2)+t_lengths(2)-1))'; delta_r(t_ind(2):(t_ind(2)+t_lengths(2)-1))' ];
%Inputs Aperiodic Roll
inputs_AR = [ delta_e(t_ind(3):(t_ind(3)+t_lengths(3)-1))'; delta_r(t_ind(3):(t_ind(3)+t_lengths(3)-1))' ];
%Inputs Spiral
inputs_SPI = [ delta_e(t_ind(4):(t_ind(4)+t_lengths(4)-1))'; delta_r(t_ind(4):(t_ind(4)+t_lengths(4)-1))' ];


plot(t_sample_SPI/10, inputs_SPI);
ylabel('Deflection in radians')
xlabel('time in s')
legend('Aileron','Rudder')
title('Dutch Roll')
          
          