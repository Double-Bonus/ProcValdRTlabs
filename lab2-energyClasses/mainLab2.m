%%%%%%%%%%%%%%%%%%
% lab 2, energy classes of houses
% 2021, PVRT
%%%%%%%%%%%%%%%%%%
clear, clc, close all;

[A, B, C, D] = get_vitko_code_f();

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;
ENERGY_PRICE = 0.05 / 1000;     % 0,05 EUR/kWh (in watts)
LABOR_COST = 50;                % 50 Eur/m^3, insulation labor cost
PRICE_ROOF_MATT = 30;
PRICE_WALL_MATT = 60;
PRICE_FLOOR_MATT = 70;
PRICE_WINDOW_MATT = 7500;
TIME_HR = 180 * 24 * 10;

area = [A*5+150, B*20+700, C*4+200, D*2+30];
temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;

roof_U =    [0.2314, 0.16, 0.14, 0.12, 0.10, 0.08];% ,0.2314]; %optimal
wall_U =    [0.2569, 0.20, 0.15, 0.13, 0.11, 0.10];% , 0.2569];
floor_U =   [0.2527, 0.25, 0.16, 0.14, 0.12, 0.10];% , 0.2527];
windows_U = [1.8695, 1.60, 1.00, 0.90, 0.80, 0.80];% , 1.8695];

conductivity_q = [0.039, 0.035, 0.031, 0.027];

d_roof = conductivity_q(1) ./ roof_U;
d_wall = conductivity_q(2) ./ wall_U;
d_floor = conductivity_q(3) ./ floor_U;
d_window = conductivity_q(4) ./ windows_U;

price_roof = d_roof * area(1) * (PRICE_ROOF_MATT + LABOR_COST);
price_wall = d_wall * area(2) * (PRICE_WALL_MATT + LABOR_COST);
price_floor = d_floor * area(3) * (PRICE_FLOOR_MATT + LABOR_COST);
price_window = d_window * area(4) * (PRICE_WINDOW_MATT + LABOR_COST);

total_build_prices = price_roof + price_wall + price_floor + price_window; %array for each class

energy_loss = roof_U.*area(1) + wall_U.*area(2) + floor_U.*area(3) + windows_U.*area(4);

% Get energy losses for each class and each element to fill up table
roof_energy_loss_W = roof_U.*area(1) * TIME_HR * temp_diff;
wall_energy_loss_W = wall_U.*area(2) * TIME_HR * temp_diff;
floor_energy_loss_W = floor_U.*area(3) * TIME_HR * temp_diff;
windows_energy_loss_W = windows_U.*area(4) * TIME_HR * temp_diff;

total_heat_loss_W = energy_loss * TIME_HR * temp_diff;
total_en_price = total_heat_loss_W * ENERGY_PRICE;

total = total_build_prices + total_en_price;

distace_meters = find_optimal_d_f(area(1), area(2),area(3),area(4));

back_yr = calculate_break_even_year(total_heat_loss_W/10, total_build_prices, false) % if price isn't incresing
back_yr2 = calculate_break_even_year(total_heat_loss_W/10, total_build_prices, true) % if price increses
