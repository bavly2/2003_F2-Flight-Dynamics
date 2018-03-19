a = load('FTISxprt-20180306_082856');

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

fprintf(file,formatSpec,[pressure_altitude(t1);Mach(t1);T_difference(t1);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t2);Mach(t2);T_difference(t2);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t3);Mach(t3);T_difference(t3);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t4);Mach(t4);T_difference(t4);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t5);Mach(t5);T_difference(t5);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t6);Mach(t6);T_difference(t6);0.048;0.048]);
fprintf(file,formatSpec,[pressure_altitude(t7);Mach(t7);T_difference(t7);0.048;0.048]);

fclose(file) ;