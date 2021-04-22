function over_val = calculate_overshoot_prc(func)
    max_val = max(func);
    over_val = (max_val - func(end)) / func(end) * 100;
end