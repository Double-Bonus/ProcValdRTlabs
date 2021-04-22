function [s_val, s_time] = get_settling_values(time, func, peak_time)
    s_val = func(end);
    s_time = time(end);
    if(peak_time >= time(end))
        fprintf("Error procces never settes");
        return
    end
    for start = 1:length(time)
        if (time(start) >= peak_time)
            break
        end
    end
    
    for ii = start:length(time)
        if ( abs(func(ii) - func(end)) <=  func(end) * 0.05 )
            s_val = func(ii);
            s_time = time(ii);            
            break;
        end
    end
end
