function [y_aprox, t] = get_euler_fixed_apox_f(func_s, h, max_time)
    t = 0:h:max_time;
    y_aprox = zeros(size(t)); % allocate the result y
    y_aprox(1) = 0;           % the initial y value
    
    n = numel(y_aprox);
    derived_fun = matlabFunction( diff(func_s));             % the expression for y'
    second_derived_fun = matlabFunction(diff(diff(func_s))); % the expression for y''
    
    for ii = 1:n-1
        y_aprox(ii+1) = y_aprox(ii) + h .* derived_fun(t(ii)) + (0.5 .* h.^2 .*second_derived_fun(ii)) ;
    end
end
