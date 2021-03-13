% function calculates time need to break even on recuperator investment
% we presume what recuperator is needed for 180 days a year
function time_yr = calculate_break_even_f(recuptr_power, el_price, initial_investment, area, temp_diff, is_price_incresing)
    if is_price_incresing ~= true && is_price_incresing ~= false %check if boolean
        is_price_incresing = false;
    end
    ROOM_HEIGHT_M = 2.5; 
    AIR_DENSITY = 1.293; % kg/m3
    HEAT_CAPACITY = 0.28; % Wh/(kg*K)
    spend_money = initial_investment;
    saved_money = 0;
    time_hr = 0;
    year = 1;
    
    money_saved_hr = area * ROOM_HEIGHT_M * AIR_DENSITY * HEAT_CAPACITY * (el_price/1000) * temp_diff * 0.85;
    money_spend_hr = recuptr_power * (el_price/1000);
    
    while(spend_money > saved_money)
        saved_money = saved_money + money_saved_hr;
        spend_money = spend_money + money_spend_hr;
        time_hr = time_hr + 1;
        if is_price_incresing && time_hr / (24*180) >= year %year has passed - increase price
            money_saved_hr = money_saved_hr * 1.091;
            money_spend_hr = money_spend_hr * 1.091;
            year = year + 1;
        end
        if time_hr > 24*365*100 % way too long
            fprintf("Investment is not profitable in ~200 years");
            return;
        end        
    end   
    time_yr = time_hr / (24*180); 
end