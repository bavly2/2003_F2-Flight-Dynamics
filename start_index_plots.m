a = load('FTISxprt-20180320_102524');

start_phugoid = 51*60 + 48 ; %min:sec, from the post flight data sheet
start_shortp = 50*60 + 10 ;
start_Droll = 55*60 + 23 ;
start_DrollYD = 56*60 + 26 ;
start_Aroll = 49*60 + 00 ;
start_spiral = 58*60 + 00 ;

length_phugoid = 200; %sec, duration of the eigenmotion
length_shortp = 10;
length_spiral = 50;
length_Droll = 20;
length_DrollYD = 15;
length_Aroll = 10;

t_PH = 0:0.1:length_phugoid;
t_SP = 0:0.1:length_shortp;
t_SPI = 0:0.1:length_spiral;
t_DR = 0:0.1:length_Droll;
t_DR_YD = 0:0.1:length_DrollYD;
t_AR = 0:0.1:length_Aroll;

time = a.flightdata.time.data ; %sec

i_start_PH = find(start_phugoid==time);
i_start_SP = find(start_shortp==time);
i_start_DR = find(start_Droll==time);
i_start_DR_YD = find(start_DrollYD==time);
i_start_AR = find(start_Aroll==time);
i_start_SPI = find(start_spiral==time);

