clc, clear, close all;

K1 = 0;
T = 1.5;                                         % define time delay required by conveyor
%------------------------------------------
% Tank and Output Valve G(s)
%------------------------------------------
num = 5;                                         % define numerator of Tank and output valve
dent = [5 1];                                    % define denominator of Tank and output valve
G1 = tf(num, dent);                              % create transfer function for Tank and output valve
%-------------------------
% Conveyor
%-------------------------
[num2, dent2] = pade(T,5);                       % using pade function to find numerator and denominator
Conveyor = tf(num2, dent2);                      % create transfer function for Conveyor
%-------------------------------
% Controller Gc(s)
%-------------------------------
for K2 = 0.001:0.001:2
          num1 = [K1 K2];                        % define numerator of Controller
          dent1 = [1 0];                         % define denominator of Controller
          Gc = tf(num1, dent1);                  % create transfer function for Controller
          G = G1*Gc*Conveyor;                    % calculate forward transfer function
          S = allmargin(G);                      % retrieve margin and frequency information
          if 0 == S.Stable                       % if field stable of allmargin result S is 0 then system is unstable
                    K2max = K2-0.001             % for unstable system, K2max (stable) is last K2 value tested
                    break;
          end
end
