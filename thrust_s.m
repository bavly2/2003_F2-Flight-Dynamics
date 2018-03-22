a = load('FTISxprt-20180320_102524');

pressure_altitude = a.flightdata.Dadc1_alt.data ; %ft
Mach = a.flightdata.Dadc1_mach.data ; %C
totalT = a.flightdata.Dadc1_tat.data ; %C
time = a.flightdata.time.data ; %sec
FU_lh = a.flightdata.lh_engine_FU.data ; %lbs
FU_rh = a.flightdata.rh_engine_FU.data ; %lbs

FU_total = FU_lh + FU_rh ; %lbs
pressure_altitude = pressure_altitude*0.3048 ; %meter
T_ISA = lambda*pressure_altitude + Temp0 - 273.15 ; %C
T_difference = totalT-T_ISA ; %C

t1 = find(abs(time-(29*60+52))<0.01);  %index stationary measurements 1
t2 = find(abs(time-(32*60+21))<0.01);
t3 = find(abs(time-(34*60+20))<0.01);
t4 = find(abs(time-(36*60+38))<0.01);
t5 = find(abs(time-(39*60+47))<0.01);
t6 = find(abs(time-(41*60+30))<0.01);
t7 = find(abs(time-(43*60+22))<0.01);

ph = [6940,7050,7370,7720,6770,6250,5370]*0.3048;
T = [-6.2,-7,-7.8,-8.5,-5,-3.5,-1.5];
T_ISA = lambda*ph + Temp0 - 273.15 ;
dT = T-T_ISA;
FMF_l = [426,422,418,412,430,438,448]*0.45359237/60^2 ;
FMF_r = [460,457,452,444,464,470,481]*0.45359237/60^2 ;

file = fopen('matlab.dat','w') ;
formatSpec = '%f %f %f %f %f\r\n' ;

m = length(Mach) ;

% for i = t1:(t1+23.15*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end
% for i = t2:(t2+26.3*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end
% for i = t3:(t3+29.1*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end
% for i = t4:(t4+30.55*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end
% for i = t5:(t5+33.3*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end
% for i = t6:(t6+35.2*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
% end

fprintf(file,formatSpec,[ph(1);Mach(t1);dT(1);0.048;0.048]);
fprintf(file,formatSpec,[ph(2);Mach(t2);dT(2);0.048;0.048]);
fprintf(file,formatSpec,[ph(3);Mach(t1);dT(3);0.048;0.048]);
fprintf(file,formatSpec,[ph(4);Mach(t1);dT(4);0.048;0.048]);
fprintf(file,formatSpec,[ph(5);Mach(t1);dT(5);0.048;0.048]);
fprintf(file,formatSpec,[ph(6);Mach(t1);dT(6);0.048;0.048]);
fprintf(file,formatSpec,[ph(7);Mach(t1);dT(7);0.048;0.048]);
fclose(file) ;
