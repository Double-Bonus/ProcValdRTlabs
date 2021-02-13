%%%%%%%%%%%%%%%%%%
%lab 2, energy classes of houses
%2021
%%%%%%%%%%%%%%%%%%

clear, clc

%C 8390
A = 8;
B = 3;
C = 9;
D = 10;

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;
ENERGY_PRICE = 0.05 / 1000; % 0,05 EUR/kWh (in watts)
LABOR_COST = 50; % 50 Eur / m^3, insulation labor cost
PRICE_ROOF_MATT = 30;
PRICE_WALL_MATT = 60;
PRICE_FLOOR_MATT = 70;
PRICE_WINDOW_MATT = 7500;
TIME_HR = 180 * 24 * 10;


area = [A*5+150, B*20+700, C*4+200, D*2+30];
temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;

roof_U =    [0.16, 0.14, 0.12, 0.10, 0.08];
wall_U =    [0.20, 0.15, 0.13, 0.11, 0.10];
floor_U =   [0.25, 0.16, 0.14, 0.12, 0.10];
windows_U = [1.60, 1.00, 0.90, 0.80, 0.80];

conductivity_q= [0.039, 0.035, 0.031, 0.027];

d_roof = conductivity_q(1) ./ roof_U;
d_wall = conductivity_q(2) ./ wall_U;
d_floor = conductivity_q(3) ./ floor_U;
d_window = conductivity_q(4) ./ windows_U;


price_roof = d_roof * area(1) * (PRICE_ROOF_MATT + LABOR_COST);
price_wall = d_wall * area(2) * (PRICE_WALL_MATT + LABOR_COST);
price_floor = d_floor * area(3) * (PRICE_FLOOR_MATT + LABOR_COST);
price_window = d_window * area(4) * (PRICE_WINDOW_MATT + LABOR_COST);


total_build_prices = price_roof + price_wall + price_floor + price_window;

energy_loss = roof_U.*area(1) + wall_U.*area(2) + floor_U.*area(3) + windows_U.*area(4);

roof_energy_loss = roof_U.*area(1) * TIME_HR * temp_diff;
wall_energy_loss = wall_U.*area(2) * TIME_HR * temp_diff;
floor_energy_loss = floor_U.*area(3) * TIME_HR * temp_diff;
windows_energy_loss = windows_U.*area(4) * TIME_HR * temp_diff;


total_en_price = energy_loss * TIME_HR * temp_diff * ENERGY_PRICE;
%fprintf('%f/n', total_build_prices(1));

fprintf('          B     A     A+      A++    passive\n');
fprintf(' %f, %f %f %f %f \n', total_build_prices);

total = total_build_prices + total_en_price;

payback_year = [0 0 0 0 0];
is_back =      [0 0 0 0 0];

back_price = total_build_prices;
year = 0;

total_en_price = energy_loss * 180 * 24 * temp_diff * ENERGY_PRICE;

while (sum(is_back) < 4)
    year = year + 1;
    back_price = back_price + total_en_price;
    for i = 2:5
        if( ~is_back(i) && back_price(i) < back_price(1) )
            payback_year(i) = year;
            is_back(i) = 1;
        end
    end
    %total_en_price = total_en_price*1.091;
end

payback_year


distace_meters = find_optimal_d(area(1), area(2),area(3),area(4))

optimal_d = zeros(1,4);

if 0 
optimal_d(1) = distace_meters(1);
optimal_d(2) = d_wall(1);
optimal_d(3) = d_floor(1);
optimal_d(4) = d_window(1);


d_roof = conductivity_q(1) ./ roof_U;
d_wall = conductivity_q(2) ./ wall_U;
d_floor = conductivity_q(3) ./ floor_U;
d_window = conductivity_q(4) ./ windows_U;
end




