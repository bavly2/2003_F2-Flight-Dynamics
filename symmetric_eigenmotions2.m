%Function outputs initial value vector and input vector for every
%eigenmotion in radians. (i.e. x0_SP is the initial value vector for the Short Period. u_SP is the input vector for the Short Period.)
%Input is initial time vector [mm ss] and time length in seconds for each
%eigenmotion. (i.e. t_init_SP is initial time in [mm ss] for the Short
%Period
%and t_length_SP is the length of the Short Period in seconds.)
function [ x0_SP, u_SP, x0_PH, u_PH] = symmetric_eigenmotions2(t_init_SP, t_length_SP, t_init_PH, t_length_PH)

%Specify starting times of eigenmotions as: [mm ss]
Short_Period_init_time = t_init_SP;
Phugoid_init_time = t_init_PH;
run('Eigenmotions_testdata')

%Load flight test data and import parameter vectors
flightdata = load('FTISxprt-20180320_102524.mat');
flightdata = flightdata.flightdata;

%Time vector in s
time = flightdata.time.data;
%Angle of attack in rad
alpha = flightdata.vane_AOA.data;
%Pitch attitude in rad/s
theta = flightdata.Ahrs1_Pitch.data;
%Pitch rates in rad/s
q = flightdata.Ahrs1_bPitchRate.data;
%Elevator deflections in rad
delta_e = flightdata.delta_e.data;
%Velocity in m/s
V = (flightdata.Dadc1_tas.data)*.51444444444444;


%Calculate initial time of each eigenmotion in seconds
init_time = [t_init_SP t_init_PH];

%Determine index of initital time of each eigenmotion
t_ind = [find(time==init_time(1)) find(time==init_time(2),1)];

u_1 = (V(t_ind(1))-V(5904));
u_2 = (V(t_ind(2))-V(5904));


%Initial values matrix. Column depicts respective eigenmotion and row the
%parameter (Dimensionless speed, Angle of Attack, Pitch attitude, Pitch rate)
init_values = [ 
    u_1 u_2;
    alpha(t_ind(1)) alpha(t_ind(2)) ;
    theta(t_ind(1)) theta(t_ind(2)) ;
    q(t_ind(1)) q(t_ind(2))
    ];

x0_SP = init_values(:,1);
x0_PH = init_values(:,2);

%Length of each eigenmotion in s
t_lengths = [t_length_SP t_length_PH];
t_lengths = t_lengths*10;

%Time vector for each eigenmotion (in cs/10Hz). First column is first
%eigenmotion second column is second eigenmotion etc.
%t_sample_SP = 1:t_lengths(1);
%t_sample_PH = 1:t_lengths(2);


%Retrieve inputs
%Inputs Short Period
u_SP = [ delta_e(t_ind(1):(t_ind(1)+t_lengths(1)))]; 
%Inputs Phugoid
u_PH = [ delta_e(t_ind(2):(t_ind(2)+t_lengths(2)))];

    