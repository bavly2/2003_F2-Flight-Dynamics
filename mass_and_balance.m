a = load('FTISxprt-20180306_082856');
dist =[131,170,214,251,288];
d = dist*0.0254;
P = [95,82,67,71,75,76,78,80,104.5];
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

Fuel_flow_lh = a.flightdata.lh_engine_FU.data ;
Fuel_flow_rh = a.flightdata.rh_engine_FU.data ;
time = a.flightdata.time.data ;


weight = [];
cg_data= [];

for n = 1:19999
    W = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
    weight = [weight, W];
    cg = (ZFM*cg_ZFM + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/W;
    cg_data = [cg_data, cg];
end
    for n = 20000:21000
        W = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
        weight = [weight, W];
        cg = (ZFM*cg_ZFM_test + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/W;
        cg_data = [cg_data, cg];
    end
    for n = 21001:48681
            W = ramp_mass - ((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592));
            weight = [weight, W];
            cg = (ZFM*cg_ZFM + ((fuel-((Fuel_flow_lh(n)* 0.453592)+(Fuel_flow_rh(n)* 0.453592)))*cg_fuel))/W;
            cg_data = [cg_data, cg];
    
    end

  
cg_data = cg_data * 100/c;


time = time(:);
weight = weight (:);

plot(time, weight);
plot(time, cg_data);




