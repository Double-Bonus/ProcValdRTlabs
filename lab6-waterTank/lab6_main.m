%EXAMPLE1_1(Time response)

%Transfer function G(s) = 1/8s+4

%Output step response for K = 1 and K = 196

clc, clear, close all;

syms s K

transf_fnc = K/(8*s + 4);
transf_fnc = transf_fnc / (transf_fnc + 1);
diff_fnc = ilaplace(transf_fnc)


% 2 part of task

K = 1;
numg = K;
deng = [8 4];
transf_fnc_2 = tf(numg,deng);
% step(transf_fnc_2)
transf_fnc_2 = transf_fnc_2 / (transf_fnc_2 + 1);
step(transf_fnc_2)

% 3 part of task
K_part_2 =  calculate_K_f()
% 3.9200
% 4.08



% 4 part of task
K = 196;
numg = K;
deng = [8 4];
transf_fnc_4 = tf(numg,deng);
% transf_fnc_4 = transf_fnc_4 / (transf_fnc_4 + 1);
% t = 0.01:0.01:75;
t = 0.01:0.01:10;
step(transf_fnc_4, t);

% peak_value = calculate_peak_value(t, transf_fnc, peak_time)
c1 = step(transf_fnc_4, t)';
[reaction_value, reaction_time, reaction_time_plot] = calculate_reaction(t, c1)
[peak_value, peak_time] = calculate_peak(t, c1)   
[settling_value, s_time] = get_settling_values(t, c1, peak_time) 
[t_val, t_time] = calculate_time_constant(t, c1) 





if 0
    K = input('Enter desired value of the system gain K,K =  ')
    K = 1;
    numg = K;                  %Define numerator of the system's transfer function
    deng = [8 4];              %Define denominator of the system's transfer function
    G = tf(numg,deng);        %Form G(s) LTI object
    T = feedback(G,1);       %Create closed loop transfer function
    step(T)                     %Plot step output response of the system
    title('OUTPUT STEP RESPONSE OF THE SYSTEM FOR K = 1')
    K1 = input('Enter desired value of the system gain K1,K1= ')
    numg1 = K1;                %Define numerator of the system's transfer function for gain K1
    deng1 = deng;              %Define denominator of the system's transfer function for gain K1
    G1 = tf(numg1,deng1); %Form G1(s) LTI object
    T1 = feedback(G1,1);  %Form closed loop system's transfer function
    step(T1)                     %Plot step output response of the system
    title('OUTPUT STEP RESPONSE OF THE SYSTEM FOR K1 = 196')
end





% static functions
function [p_val, p_time] = calculate_peak(time, func)   
    [p_val, pos_t] = max(func);
    p_time = time(pos_t);
end

function [rctn_value, rctn_time, rctn_time_plot] = calculate_reaction(time, func)
    rctn_time = time(end);
    reaction_time_str = 0;
    rctn_time_plot = time(end);
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
 
function [t_val, t_time] = calculate_time_constant(time, func)   
    t_val = 0;
    t_time = 0;
    last_value = func(length(func));
    
    for ii = 1:length(func)
        if(func(ii) >= 0.63 * last_value)
            t_val = func(ii);
            t_time = time(ii);
            break; %found time constant
        end
    end
end


