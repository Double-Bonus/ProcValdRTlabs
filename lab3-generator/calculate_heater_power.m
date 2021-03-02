function heater_pow = calculate_heater_power(house_power_loss, el_price, area, temp_diff)

    ROOM_HEIGHT_M = 2.5; 
    AIR_DENSITY = 1.293; % kg/m3
    HEAT_CAPACITY = 0.28; % Wh/(kg*K)


    heater_pow = house_power_loss + (area * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * (el_price/1000) * temp_diff * 0.15);


end