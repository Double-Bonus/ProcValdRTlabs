function power_W = calculate_recup_power_f(area_m2)
    ROOM_HEIGHT_M = 2.5; 
    V_m3 = area_m2 * ROOM_HEIGHT_M;
    power_W = V_m3 / 2;   
end