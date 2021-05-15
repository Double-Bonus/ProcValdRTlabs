function [h_aprox, y_aprox, t] = get_aprox_step_f(need_prc, aprox_lambda, func_s, max_time, init_h)
    step = 0.5;
    t = 0:step:max_time;
    actual_y = matlabFunction(func_s);
    y = actual_y(t);
    error_prc = 100;
    h_aprox = init_h;
    
    [y_aprox, t] = aprox_lambda(func_s, h_aprox, max_time);
    error_prc = abs(y(end) - y_aprox(end)) / y(end) * 100;
    
    while(error_prc > need_prc && h_aprox>=step)
        h_aprox = h_aprox - 0.01*init_h;
        [y_aprox, t] = aprox_lambda(func_s, h_aprox, max_time);
        
        error_prc = abs(y(end) - y_aprox(end)) / y(end) * 100;     
    end  
end


