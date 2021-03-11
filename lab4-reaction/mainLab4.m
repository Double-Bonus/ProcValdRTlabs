close all; 
clc, clear

OFFSET = 2;

transfer_fnc = tf(2.25,[1 0.5 2.25])         % define closed-loop transfer fn 
% 'Response Characteristics'
P=pole(transfer_fnc)                 % find closed-loop poles
Pre = abs(real(P(1)));                % find real part of pole
Pim = abs(imag(P(1)));            % find imag part of pole
frequency_wn = sqrt(Pre*Pre+Pim*Pim)       % calc natural frequency 
damping_ratio=(Pre/frequency_wn)         % calc damping ratio
overshoot_prct = (exp(-1*Pre*pi/Pim))*100   % calc percent overshoot

peak_time=pi/Pim           % calc peak time 
Ts=4/Pre       % calc settling time  (0.02 indicator) 

%--------------------------------------------------------------------
% Plot step response of T(s) using Matlab STEP function
step(transfer_fnc)  %PLOTING
%-------------------------------------------------------------------
% Plot step response using derived (part B) expression for C(t)
t=[0.1:0.01:25];         % define time domain

for x=1:length(t)                   % calc c(t) for each t
    c(x)=1-1.01418*(cos(1.47902*t(x)-(9.59*pi/180)))*(exp((-0.25)*t(x)));
end


syms s
fun_anl= ilaplace(2.25 / (s^2 + 0.5*s + 2.25) * (1/s))
for ii=1:length(t)                   % calc c(t) for each t
    c2(ii) = 1 - exp(-t(ii)/4)*(cos((35^(1/2)*t(ii))/4) + (35^(1/2)*sin((35^(1/2)*t(ii))/4))/35);
end


% I funkcijas galime sudet situs
peak_value = t(1);
for ii = 1:length(c)
    if peak_time >= t(ii)                  %CAN CHANGE
        peak_value = c(ii);
    end
end
peak_value


reaction_time = 0;
reaction_time_str = 0;
reaction_time_plot = 0;
reaction_value = 0;
last_value = c(length(c));
for ii = 1:length(c)
    if (0 == reaction_time_str) && (c(ii) > 0.1 * last_value)                  %CAN CHANGE
        reaction_time_str = t(ii);
    elseif (c(ii) >= 0.9 * last_value)
        reaction_value = c(ii)
        reaction_time = t(ii) - reaction_time_str
        reaction_time_plot = t(ii)
        break; %found reaction time
    end
end


settling_value = 0;
for ii = 1:length(c)
    if  t(ii) >= Ts
        settling_value = c(ii);
        break;
    end
end
 

grid on;
figure(2) ;              % open new plotting window
plot(t,c)        % plot c(t)
hold on;
title('Analitic model function')


plot(reaction_time_plot, reaction_value, 'o'); %ADD  COLOR
% description = 'Reaction time: ' + num2str(reaction_time_plot) + 'in s';
description = sprintf("Reaction time: %0.3f", reaction_time);
text(reaction_time_plot + OFFSET, reaction_value, description);

plot(peak_time, peak_value, 'o'); % Mp
description = sprintf("Peak ampl: %0.2f Peak time: %0.3f s; Overshoot: %2.2f  ", peak_value, peak_time, overshoot_prct);
text(peak_time + OFFSET, peak_value, description);

plot(Ts, settling_value, 'o'); %  setting time ts
description = sprintf("End of porcess time: %0.2f  ", Ts);
text(Ts + OFFSET, settling_value, description);


figure(3);               % open new plotting window
plot(t, c, t, c2);       % plot c(t)
title('Two functions');
ylabel('Amplitude');
xlabel('Time, s');
legend('MATLAB', 'Analytical')

error_tr = abs(c2-c);
figure(4);
plot(t, error_tr);
title('Error beteen Matlab and analytical models');
ylabel('Absolute error');
xlabel('Time, s'); 

