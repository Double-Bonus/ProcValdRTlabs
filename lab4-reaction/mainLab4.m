clc, clear, close all;

OFFSET_X = 1.5; % for drawing

transfer_fnc = tf(2.25,[1 0.5 2.25])        % define closed-loop transfer fn 
% 'Response Characteristics'
P = pole(transfer_fnc);                       % find closed-loop poles
Pre = abs(real(P(1)));                      % find real part of pole
Pim = abs(imag(P(1)));                      % find imag part of pole
frequency_wn = sqrt(Pre*Pre+Pim*Pim);       % calc natural frequency 
damping_ratio=(Pre/frequency_wn) ;          % calc damping ratio
overshoot_prct = (exp(-1*Pre*pi/Pim))*100 ; % calc percent overshoot
peak_time = pi/Pim;                         % calc peak time 
Ts = 4/Pre;                                 % calc settling time  (0.02 indicator) 
%--------------------------------------------------------------------
step(transfer_fnc); % Plot step response of T(s) using Matlab STEP function
grid on;
%-------------------------------------------------------------------
% Plot step response using derived (part B) expression for C(t)
t = 0.1:0.01:25;      % define time domain

c0 = step(transfer_fnc, t)'; % MATLAB function

for x = 1:length(t) % calc c(t) for each t [This given function by extra matterial]
    c(x)=1-1.01418*(cos(1.47902*t(x)-(9.59*pi/180)))*(exp((-0.25)*t(x)));
end

syms s
fun_anl = ilaplace(2.25 / (s^2 + 0.5*s + 2.25) * (1/s));
for ii = 1:length(t) % calc c1(t) for each t
    c1(ii) = 1 - exp(-t(ii)/4)*(cos((35^(1/2)*t(ii))/4) + (35^(1/2)*sin((35^(1/2)*t(ii))/4))/35);
end

peak_value = calculate_peak_value(t, c1, peak_time);

[reaction_value, reaction_time, reaction_time_plot] = calculate_reaction(t, c1);

settling_value = get_settling_value(t, c1, Ts);
 

figure(2);
plot(t, c1);
grid on;
hold on;
title('Analitic model function');
ylabel('Amplitude');
ylim([0 2]);
xlabel('Time, s');

plot(reaction_time_plot, reaction_value, '.y', 'MarkerSize', 30);
description = sprintf("Reaction time: %0.3f", reaction_time);
text(reaction_time_plot + OFFSET_X, reaction_value, description);

plot(peak_time, peak_value, '.g', 'MarkerSize', 30); % Mp
description = sprintf("Peak ampl: %0.2f Peak time: %0.3f s; Overshoot: %2.2f  ", peak_value, peak_time, overshoot_prct);
text(peak_time + OFFSET_X, peak_value, description);

plot(Ts, settling_value, '.r', 'MarkerSize', 30); %  setting time ts
description = sprintf("End of porcess time: %0.2f  ", Ts);
text(Ts + OFFSET_X, settling_value, description);


figure(3);
plot(t, c0, t, c1);
title('Matlab and analytical models functions');
ylabel('Amplitude');
xlabel('Time, s');
legend('MATLAB', 'Analytical')
grid on;


error_tr = abs(c1-c0);
figure(4);
plot(t, error_tr);
title('Error beteen Matlab and analytical models');
ylabel('Absolute error');
xlabel('Time, s'); 
grid on;


% static functions
function p_val = calculate_peak_value(time, func, peak_time)
    p_val = time(1);
    for ii = 1:length(func)
        if peak_time >= time(ii)
            p_val = func(ii);
        end
    end
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

function s_val = get_settling_value(time, func, set_time)
    s_val = 0;
    for ii = 1:length(func)
        if  time(ii) >= set_time
            s_val = func(ii);
            break;
        end
    end
end
 



