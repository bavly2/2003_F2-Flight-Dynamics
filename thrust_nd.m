file_m1 = fopen('thrust_m1.dat','r') ;
file_m1_s = fopen('thrust_m1_s.dat','r') ;
file_m2 = fopen('thrust_m2.dat','r') ;
file_m2_s = fopen('thrust_m2_s.dat','r') ;
file_m3 = fopen('thrust_m3.dat','r') ;
file_m3_s = fopen('thrust_m3_s.dat','r') ;

formatSpec = '%f %f\r\n' ;
Tp1 = fscanf(file_m1,formatSpec) ;
Tps1 = fscanf(file_m1_s,formatSpec) ;
Tp2 = fscanf(file_m2,formatSpec) ;
Tps2 = fscanf(file_m2_s,formatSpec) ;
Tp3 = fscanf(file_m3,formatSpec) ;
Tps3 = fscanf(file_m3_s,formatSpec) ;

D = 686/1000 ; %propeller diameter [m]

[~, Vred] = Vreducedequivalent() ;
n1 = length(Tp1);
n2 = length(Tp2);
n3 = length(Tp3);
V1 = [];
V2 = [];
V3 = [];

for i = t1:(t1+23.15*10)
    V1 = [V1,Vred(i)] ;
end
for i = t2:(t2+26.3*10)
    V2 = [V2,Vred(i)] ;
end
for i = t3:(t3+29.1*10)
    V3 = [V3,Vred(i)] ;
end

dTc1 = [];
dTc2 = [];
dTc3 = [];

for i = 1:2:n1
    Tcl = Tp1(i)/(rho0*V1(0.5*(i+1))^2*D^2);
    Tcr = Tp1(i+1)/(rho0*V1(0.5*(i+1))^2*D^2);
    Tcsl = Tps1(i)/(rho0*V1(0.5*(i+1))^2*D^2);
    Tcsr = Tps1(i+1)/(rho0*V1(0.5*(i+1))^2*D^2);
    dTc1 = [dTc1,(Tcsl+Tcsr)-(Tcl+Tcr)];
%     fprintf(file_Tc,formatSpec,[Tcl;Tcr]);
%     fprintf(file_Tcs,formatSpec,[Tcsl;Tcsr]);
end
for i = 1:2:n2
    Tcl = Tp2(i)/(rho0*V2(0.5*(i+1))^2*D^2);
    Tcr = Tp2(i+1)/(rho0*V2(0.5*(i+1))^2*D^2);
    Tcsl = Tps2(i)/(rho0*V2(0.5*(i+1))^2*D^2);
    Tcsr = Tps2(i+1)/(rho0*V2(0.5*(i+1))^2*D^2);
    dTc2 = [dTc2,(Tcsl+Tcsr)-(Tcl+Tcr)];
end
for i = 1:2:n3
    Tcl = Tp3(i)/(rho0*V3(0.5*(i+1))^2*D^2);
    Tcr = Tp3(i+1)/(rho0*V3(0.5*(i+1))^2*D^2);
    Tcsl = Tps3(i)/(rho0*V3(0.5*(i+1))^2*D^2);
    Tcsr = Tps3(i+1)/(rho0*V3(0.5*(i+1))^2*D^2);
    dTc3 = [dTc3,(Tcsl+Tcsr)-(Tcl+Tcr)];
end

fclose(file_m1);
fclose(file_m1_s);
% fclose(file_Tc);
% fclose(file_Tcs);