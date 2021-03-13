%%%%%%%%%%%%%%%%%%
% lab 3, recuperator modeling
% 2021, PVRT
%%%%%%%%%%%%%%%%%%
clc, clear, close all;

[A, B, C, D] = get_vitko_code_f();

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;
temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;
EL_PRICE = 0.13;
WORK_COST = 5000;
RECUP_PRICE = 2500;
initial_investment = WORK_COST + RECUP_PRICE;

area = [A*5+150, B*20+700, C*4+200, D*2+30];
room_area_m2 = area(3);

recuptr_power_W = calculate_recup_power_f(room_area_m2);
fprintf("Recuperator power %d wats\n", recuptr_power_W);

time = calculate_break_even_f(recuptr_power_W, EL_PRICE, initial_investment, room_area_m2, temp_diff, false);
fprintf("Investment breaks evevn after: %0.2f years\n", time);

time_incr = calculate_break_even_f(recuptr_power_W, EL_PRICE, initial_investment, room_area_m2, temp_diff, true);
fprintf("Investment breaks evevn after: %0.2f years if electricity price is increasing\n", time_incr);

heater_pow_W = calculate_heater_power(area, temp_diff)

heater_pow = draw_heater_over_temp_f(area, TEMP_INSIDE);