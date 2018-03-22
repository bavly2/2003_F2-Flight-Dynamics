cd 'F:\TU_Delft\Third year\SVV\Assignment 2\ClCd'%Please change path

%Get aerodynamic coefficients
[Clalpha,alpha0,Cd0,e,Remin,Remax,Mmin,Mmax]=CalAeroPara();

a = load('FTISxprt-20180320_102524');%'Need change'
xlsfile='Post_Flight_Datasheet_Flight_2_DD_20_3_2018.xlsx';
sheet=1;

%Constants
g0=9.80665;
T0=288.15;
R=287.05;
lmbd=-0.0065;
p0=101325.;
rho0=1.225;
lambda=1.512041288;
C=120;
Payload = xlsread(xlsfile,1,'H8:H16').';
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
Hlst=a.flightdata.Dadc1_alt.data*0.3048;%{'Pressure Altitude (1013.25 mB)'}
Vtaslst=a.flightdata.Dadc1_tas.data*0.51444;
Vcaslst=a.flightdata.Dadc1_cas.data*0.51444;
lnth=length(Vtaslst);
Tstatlst=a.flightdata.Dadc1_sat.data.'+273.15*ones(1,lnth);

Wfuelusedlst=[];
Wfuelused=0;

%for i=1:lnth
%    Wfuelused=Wfuelused+0.45359237*(a.flightdata.lh_engine_FU.data(i)+a.flightdata.rh_engine_FU.data(i));
%    Wfuelusedlst=[Wfuelusedlst,Wfuelused];
%end
Wfuelusedlst=0.45359237*(a.flightdata.lh_engine_FU.data+a.flightdata.rh_engine_FU.data);
Wfuelusedlst=Wfuelusedlst.'*g0;

Tlst=a.flightdata.Dadc1_sat.data.'+273.15*ones(1,lnth);

alpha0lst=alpha0*ones(lnth,1);
Cllst=Clalpha*(alphalst-alpha0lst);
Cl2lst=Cllst.*Cllst;
Cdilst=Cl2lst/(pi*A*e);
Cd0lst=Cd0*ones(lnth,1);
Cdlst=Cd0lst+Cdilst;

Wi=TTW;%Initial weight

plst=[];
for n=1:lnth;
    p=pressure(Hlst(n));
    plst=[plst,p];
end

Wlst=Wi*ones(1,lnth)-Wfuelusedlst;
rholst=[];
for n=1:lnth
    rho=plst(n)/(R*Tstatlst(n));
    rholst=[rholst,rho];
end

%ax1 = subplot(2,2,1);
%ax2 = subplot(2,2,2);
%ax3 = subplot(2,2,3);
%ax4 = subplot(2,2,4);

%plot(ax1,alphalst,Cllst)
%grid(ax1,'on')
%AX = gca;
%AX.XAxisLocation = 'origin'
%title(ax1,'Cl-alpha')
%ylabel(ax1,'Cl')

%ax.YAxisLocation = 'origin'

%plot(ax2,alphalst,Cdlst)
%grid(ax2,'on')
%AX.XAxisLocation = 'origin'
%title(ax2,'Cd-alpha')
%ylabel(ax2,'Cd')

%plot(ax3,Cdlst,Cllst)
%grid(ax3,'on')
%AX.XAxisLocation = 'origin'
%title(ax3,'Cl-Cd')
%ylabel(ax3,'Cl')

%plot(ax4,Cdlst,Cl2lst)
%grid(ax4,'on')
%AX.XAxisLocation = 'origin'
%title(ax4,'Cl^2-Cd')
%ylabel(ax4,'Cl^2')
%text(0.5,0.98,[num2str(Remin),'<Re<',num2str(Remax)])
figure
plot(alphalst,Cllst)
grid on
box off
AX = gca;
AX.XAxisLocation = 'origin'
AX.YAxisLocation = 'origin'
title(['Cl-alpha, Re \in [' num2str(Remin/10^6) '\cdot 10^6,' num2str(Remax/10^6) '\cdot 10^6], Mach \in [' num2str(Mmin) ',' num2str(Mmax) ']'])
xlabel('\alpha (deg)')
ylabel('Cl (-)')

figure
plot(alphalst,Cdlst)
grid on
box off
AX = gca;
AX.YAxisLocation = 'origin'
title(['Cd-alpha, Re \in [' num2str(Remin/10^6) '\cdot 10^6,' num2str(Remax/10^6) '\cdot 10^6], Mach \in [' num2str(Mmin) ',' num2str(Mmax) ']'])
xlabel('\alpha (deg)')
ylabel('Cd (-)')

figure
plot(Cdlst,Cllst)
grid on
box off
AX = gca;
AX.XAxisLocation = 'origin'
title(['Cl-Cd, Re \in [' num2str(Remin/10^6) '\cdot 10^6,' num2str(Remax/10^6) '\cdot 10^6], Mach \in [' num2str(Mmin) ',' num2str(Mmax) ']'])
xlabel('Cd (-)')
ylabel('Cl (-)')

figure
plot(Cdlst,Cl2lst)
grid on
box off
AX = gca;
AX.XAxisLocation = 'origin'
format shortEng
title(['Cl^2-Cd, Re \in [' num2str(Remin/10^6) '\cdot 10^6,' num2str(Remax/10^6) '\cdot 10^6], Mach \in [' num2str(Mmin) ',' num2str(Mmax) ']' ])
xlabel('Cd (-)')
ylabel('Cl^2')