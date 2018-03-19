a = load('FTISxprt-20180306_082856');

run('Cit_par.m')

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

t1 = find(abs(FU_total-716)<0.01);  %index stationary measurements 1
t2 = t1+(41.1-39.5)*10 ;
t3 = t1+(42.3-39.5)*10 ;
t4 = t1+(45.2-39.5)*10 ;
t5 = t1+(47.1-39.5)*10 ;
t6 = t1+(48.5-39.5)*10 ;
t7 = t1+(50.1-39.5)*10 ;

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

fprintf(file,formatSpec,[pressure_altitude(t1);Mach(t1);T_difference(t1);FMF_lh(t1);FMF_rh(t1)]);
fprintf(file,formatSpec,[pressure_altitude(t2);Mach(t2);T_difference(t2);FMF_lh(t2);FMF_rh(t2)]);
fprintf(file,formatSpec,[pressure_altitude(t3);Mach(t3);T_difference(t3);FMF_lh(t3);FMF_rh(t3)]);
fprintf(file,formatSpec,[pressure_altitude(t4);Mach(t4);T_difference(t4);FMF_lh(t4);FMF_rh(t4)]);
fprintf(file,formatSpec,[pressure_altitude(t5);Mach(t5);T_difference(t5);FMF_lh(t5);FMF_rh(t5)]);
fprintf(file,formatSpec,[pressure_altitude(t6);Mach(t6);T_difference(t6);FMF_lh(t6);FMF_rh(t6)]);
fprintf(file,formatSpec,[pressure_altitude(t7);Mach(t7);T_difference(t7);FMF_lh(t7);FMF_rh(t7)]);
fclose(file) ;

