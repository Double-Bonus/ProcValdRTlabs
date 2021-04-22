function [p_val, p_time] = calculate_peak(time, func)   
    [p_val, pos_t] = max(func);
    p_time = time(pos_t);
end