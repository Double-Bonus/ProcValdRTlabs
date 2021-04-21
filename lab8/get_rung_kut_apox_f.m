function [y_aprox, t] = get_rung_kut_apox_f(func_s, h, max_time)
    t = 0:h:max_time;
    y_aprox = zeros(size(t)); % allocate the result y
    y_aprox(1) = 0;           % the initial y value
      
    n = numel(y_aprox);
    derived_fun = matlabFunction( diff(func_s)); % the expression for y'
      
    for ii = 1:n-1  
        K0 = h .* derived_fun(t(ii));
        K1 = h .* derived_fun(t(ii)+0.5*h);
        K2 = h .* derived_fun(t(ii)+0.5*h);
        K3 = h .* derived_fun(t(ii)+h);

        y_aprox(ii+1) = y_aprox(ii) + (K0 + 2*K1 + 2*K2 + K3) ./ 6;
    end
end

