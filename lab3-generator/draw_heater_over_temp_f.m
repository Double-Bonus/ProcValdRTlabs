function draw_heater_over_temp_f(area, temp_inside)
    temp_outside = -30:temp_inside;
    temp_diff = temp_inside - temp_outside;
    
    ROOM_HEIGHT_M = 2.5; 
    AIR_DENSITY = 1.293; % kg/m3
    HEAT_CAPACITY = 0.28; % Wh/(kg*K)
    
    %calculating house_power_loss using optimal U found in lab 2
    roof_U =    0.2314; 
    wall_U =    0.2569;
    floor_U =   0.2527;
    windows_U = 1.8695;
    %energy_loss = roof_U.*area(1) + wall_U.*area(2) + floor_U.*area(3) + windows_U.*area(4);

    roof_energy_loss = roof_U.*area(1) * temp_diff;
    wall_energy_loss = wall_U.*area(2) * temp_diff;
    floor_energy_loss = floor_U.*area(3) * temp_diff;
    windows_energy_loss = windows_U.*area(4) * temp_diff;

    house_power_loss = roof_energy_loss + wall_energy_loss + floor_energy_loss + windows_energy_loss;
    recup_loss = (area(3) * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * temp_diff * 0.15);

    heater_pow = house_power_loss + recup_loss;
    
    plot(temp_outside, heater_pow);
    grid on;
    title("Relationship between needed heater power and outside temperature"); 
    ylabel("Power, W");
    xlabel("Temperature, ^OC");
    
end