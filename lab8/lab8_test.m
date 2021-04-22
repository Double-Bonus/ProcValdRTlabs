clc, clear, close all;

T = 9;
K = 1;
SIM_TIME = 60;
h = 0.5;
t = 0:h:SIM_TIME;
fun_nr = 1; % Select which function to analize 1, 2, 3

syms s % to time domain
transf_fnk_1 = ilaplace( K / (T*s + 1) * (1/s));
transf_fnk_2 = ilaplace(K / (T*s^2 + T*s + 1) * (1/s));
transf_fnk_3 = ilaplace((K*s +1 ) / (T*s + 1) * (1/s));

fun_array = [transf_fnk_1 transf_fnk_2 transf_fnk_3];

actual_y = matlabFunction(fun_array(fun_nr));
y = actual_y(t);

[y_el, t_el] = get_euler_aprox_f(fun_array(fun_nr), h, SIM_TIME);
[y_fixed, t_fix] = get_euler_fixed_aprox_f(fun_array(fun_nr), h, SIM_TIME);
[y_mod, t_mod] = get_euler_mod_aprox_f(fun_array(fun_nr), h, SIM_TIME);
[y_run, t_run] = get_rung_kut_aprox_f(fun_array(fun_nr), h, SIM_TIME);


grid on
plot(t, y, t_el, y_el, t_fix, y_fixed, t_mod, y_mod, t_run, y_run);
title('Function approximation');
xlabel('t, s');
ylabel('amplitude');
legend('Correct function', 'Euler', 'Euler Improved', 'Euler Fixed', 'Runge-Kutta');


[h_aprox, y_aprox, t_test] = get_aprox_step_f(5, @get_euler_aprox_f, fun_array(fun_nr), SIM_TIME, 10, h)
