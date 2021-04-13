function K = calculate_K_f()
    error_s = 100;
    deng = [8 4];
    t = 0.01:0.05:100;
    for K = 1:200
        numg = K;
        transf_fnc = tf(numg, deng);
        transf_fnc = transf_fnc / (transf_fnc + 1);
%         step(transf_fnc) %graph
        c1 = step(transf_fnc, t)';
        error_s = abs(1-c1(end)) *100;      
        if (error_s >= 1.99 && error_s <= 2.01) 
            return
        end
    end


end