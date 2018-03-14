function [weight, cg_data] = mass_and_balance();

%load flight data and save needed parameters for mass and balance
%determination
c = 2.0569;
a = load('FTISxprt-20180306_082856');
Fuel_flow_lh = a.flightdata.lh_engine_FU.data ;
Fuel_flow_rh = a.flightdata.rh_engine_FU.data ;
time = a.flightdata.time.data ;

%input parameters (passenger weights and their designated seats staring with seat 1)
dist =[131,170,214,251,288];
d = dist*0.0254;
P = [95,82,67,71,75,76,78,80,104.5];


%determination of cg_datum under ramp_mass condition
BEM = 4157.174;
cg_BEM = 7.421;
payload = sum(P);
payload_arm = (P(1)*d(1)+P(2)*d(1)+P(3)*d(2)+P(4)*d(3)+P(5)*d(3)+P(6)*d(4)+P(7)*d(4)+P(8)*d(5)+P(9)*d(5))/payload;
payload_arm_test = (P(1)*d(1)+P(2)*d(1)+P(3)*d(2)+P(4)*d(3)+P(5)*d(3)+P(6)*d(4)+P(7)*d(4)+P(8)*d(5)+P(9)*d(1))/payload;
ZFM = BEM + payload;
cg_ZFM = (payload * payload_arm + BEM * cg_BEM)/ ZFM;
cg_ZFM_test = (payload * payload_arm_test + BEM * cg_BEM)/ ZFM;
fuel = 1814.369;
cg_fuel = 7.253;
ramp_mass = ZFM + fuel;
cg_ramp_mass = (ZFM*cg_ZFM + fuel*cg_fuel)/ramp_mass;
mac_LE = 6.644;



weight = [];
cg_data= [];

%cg shift and weight change due to fuel burned
for n = 1:31444
    w = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
    weight = [weight, w];
    cg = (ZFM*cg_ZFM + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/w - mac_LE ;
    cg_data = [cg_data, cg];
end
%cg shift due to C_m_delta measurement procedure and fuel burned weight
%change due to fuel burned
    for n = 31445:32188
        w = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
        weight = [weight, w];
        cg = (ZFM*cg_ZFM_test + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/w - mac_LE;
        cg_data = [cg_data, cg];
    end
    
%cg shift and weight change due to fuel burned
    for n = 32189:48681
            w = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
            weight = [weight, w];
            cg = (ZFM*cg_ZFM + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/w - mac_LE;
            cg_data = [cg_data, cg];
    
    end


%cg as % of mac
cg_data = cg_data * 100/c;

%save in list
time = time(:);
weight = weight (:);

% %plot cg shift and weight change of the ac during flight test
% figure
% plot(time, weight);
% xlabel('time step');
% ylabel('aircraft weight in kg');
% title('aircraft weight change during test flight');
% 
% figure
% plot(time, cg_data);
% xlabel('time step');
% ylabel('X_cg as % of the mac');
% title('cg shift during test flight');




