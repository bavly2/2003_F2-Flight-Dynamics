function [weight, cg_data, cg_data_c] = mass_and_balance()

%load flight data and save needed parameters for mass and balance
%determination
c = 2.0569;
a = load('FTISxprt-20180320_102524');
Fuel_used_lh = a.flightdata.lh_engine_FU.data ;
Fuel_used_rh = a.flightdata.rh_engine_FU.data ;
time = a.flightdata.time.data ;

%input parameters (passenger weights and their designated seats staring with seat 1)
dist =[131,170,214,251,288];
d = dist*0.0254;
P = [95,82,79,71,71,71,58,78,81];


%determination of cg_datum under ramp_mass condition
BEM = 4157.174;
cg_BEM = 7.421;
payload = sum(P);
payload_arm = (P(1)*d(1)+P(2)*d(1)+P(3)*d(2)+P(4)*d(3)+P(5)*d(3)+P(6)*d(4)+P(7)*d(4)+P(8)*d(5)+P(9)*d(5))/payload;
payload_arm_test = (P(1)*d(1)+P(2)*d(1)+P(3)*d(2)+P(4)*d(3)+P(5)*d(3)+P(6)*d(4)+P(7)*d(4)+P(8)*d(5)+P(9)*d(1))/payload;
ZFM = BEM + payload;
cg_ZFM = (payload * payload_arm + BEM * cg_BEM)/ ZFM;
cg_ZFM_test = (payload * payload_arm_test + BEM * cg_BEM)/ ZFM;
fuel = 2600*0.453592;
cg_fuel_start = 7.244;
cg_fuel = [];
ramp_mass = ZFM + fuel;
cg_ramp_mass = (ZFM*cg_ZFM + fuel*cg_fuel_start)/ramp_mass;
mac_LE = 6.644;



%fuel cg from Table E.2 

Moment = [298.16,591.18,879.08,1165.42,1448.4,1732.53,2014.8,2298.84,2581.92,2866.3,3150.18,3434.52, 3718.52,4003.23,4287.67, 4572.24, 4856.56, 5141.16,5425.64,5709.90,5994.04,6278.47,6562.82,6864.96,7131.00,7415.33,7699.6,7984.34,8269.06,8554.05,8839.04,9124.8,9410.62,9696.97,9983.4,10270.08,10556.84,10843.87,11131.00,11418.20,11705.50,11993.31,12281.18,12569.04,12856.86,13144.73,13432.48,13720.56,14008.46,14320.34];

M = Moment (:);

Fuel_mass = [];
M_1 = 100;
for n = 1:50
    Fuel_mass = [Fuel_mass, M_1];
    M_1 = M_1 + 100;
end

Fuel_mass = Fuel_mass (:);

m_slope = (14008.46-591.18)/(4900-200);
b_fuel = 5994.04-2100*m_slope;

mdl = fitlm(Fuel_mass,M,'linear');

%plot(mdl)

coefficients = mdl.Coefficients.Estimate;
slope_f = coefficients(2);
fuel_0 = coefficients(1);

fuel_2 = [];
for n = 1:43661
    fuel_1 = fuel/0.453592 -(Fuel_used_lh(n)+Fuel_used_rh(n));
    fuel_2 = [fuel_2, fuel_1];
end

fuel_2 = fuel_2 (:);

for n = 1 :43661
    cg_f = (fuel_2(n) * slope_f + fuel_0)/(fuel_2(n))*100*0.0254 ;
    cg_fuel = [cg_fuel, cg_f];
end
fuel_2 = fuel_2 (:);
cg_fuel = cg_fuel (:);

% plot(fuel_2,cg_fuel)
% set(gca, 'XDir','reverse')
%     
%     
% %t1 time step where cm_delta measurment procedure starts (person in seat 8 moves up
% %to between seats 1&2)
%t1 = 27228;

% %t2 time step where cm_delta measurment procedure ends (person moves back
% %to seat 8)
%t2 = 28356;
t1 = 27350;
t2 = 28500;
% 
weight = [];
cg_data= [];

%cg shift and weight change due to fuel burned
for n = 1:t1-1
    w = ramp_mass - ((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592));
    weight = [weight, w];
    cg = (ZFM*cg_ZFM + ((fuel-((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592)))*cg_fuel(n)))/w - mac_LE ;
    cg_data = [cg_data, cg];
end
%cg shift due to C_m_delta measurement procedure and fuel burned weight
%change due to fuel burned
    for n = t1:t2
        w = ramp_mass - ((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592));
        weight = [weight, w];
        cg = (ZFM*cg_ZFM_test + ((fuel-((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592)))*cg_fuel(n)))/w - mac_LE;
        cg_data = [cg_data, cg];
    end
    
%cg shift and weight change due to fuel burned
    for n = t2+1:43661
            w = ramp_mass - ((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592));
            weight = [weight, w];
            cg = (ZFM*cg_ZFM + ((fuel-((Fuel_used_lh(n)* 0.453592)+(Fuel_used_rh(n)* 0.453592)))*cg_fuel(n)))/w - mac_LE;
            cg_data = [cg_data, cg];
    end


%cg as % of mac
cg_data_c = cg_data * 100/c;
cg_data = cg_data + mac_LE;
%save in list
time = time(:);
weight = weight (:);
cg_data = cg_data (:);
cg_data_c = cg_data_c (:);

%plot cg shift and weight change of the ac during flight test
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

% 
% 
% 