function [s_val, s_time] = calculate_settling_values_f(time, func)
    s_val = func(end);
    s_time = time(end);
    
    for ii = length(time):-1:1
        if ( abs(func(ii) - func(end)) >= func(end) * 0.05 )
            s_time = time(ii+1);
            s_val = func(ii);
            break;
        end
    end

end
