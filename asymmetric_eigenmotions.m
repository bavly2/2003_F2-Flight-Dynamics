%Function outputs initial value vector and input vector for every
%eigenmotion in radians. (i.e. x0_DR is the initial value vector for the Dutch Roll. u_DR is the input vector for the Dutch Roll.)
%Input is initial time vector [mm ss] and time length in seconds for each
%eigenmotion. (i.e. t_init_DR is initial time in [mm ss] for the Dutch Roll
%and t_length_DR is the length of the Dutch Roll in seconds.)
function [ x0_DR, u_DR, x0_DR_YD, u_DR_YD, x0_AR, u_AR, x0_SPI, u_SPI ] = asymmetric_eigenmotions(t_init_DR, t_length_DR, t_init_DR_YD, t_length_DR_YD, t_init_AR, t_length_AR, t_init_SPI, t_length_SPI)

%Specify starting times of eigenmotions as: [mm ss]
Dutch_Roll_init_time = t_init_DR;
Dutch_Roll_YD_init_time = t_init_DR_YD;
Aper_Roll_init_time = t_init_AR;
Spiral_init_time = t_init_SPI;

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

x0_DR = init_values(:,1);
x0_DR_YD = init_values(:,2);
x0_AR = init_values(:,3);
x0_SPI = init_values(:,4);

%Length of each eigenmotion in s
t_lengths = [t_length_DR t_length_DR_YD t_length_AR t_length_SPI];
t_lengths = t_lengths*10;

%Time vector for each eigenmotion (in cs/10Hz). First column is first
%eigenmotion second column is second eigenmotion etc.
%t_sample_DR = 1:t_lengths(1);
%t_sample_DR_YD = 1:t_lengths(2);
%t_sample_AR = 1:t_lengths(3);
%t_sample_SPI = 1:t_lengths(4);

%Retrieve inputs
%Inputs Dutch Roll
u_DR = [ delta_e(t_ind(1):(t_ind(1)+t_lengths(1)-1))'; delta_r(t_ind(1):(t_ind(1)+t_lengths(1)-1))' ]; 
%Inputs Dutch Roll YD
u_DR_YD = [ delta_e(t_ind(2):(t_ind(2)+t_lengths(2)-1))'; delta_r(t_ind(2):(t_ind(2)+t_lengths(2)-1))' ];
%Inputs Aperiodic Roll
u_AR = [ delta_e(t_ind(3):(t_ind(3)+t_lengths(3)-1))'; delta_r(t_ind(3):(t_ind(3)+t_lengths(3)-1))' ];
%Inputs Spiral
u_SPI = [ delta_e(t_ind(4):(t_ind(4)+t_lengths(4)-1))'; delta_r(t_ind(4):(t_ind(4)+t_lengths(4)-1))' ];

     