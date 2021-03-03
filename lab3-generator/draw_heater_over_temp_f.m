function heater_pow = draw_heater_over_temp_f(area, temp_inside)


temp_outside = -30:temp_inside;
temp_diff = temp_inside - temp_outside;



    ROOM_HEIGHT_M = 2.5; 
    AIR_DENSITY = 1.293; % kg/m3
    HEAT_CAPACITY = 0.28; % Wh/(kg*K)
    
    %calculating house_power_loss
    roof_U =    0.16;
    wall_U =    0.20;
    floor_U =   0.25;
    windows_U = 1.60;

    conductivity_q = [0.039, 0.035, 0.031, 0.027];

    d_roof = conductivity_q(1) / roof_U;
    d_wall = conductivity_q(2) / wall_U;
    d_floor = conductivity_q(3) / floor_U;
    d_window = conductivity_q(4) / windows_U;

%energy_loss = roof_U.*area(1) + wall_U.*area(2) + floor_U.*area(3) + windows_U.*area(4);

roof_energy_loss = roof_U.*area(1) * temp_diff;
wall_energy_loss = wall_U.*area(2) * temp_diff;
floor_energy_loss = floor_U.*area(3) * temp_diff;
windows_energy_loss = windows_U.*area(4) * temp_diff;

    
    house_power_loss = roof_energy_loss + wall_energy_loss + floor_energy_loss + windows_energy_loss;
    recup_loss = (area(3) * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * temp_diff * 0.15);


    heater_pow = house_power_loss + recup_loss;
    
    plot(temp_outside,heater_pow)

end