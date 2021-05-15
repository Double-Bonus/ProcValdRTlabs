clc, clear, close all;

K1 = 0;
K2 = 0.14;
T = 1.5;  

num = 5;                                                
dent = [5 1];                                                             
G1 = tf(num, dent);                

num1 = [K1 K2];                                                      
dent1 = [1 0];                                                           
Gc = tf(num1, dent1);                                                
[num2, dent2] = pade(T,5);                                       
Conveyor = tf(num2, dent2);                                      
G = G1*Gc*Conveyor;

figure
grid on
nyquist(G)
title(['Nyquist diagram, the K2 = ' , num2str(K2)])