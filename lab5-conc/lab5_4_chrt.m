%Sketch Bode diagram when K1 = K2 = 1, and investigate stability of the system

clc, clear, close all;

K1 = 1;
K2 = 1;
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
bode(G)                                              % make a bode plot
grid on
title(['System Frequency Response with K1= ' , num2str(K1) ',K2= ' , num2str(K2)])
[Gm,Pm,Wcg,Wcp] = margin(G);                         % find margins and margin frequencies
K = Gm                                               % display K for stability






% maksimal? perreguliavim?, reakcijos laik?, nusistov?jimo trukm?, statin? paklaid? ir 
% maksimalaus perreguliavimo laik? (reakcijai ? vienetin? ??jim?), 
% kai stiprinimo koeficientai yra tokie kaip pirmoje ir antroje uduotyse. 


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
 

