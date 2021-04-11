%Sketch Bode diagram when K1 = K2 = 1, and investigate stability of the system

clc, clear, close all;

partNR = 2;

if 2 == partNR  
    K1 = 0.1; 
    K2 = 0.04; 
else
    K1 = 1; 
    K2 = 1;   
end

T = 1.5;                                             % define time delay required by conveyor (seconds)
%------------------------------------------
% Tank and Output Valve G(s)
%------------------------------------------
num = 5;                                             % define numerator of Tank and output valve
dent = [5 1];                                        % define denominator of Tank and output valve
G1 = tf(num, dent);                                  % create transfer function for Tank and output valve
%-------------------------------
% Controller Gc(s)
%-------------------------------
num1 = [K1 K2];                                      % define numerator of Controller
dent1 = [1 0];                                       % define denominator of Controller
Gc = tf(num1, dent1);                                % create transfer function for Controller
%-------------------------
% Conveyor
%-------------------------
[num2, dent2] = pade(T,5);                           % using pade function to find numerator and denominator
Conveyor = tf(num2, dent2);                          % create transfer function for Conveyor
G = G1*Gc*Conveyor;
figure

grid on

transf_fnc = G / (G + 1);
t = 0.01:0.01:100;
step(transf_fnc, t);




% peak_value = calculate_peak_value(t, transf_fnc, peak_time)
c1 = step(transf_fnc, t)';
[rctn_value, rctn_time, rctn_time_plot] = calculate_reaction(t, c1)
[p_val, p_time] = calculate_peak(t, c1)   
over_val = calculate_overshoot_prc(t, c1) 
[s_val, s_time] = get_settling_values(t, c1, p_time) 







% static functions
function [p_val, p_time] = calculate_peak(time, func)   
    [p_val, pos_t] = max(func);
    p_time = time(pos_t);
end

function [rctn_value, rctn_time, rctn_time_plot] = calculate_reaction(time, func)
    rctn_time = 0;
    reaction_time_str = 0;
    rctn_time_plot = 0;
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


function over_val = calculate_overshoot_prc(time, func)  %NEREIKIA LAIKO VERTES LYG????????
    max_val = max(func);
    over_val = (max_val - func(end)) / func(end) * 100;

end




function [s_val, s_time] = get_settling_values(time, func, peak_time)
    s_val = func(end);
    s_time = time(end);
    if(peak_time >= time(end))
        fprintf("Error procces never settes");
        return
    end
    for start = 1:length(time)
        if (time(start) > peak_time)
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
 

