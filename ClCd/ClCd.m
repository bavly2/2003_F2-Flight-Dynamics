cd 'F:\TU_Delft\Third year\SVV\Assignment 2\ClCd'%Please change path

%Get aerodynamic coefficients
[Clalpha,alpha0,Cd0,e]=CalAeroPara();

a = load('FTISxprt-20180306_082856');%'Need change'

%Constants
g0=9.80665;
T0=288.15;
R=287.05;
lmbd=-0.0065;
p0=101325.;
rho0=1.225;
Payload = [82,95,79,71,71,71,58,78,81];
BEM = 9165*0.45359237;
payload = sum(Payload);
ZFM = BEM + payload;
fuel = 2600*0.45359237;
TTmass=ZFM + fuel;
TTW=TTmass*g0;
S=30.; %m^2
cbar=2.0569; %m
b=15.911; %m
A=b^2/S;

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

Wi=TTW;%Initial weight

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
