function [t_val, t_time] = calculate_time_constant(time, func)   
    t_val = 0;
    t_time = 0;
    last_value = func(length(func));
    
    for ii = 1:length(func)
        if(func(ii) >= 0.63 * last_value)
            t_val = func(ii);
            t_time = time(ii);
            break; %found time constant
        end
    end
end