function [Cla,CL] = Cl_alpha ()

a = load('FTISxprt-20180306_082856');

%time steps for first measurements
t_1 = 13650;
t_2 = 19000;



hp0    =  a.flightdata.Dadc1_alt.data*0.3048 ;      	  % pressure altitude in the stationary flight condition [m]
alpha  =    degtorad(a.flightdata.vane_AOA.data)  ;        % angle of attack in the stationary flight condition [rad]
Vc     =  a.flightdata.Dadc1_cas.data*0.514444;        %computed airspeed in teh stationary flight conditions [m/sec]

S      = 30.00;	          % wing area [m^2]
rho0   = 1.2250;          % air density at sea level [kg/m^3] 
lambda = -0.0065;         % temperature gradient in ISA [K/m]
Temp0  = 288.15;          % temperature at sea level in ISA [K]
R      = 287.05;          % specific gas constant [m^2/sec^2K]
g      = 9.81;            % [m/sec^2] (gravity constant)


[m,~] = mass_and_balance ();
W = m*g;

[Vre,~] = Vreducedequivalent();

% rho = [];
% for n = 1:48681
%     rho_1 = rho0*((1+(lambda*(hp0(n)/Temp0))))^(-((g/(lambda*R))+1));
%     rho =[rho, rho_1];
% end
% rho = rho (:);              % [kg/m^3]  (air density)



CL = [];
% 
% for n = 1:48681
%     CL_1 = 2*W(n)/(rho(n)*Vc(n)^2*S);               % Lift coefficient [ ]
% 
%     CL = [CL, CL_1];
%    
% end


for n = 1:48681
    CL_1 = 2*W(n)/(rho0*Vre(n)^2*S);               % Lift coefficient [ ]

    CL = [CL, CL_1];
   
end

CL = CL (:);


CL_2 = CL(t_1:t_2);
alpha_2 = radtodeg(alpha (t_1:t_2));

mdl = fitlm(alpha_2,CL_2,'poly1');

plot(mdl)
xlabel('angle of attack [deg]');
ylabel('Cl');
title('Cl-alpha');
CL_linreg = mdl.Fitted;



Cla   = (CL_linreg(end)-CL_linreg(1))/ (alpha(t_2)-alpha(t_1)) ;            % Slope of CL-alpha curve [ ]


