clc, clear

%C 8390
A = 8;
B = 3;
C = 9;
D = 10;

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;
temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;

room_area_m2 = C*4+200;
el_price = 0.05;
initial_investment = 5000;




recuptr_power_W = calculate_power(room_area_m2)

time = calculate_break_even(recuptr_power_W, el_price, initial_investment, room_area_m2, temp_diff)