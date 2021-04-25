function error_val = calculate_stat_error_f(real_func, func)   
    error_val = abs(real_func(end) - func(end) ) / real_func(end) * 100;
end