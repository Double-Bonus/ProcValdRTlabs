function [rctn_value, rctn_time, rctn_time_plot] = calculate_reaction_f(time, func)
    rctn_time = time(end);
    reaction_time_str = 0;
    rctn_time_plot = time(end);
    rctn_value = 0;
    last_value = func(length(func));
    for ii = 1:length(func)
        if (0 == reaction_time_str) && (func(ii) > 0.1 * last_value)
            reaction_time_str = time(ii);
        elseif (func(ii) >= 0.9 * last_value)
            rctn_value = func(ii);
            rctn_time = time(ii) - reaction_time_str;
            rctn_time_plot = time(ii);
            break; %found reaction time
        end
    end
end