% enery usage - yearly energy usage in W
% init_cost - Initial investment needed
% returns year in which investmen breaks even
function payback_year = calculate_break_even_year(energy_usage, init_cost, increasing)

    if length(energy_usage) ~= length(init_cost)
        payback_year = -1;
        return
    end
         
    if increasing ~= true && increasing ~= false
        increasing = false;
    end

    ENERGY_PRICE = 0.05 / 1000;     % 0,05 EUR/kWh (in watts)
    payback_year = zeros(1,length(energy_usage));
    is_back =      zeros(1,length(energy_usage));

    back_price = init_cost;
    year = 0;
    total_en_price = energy_usage * ENERGY_PRICE;
    if increasing
        price_increase =  1.091; % (10%  *0,CD).
    end
  
    while (sum(is_back) < length(energy_usage)-1)
        year = year + 1;
        back_price = back_price + total_en_price;
        for i = 2:length(energy_usage)
            if( ~is_back(i) && back_price(i) <= back_price(1) )
                payback_year(i) = year;
                is_back(i) = 1;
            end
        end
        if increasing
            total_en_price = total_en_price * price_increase;
        end
    end
end %function end