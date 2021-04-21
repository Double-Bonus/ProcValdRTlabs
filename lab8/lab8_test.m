clc, clear, close all;

T = 9;
K = 1;
SIM_TIME = 50;

syms s % to time domain
transf_fnk_1 = ilaplace( K / (T*s + 1) * (1/s))
transf_fnk_2 = ilaplace(K / (T*s^2 + T*s + 1) * (1/s))
transf_fnk_3 = ilaplace((K*s +1 ) / (T*s + 1) * (1/s))


h = 0.0001;
t = 0:h:SIM_TIME;
actual_y = matlabFunction(transf_fnk_1);
y = actual_y(t);
plot(t, y);


[y_el, t_el] = get_euler_apox_f(transf_fnk_1, 0.5, SIM_TIME);
[y_fixed, t_fix] = get_euler_fixed_apox_f(transf_fnk_1, 1, SIM_TIME);
[y_mod, t_mod] = get_euler_mod_apox_f(transf_fnk_1, 1, SIM_TIME);

[y_run, t_run] = get_rung_kut_apox_f(transf_fnk_1, 1, SIM_TIME);


plot(t, y, t_el, y_el, t_fix, y_fixed, t_mod, y_mod, t_run, y_run);