[~, Vre_points_sorted, delta_e_eq_points_sorted, F_e_r_points_sorted] = Cm_alpha();

%Plot reduced elevator trim curve
figure
plot(Vre_points_sorted,delta_e_eq_points_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Reduced equivalent airspeed [m/s]');
ylabel('Equivalent elevator deflection [degree]');
title('Reduced elevator deflection related to reduced equivalent airspeed');

%Plot reduced elevator force curve
figure
plot(Vre_points_sorted,F_e_r_points_sorted,'-o')
set(gca,'YDir','reverse')
xlabel('Reduced equivalent airspeed [m/s]');
ylabel('Reduced control force [N]');
title('Reduced control force related to reduced equivalent airspeed');
