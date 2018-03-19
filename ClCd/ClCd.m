a = load('FTISxprt-20180306_082856');

g0=9.80665;
T0=288.15;
R=287.05;
lmbd=-0.0065;
p0=101325.;
rho0=1.225;
Payload = [95,82,67,71,75,76,78,80,104.5];%NEED CHANGE
BEM = 4157.174;%NEED CHANGE
payload = sum(Payload);
ZFM = BEM + payload;
fuel = 1814.369;
TTmass=ZFM + fuel;
TTW=TTmass*g0;

%Thrust power
FFl=[722 618 512 452 388 435]*0.45359237/3600;
FFr=[761.5 628 538 469 415 458]*0.45359237/3600;

%Aircraft dimensions
S=30.; %m^2
cbar=2.0569; %m
b=15.911; %m
A=b^2/S;

%Data
Hlsti = [13000 12990 13000 12990 12990 13080]*0.3048;
Vcaslsti = ([250 220 191 158 128 120]-2*ones(1,6))*0.5144444;
alphalsti = [1.5333 2.5 3.5 5.5 9 10.3];
Wusedlsti = [458.1667 518 567 588 618 644]*0.45359237*g0;
TATlsti = [-2.2 -4.5 -6.8 -8.8 -10.5 -11.2]+273.15*ones(1,6);
Wlsti=TTW*ones(1,6)-Wusedlsti;
Plsti=[];
for i=1:6
    Pi=pressure(Hlsti(i));
    Plsti=[Plsti,Pi];
end

Machlsti=[];
for i=1:6
    Machi=calculateMach(Plsti(i),Vcaslsti(i));
    Machlsti=[Machlsti,Machi];
end

Tstatlsti=[];
for i=1:6
    Tstati=calculateTstat(TATlsti(i),Machlsti(i));
    Tstatlsti=[Tstatlsti,Tstati];
end

Vtaslsti=[];
for i=1:6
    Vtasi=soundspeed(Tstatlsti(i))*Machlsti(i);
    Vtaslsti=[Vtaslsti,Vtasi];
end

rholsti=[];
for i=1:6
    rhoi=Plsti(i)/(R*Tstatlsti(i));
    rholsti=[rholsti,rhoi];
end

Veaslsti=[];
for i=1:6
    Veasi=Vtaslsti(i)*sqrt(rholsti(i)/rho0);
    Veaslsti=[Veaslsti,Veasi];
end

aeroPlsti=[]
for i=1:6
    AeroP=aerop(rho0,Veaslsti(i),S);
    aeroPlsti=[aeroPlsti,AeroP];
end

Cllsti=[];
for i=1:6
    Cli=calculateCl(Wlsti(i),aeroPlsti(i));
    Cllsti=[Cllsti,Cli];
end

Cl2lsti=[];
for i=1:6
    Cl2i=Cllsti(i)^2;
    Cl2lsti=[Cl2lsti,Cl2i];
end

Tisalsti=288.15*ones(1,6)-0.0065*Hlsti;
deltaTlsti=TATlsti-Tisalsti;

ThrustLlsti=[];
ThrustRlsti=[];
Thrustlsti=[];
for i=1:6
    data=[Hlsti(i) Machlsti(i) deltaTlsti(i) FFl(i) FFr(i)];
    save 'matlab.dat' data -ascii
    system('F:\TU_Delft\Third year\SVV\Assignment 2\thrust(1).exe');
    load thrust.dat;
    ThrustLi=thrust(1);
    ThrustRi=thrust(2);
    Thrusti=ThrustLi+ThrustRi;
    ThrustLlsti=[ThrustLlsti,ThrustLi];
    ThrustRlsti=[ThrustRlsti,ThrustRi];
    Thrustlsti=[Thrustlsti,Thrusti]
end

Cdlsti=[];
for i=1:6
    Cdi=calculateCd(Thrustlsti(i),aeroPlsti(i));
    Cdlsti=[Cdlsti,Cdi];
end

trendlineparaCl=polyfit(alphalsti,Cllsti,1);
trendlineparaCd=polyfit(Cl2lsti,Cdlsti,1);

%Aerodynamic coefficients
Cd0=trendlineparaCd(2);
Clalpha=trendlineparaCl(1);
e=1/(pi*A*trendlineparaCd(1));
disp(['Value of Cl¦Á is ', num2str(Clalpha)])
disp(['Value of Cd0 is ', num2str(Cd0)])
disp(['Value of e is ', num2str(e)])
Wi=TTW;%Initial weight
alpha0=-trendlineparaCl(2)/Clalpha;

alphalst=a.flightdata.vane_AOA.data; %{'Angle of attack'}
Hlst=a.flightdata.Dadc1_alt.data;%{'Pressure Altitude (1013.25 mB)'}
Vtaslst=a.flightdata.Dadc1_tas.data;

Wfuelusedlst=[];
Wfuelused=0;
for i=1:48681
    Wfuelused=Wfuelused+0.45359237*(a.flightdata.lh_engine_FU.data(i)+a.flightdata.rh_engine_FU.data(i));
    Wfuelusedlst=[Wfuelusedlst,Wfuelused];
end
Wfuelusedlst=Wfuelusedlst.';

Tlst=a.flightdata.Dadc1_sat.data;

alpha0lst=alpha0*ones(48681,1);
Cllst=Clalpha*(alphalst-alpha0lst);
Cl2lst=Cllst.*Cllst;
Cdilst=Cl2lst/(pi*A*e);
Cd0lst=Cd0*ones(48681,1);
Cdlst=Cd0lst+Cdilst;

plst=[];
for n=1:48681
    p=pressure(Hlst(n));
    plst=[plst,p];
end

Wlst=Wi*ones(48681,1)-Wfuelusedlst;
rholst=[];
for n=1:48681
    rho=Wlst(n)/(0.5*S*Cllst(n)*Vtaslst(n).^2);
    rholst=[rholst,rho];
end
ax1 = subplot(2,2,1);
ax2 = subplot(2,2,2);
ax3 = subplot(2,2,3);
ax4 = subplot(2,2,4);

plot(ax1,alphalst,Cllst)
title(ax1,'Cl-alpha')
ylabel(ax1,'Cl')

plot(ax2,alphalst,Cdlst);
title(ax2,'Cd-alpha')
ylabel(ax2,'Cd')

plot(ax3,Cdlst,Cllst)
title(ax3,'Cl-Cd')
ylabel(ax3,'Cl')

plot(ax4,Cdlst,Cl2lst)
title(ax4,'Cl^2-Cd')
ylabel(ax4,'Cl^2')
