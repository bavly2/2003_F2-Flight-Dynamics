function y=calculateMach(p,Vc)
y=sqrt(2/(1.4-1)*((1+101325/p*((1+0.4/2.8*1.225/101325*Vc^2)^(1.4/0.4)-1))^(0.4/1.4)-1));