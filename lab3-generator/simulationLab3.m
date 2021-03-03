clear, clc

A = 8;
B = 3;
C = 9;
D = 10;

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;

LABOR_COST = 50; % 50 Eur / m^3, insulation labor cost
PRICE_ROOF_MATT = 30;


PRICE_IRENGIMO = 5000;
ENERGY_PRICE = 0.13 / 1000; % 0,05 EUR/kWh (in watts)
TANKIS = 1.293; %kg/m3
SIL_TALPA = 0.28;
EL_KAINA = 0.13; % eur/kWh

%o oras patalpose turi pasikeisti 1 kart? per valand?.
% Rekuperatoriaus naudingumo koeficientas 85 %.



area = [A*5+150, B*20+700, C*4+200, D*2+30];
ROOM_HEIGHT_M = 2.5; 
AIR_DENSITY = 1.293; % kg/m3
V = area(3) * ROOM_HEIGHT_M;
mass_kg = V * AIR_DENSITY;

HEAT_CAPACITY = 0.28; % Wh/(kg*K)
HEAT_CAPACITY_unit = HEAT_CAPACITY * 3600;

    roof_U =    0.16;
    wall_U =    0.20;
    floor_U =   0.25;
    windows_U = 1.60;

initial_temp_K = TEMP_INSIDE + 273;
outside_temp_K = -10 + 273;
%temp_K = % in constant





% spend_money = initial_investment;
saved_money = 0;
time_hr = 0;
%     money_saved_hr = area * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * (el_price/1000) * temp_diff * 0.85;
    
    