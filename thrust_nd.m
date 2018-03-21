function dTc = thrust_nd(tind)

rho0 = 1.225; %Standard density in kg/m^3

file = fopen('thrust_mETC.dat','r') ;
file_s = fopen('thrust_mETC_s.dat','r') ;

formatSpec = '%f %f\r\n' ;
Tp = fscanf(file,formatSpec) ;
Tps = fscanf(file_s,formatSpec) ;

D = 686/1000 ; %propeller diameter [m]

[~, Vred] = Vreducedequivalent() ;
n = length(Tp);

t1 = tind(1);
t2 = tind(2);
t3 = tind(3);
t4 = tind(4);
t5 = tind(5);
t6 = tind(6);
t7 = tind(7);
V = [Vred(t1),Vred(t2),Vred(t3),Vred(t4),Vred(t5),Vred(t6),Vred(t7)];
dTc = [];

for i = 1:2:n
    Tcl = Tp(i)/(rho0*V(0.5*(i+1))^2*D^2);
    Tcr = Tp(i+1)/(rho0*V(0.5*(i+1))^2*D^2);
    Tcsl = Tps(i)/(rho0*V(0.5*(i+1))^2*D^2);
    Tcsr = Tps(i+1)/(rho0*V(0.5*(i+1))^2*D^2);
    dTc = [dTc,(Tcsl+Tcsr)-(Tcl+Tcr)];
%     fprintf(file_Tc,formatSpec,[Tcl;Tcr]);
%     fprintf(file_Tcs,formatSpec,[Tcsl;Tcsr]);
end

fclose(file);
fclose(file_s);
% fclose(file_Tc);
% fclose(file_Tcs);