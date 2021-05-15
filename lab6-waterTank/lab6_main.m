%EXAMPLE1_1(Time response)

%Transfer function G(s) = 1/8s+4

%Output step response for K = 1 and K = 196

clc, clear, close all;

OFFSET_X = 0.01;

if 0
syms s K

transf_fnc = K/(8*s + 4);
transf_fnc = transf_fnc / (transf_fnc + 1);
diff_fnc = ilaplace(transf_fnc)
end


% 2 part of task
if 0
K = 1;
numg = K;
deng = [8 4];
transf_fnc_2 = tf(numg,deng);
% step(transf_fnc_2)
transf_fnc_2 = transf_fnc_2 / (transf_fnc_2 + 1);
step(transf_fnc_2)
end

% 3 part of task
K_part_2 =  calculate_K_f()
% 3.9200
% 4.08



% 4 part of task
K = 196;
numg = K;
deng = [8 4];
transf_fnc_4 = tf(numg,deng);
transf_fnc_4 = transf_fnc_4 / (transf_fnc_4 + 1);
t = 0:0.001:0.7;
step(transf_fnc_4, t);
c1 = step(transf_fnc_4, t)';

[reaction_value, reaction_time, reaction_time_plot] = calculate_reaction(t, c1);
[settling_value, s_time] = get_settling_values(t, c1, 0);
[t_val, t_time] = calculate_time_constant(t, c1);
static_error = abs(1-c1(end)) *100;

% Draw graphs
hold on;
title('model function');
title(['Reaction to step response with K= ' , num2str(K)])
ylabel('Amplitude');
xlabel('Time, s');
 
plot(reaction_time_plot, reaction_value, '.y', 'MarkerSize', 30);
description = sprintf("Reaction time: %0.3fs", reaction_time);
text(reaction_time_plot + OFFSET_X, reaction_value, description);
 
plot(s_time, settling_value, '.r', 'MarkerSize', 30); %  setting time ts
description = sprintf("End of porcess time: %0.2fs Static error: %.3f%%", s_time, static_error);
text(s_time + OFFSET_X, settling_value, description);

plot(t_time, t_val, '.g', 'MarkerSize', 30); %  time constant
description = sprintf("Time constant: %0.3fs", t_val);
text(t_time + OFFSET_X, t_val, description);



% Part 5
if 1
    K = 1;
    numg = K;                  %Define numerator of the system's transfer function
    deng = [8 4];              %Define denominator of the system's transfer function
    G = tf(numg,deng);         %Form G(s) LTI object
    T = feedback(G,1);         %Create closed loop transfer function
    figure(2);
    step(T)                    %Plot step output response of the system
    title('OUTPUT STEP RESPONSE OF THE SYSTEM FOR K = 1')
    K1 = input('Enter desired value of the system gain K1,K1= ')
    numg1 = K1;                %Define numerator of the system's transfer function for gain K1
    deng1 = deng;              %Define denominator of the system's transfer function for gain K1
    G1 = tf(numg1,deng1);      %Form G1(s) LTI object
    T1 = feedback(G1,1);       %Form closed loop system's transfer function
     figure(3);
    step(T1)                   %Plot step output response of the system
    title(['OUTPUT STEP RESPONSE OF THE SYSTEM FOR K1 = ' num2str(K1)])
end





% static functions

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
        if (time(start) >= peak_time)
            break
        end
    end
    
    for ii = start:length(time)
        if ( abs(func(ii) - func(end)) <=  func(end) * 0.02 )
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


