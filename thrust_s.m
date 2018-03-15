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

t1 = find(abs(FU_total-458.17)<0.01);  %index stationary measurements 1
t2 = find(abs(FU_total-518)<0.0172) ;
t3 = find(abs(FU_total-567)<0.01) ;
t4 = find(abs(FU_total-588)<0.01) ;
t5 = find(abs(FU_total-618)<0.01) ;
t6 = find(abs(FU_total-644)<0.01) ;

file = fopen('matlab.dat','w') ;
formatSpec = '%f %f %f %f %f\r\n' ;

m = length(Mach) ;

for i = t1:(t1+23.15*10)
    fprintf(file,formatSpec,[pressure_altitude(i);Mach(i);T_difference(i);0.048;0.048]);
end
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

fclose(file) ;