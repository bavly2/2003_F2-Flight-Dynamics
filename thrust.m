a = load('FTISxprt-20180320_102524');

run('Cit_par.m');

pressure_altitude = a.flightdata.Dadc1_alt.data ; %ft
Mach = a.flightdata.Dadc1_mach.data ; %C
totalT = a.flightdata.Dadc1_tat.data ; %C
FMF_lh = a.flightdata.lh_engine_FMF.data ; %lbs/hr
FMF_rh = a.flightdata.rh_engine_FMF.data ; %lbs/hr
time = a.flightdata.time.data ; %sec
FU_lh = a.flightdata.lh_engine_FU.data ; %lbs
FU_rh = a.flightdata.rh_engine_FU.data ; %lbs

FU_total = FU_lh + FU_rh ; %lbs
pressure_altitude = pressure_altitude*0.3048 ; %meter
T_ISA = lambda*pressure_altitude + Temp0 - 273.15 ; %C
T_difference = totalT-T_ISA ; %C
FMF_lh = FMF_lh*0.45359237/60^2 ; %kg/s
FMF_rh = FMF_rh*0.45359237/60^2 ; %kg/s

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
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end
% for i = t2:(t2+26.3*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end
% for i = t3:(t3+29.1*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end
% for i = t4:(t4+30.55*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end
% for i = t5:(t5+33.3*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end
% for i = t6:(t6+35.2*10)
%     fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);FMF_lh(i);FMF_rh(i)]);
% end

% fprintf(file,formatSpec,[pressure_altitude(t1);Mach(t1);T_difference(t1);FMF_lh(t1);FMF_rh(t1)]);
% fprintf(file,formatSpec,[pressure_altitude(t2);Mach(t2);T_difference(t2);FMF_lh(t2);FMF_rh(t2)]);
% fprintf(file,formatSpec,[pressure_altitude(t3);Mach(t3);T_difference(t3);FMF_lh(t3);FMF_rh(t3)]);
% fprintf(file,formatSpec,[pressure_altitude(t4);Mach(t4);T_difference(t4);FMF_lh(t4);FMF_rh(t4)]);
% fprintf(file,formatSpec,[pressure_altitude(t5);Mach(t5);T_difference(t5);FMF_lh(t5);FMF_rh(t5)]);
% fprintf(file,formatSpec,[pressure_altitude(t6);Mach(t6);T_difference(t6);FMF_lh(t6);FMF_rh(t6)]);
% fprintf(file,formatSpec,[pressure_altitude(t7);Mach(t7);T_difference(t7);FMF_lh(t7);FMF_rh(t7)]);
% fclose(file) ;

fprintf(file,formatSpec,[ph(1);Mach(t1);dT(1);FMF_l(1);FMF_r(1)]);
fprintf(file,formatSpec,[ph(2);Mach(t2);dT(2);FMF_l(2);FMF_r(2)]);
fprintf(file,formatSpec,[ph(3);Mach(t1);dT(3);FMF_l(3);FMF_r(3)]);
fprintf(file,formatSpec,[ph(4);Mach(t1);dT(4);FMF_l(4);FMF_r(4)]);
fprintf(file,formatSpec,[ph(5);Mach(t1);dT(5);FMF_l(5);FMF_r(5)]);
fprintf(file,formatSpec,[ph(6);Mach(t1);dT(6);FMF_l(6);FMF_r(6)]);
fprintf(file,formatSpec,[ph(7);Mach(t1);dT(7);FMF_l(7);FMF_r(7)]);
fclose(file) ;


