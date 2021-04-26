clc, clear, close all;

V_0 = 15;
angle_d = 60;
time_s = 15;
H_0 = 25; % Initial height in meters

V_0_Y = sind(angle_d) * V_0;
V_0_X = cosd(angle_d) * V_0;

drag_c = 0.04;


% balls
table_tennis_R_m = 0.02;
table_tennis_M_kg = 0.0027;

tennis_R_m = 0.0654; % outside tennis
tennis_M_kg = 0.056;

metal_ball_R_m = 0.01; % outside tennis
metal_rho = 7.874 * 1000; % kg/m^3
metal_ball_M_kg = 4/3*pi*metal_ball_R_m^3  * metal_rho;


drag_coef = 0.47; % Sphere drag coeficient
air_rho = 1.225; % Air density kg/m^3


drag1 = calculate_drag_f(drag_coef, air_rho, table_tennis_M_kg, table_tennis_R_m);
drag2 = calculate_drag_f(drag_coef, air_rho, tennis_M_kg, tennis_R_m);
drag3 = calculate_drag_f(drag_coef, air_rho, metal_ball_M_kg, metal_ball_R_m);
 

[x_tbl_ten, y_tbl_ten, t_tbl_ten] = calculate_trajectory_f(H_0, V_0, angle_d, time_s, drag1);
[x_tennis, y_tennis, t_tennis] = calculate_trajectory_f(H_0, V_0, angle_d, time_s, drag2);
[x_metal, y_metal, t_metal] = calculate_trajectory_f(H_0, V_0, angle_d, time_s*1.2, drag3);



plot(x_metal,y_metal);
xlabel('x, m');
ylabel('y, m');
title('Ball trajectory');

figure(2)

plot(x_tbl_ten,y_tbl_ten, x_tennis, y_tennis, x_metal,y_metal);
xlabel('x, m');
ylabel('y, m');
title('Ball trajectory');
legend('Table tennis', 'Tennis', 'Metal')



