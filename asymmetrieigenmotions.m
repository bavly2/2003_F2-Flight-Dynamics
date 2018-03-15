%Specify starting times of eigenmotions as: [mm ss]
Dutch_Roll_init_time = [57 04];
Dutch_Roll_YD_init_time = [57 45];
Aper_Roll_init_time = [59 13];
Spiral_init_time = [ 60 4];

%Load data
flightdata = load('FTISxprt-20180306_082856.mat');
flightdata = flightdata.flightdata;

%Time vector
time = flightdata.time.data;
%Roll angles
phi = flightdata.Ahrs1_Roll.data;

%Roll rates
p = flightdata.Ahrs1_bRollRate.data;

%Yaw rates
r = flightdata.Ahrs1_bYawRate.data;

%Calculate initial time of each eigenmotion in seconds
init_time = [ Dutch_Roll_init_time(1)*60+Dutch_Roll_init_time(2) Dutch_Roll_YD_init_time(1)*60+Dutch_Roll_YD_init_time(2) Aper_Roll_init_time(1)*60+Aper_Roll_init_time(2) Spiral_init_time(1)*60+Spiral_init_time(2)];

%Determine index of initital time of each eigenmotion
t_ind = [ find(time>init_time(1),1) find(time>init_time(2),1) find(time>init_time(3),1) find(time>init_time(4),1)];
    
init_values = [ 
    0 0 0 0;
    phi(t_ind(1)) phi(t_ind(2) phi(t_ind(3) phi(t_ind(4);
    p(t_ind(1)) p(t_ind(1)) p(t_ind(1)) p(t_ind(1));
    p(t_ind(1)) p(t_ind(1)) p(t_ind(1)) p(t_ind(1))
    

    
    
      

  
          
          
          
          