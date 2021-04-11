%Sketch Bode diagram when K1 = 0.1 and K2 = 0.04, and investigate the stability of the system

clc;
close all;
clear all;
K1=0.1;
K2=0.04;
T=1.5;                                                                   % define time delay required by conveyor
%------------------------------------------
% Tank and Output Valve G(s)
%------------------------------------------
num=5;                                                                  % define numerator of Tank and output valve
dent=[5 1];                                                             % define denominator of Tank and output valve
G1=tf(num, dent);                                                   % create transfer function for Tank and output valve
%-------------------------------
% Controller Gc(s)
%-------------------------------
num1=[K1 K2];                                                      % define numerator of Controller
dent1=[1 0];                                                           % define denominator of Controller
Gc=tf(num1, dent1);                                                % create transfer function for Controller
%-------------------------
% Conveyor
%-------------------------
[num2, dent2]=pade(T,5);                                       % using pade function to find numerator and denominator
Conveyor=tf(num2, dent2);                                      % create transfer function for Conveyor
G=G1*Gc*Conveyor;
figure
bode(G)                                                                 % make a bode plot
grid on
title(['System Frequency Response with K1= ' , num2str(K1) ',K2= ' , num2str(K2)])
[Gm,Pm,Wcg,Wcp]=margin(G);                             % find margins and margin frequencies
K=Gm                                                                    % display K for stability