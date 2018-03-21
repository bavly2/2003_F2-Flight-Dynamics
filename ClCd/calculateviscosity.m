function y=calculateviscosity(gamma,T,C)
y=10^(-6)*gamma*T^(1.5)/(T+C);