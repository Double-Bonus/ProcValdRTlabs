function time_yr = calculate_break_even(recuptr_power, el_price, initial_investment, area, temp_diff)

    ROOM_HEIGHT_M = 2.5; 
    AIR_DENSITY = 1.293; % kg/m3
    HEAT_CAPACITY = 0.28; % Wh/(kg*K)
    spend_money = initial_investment;
    saved_money = 0;
    time_hr = 0;
    money_saved_hr = area * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * (el_price/1000) * temp_diff * 0.85;
    money_spend_hr = recuptr_power * (el_price/1000);
    
    while(spend_money > saved_money)
        saved_money = saved_money + money_saved_hr;
        spend_money = spend_money + money_spend_hr;
        time_hr = time_hr + 1;
        if time_hr > 24*365*150
            fprintf("lol")
        end
        
    end
    
    time_yr = time_hr / (24*365);
end