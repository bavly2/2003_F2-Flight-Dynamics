function [Clalpha,alpha0,Cd0,e,Remin,Remax,Mmin,Mmax]=CalAeroPara()

g0=9.80665;
T0=288.15;
R=287.05;
lmbd=-0.0065;
p0=101325.;
rho0=1.225;
lambda=1.512041288;
C=120;
Payload = [82,95,79,71,71,71,58,78,81];
BEM = 9165*0.45359237;
payload = sum(Payload);
ZFM = BEM + payload;
fuel = 2600*0.45359237;
TTmass=ZFM + fuel;
TTW=TTmass*g0;

xlsfile='Post_Flight_Datasheet_Flight_2_DD_20_3_2018.xlsx';
sheet=1;


%Thrust power
FFl=xlsread(xlsfile,1,'G28:G33').'*0.45359237/3600;
FFr=xlsread(xlsfile,1,'H28:H33').'*0.45359237/3600;

%Aircraft dimensions
S=30.; %m^2
cbar=2.0569; %m
b=15.911; %m
A=b^2/S;

%Data
Hlsti = xlsread(xlsfile,1,'D28:D33').'*0.3048;
Vcaslsti = (xlsread(xlsfile,1,'E28:E33').'-2*ones(1,6))*0.5144444;
alphalsti = xlsread(xlsfile,1,'F28:F33').';
Wusedlsti = xlsread(xlsfile,1,'I28:I33').'*0.45359237*g0;
TATlsti = xlsread(xlsfile,1,'J28:J33').'+273.15*ones(1,6);
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
alpha0=-trendlineparaCl(2)/Clalpha;

mulst=[];
for n=1:6
    mu=calculateviscosity(lambda,Tstatlsti(n),C);
    mulst=[mulst,mu];
end

Relsti=[];
for n=1:6
    Rei=rholsti(n)*Vtaslsti(n)*cbar/mulst(n);
    %disp(rholsti(i))
    %disp(Vtaslsti(i))
    %disp(mulst(i))
    Relsti=[Relsti,Rei];
end
Remin=min(Relsti);
Remax=max(Relsti);
Mmin=min(Machlsti);
Mmax=max(Machlsti)

