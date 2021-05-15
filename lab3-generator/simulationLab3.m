clear, clc;

[A, B, C, D] = get_vitko_code_f();

TEMP_INSIDE = 22;
TEMP_OUTSIDE = B - A;
ROOM_HEIGHT_M = 2.5; 
AIR_DENSITY = 1.293; % kg/m3
HEAT_CAPACITY = 0.28; % Wh/(kg*K)
ENERGY_PRICE = 0.13 / 1000; % 0,05 EUR/kWh (in watts)

area = [A*5+150, B*20+700, C*4+200, D*2+30];

V = area(3) * ROOM_HEIGHT_M;
mass_kg = V * AIR_DENSITY;

HEAT_CAPACITY_unit = HEAT_CAPACITY * 3600;

roof_U =    0.2314; 
wall_U =    0.2569;
floor_U =   0.2527;
windows_U = 1.8695;

initial_temp_K = TEMP_INSIDE + 273;
outside_temp_K = -10 + 273;
outside_temp2_K = 0 + 273;
outside_temp3_K = 10 + 273;


fprintf("Parameters for simulation loaded\n");


    
    