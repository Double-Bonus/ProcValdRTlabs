clc, clear, close all;

T = 9;
K = 1;
SIM_TIME = 50;
h = 0.5;
t = 0:h:SIM_TIME;
fun_nr = 1; % Select which function to analize 1, 2, 3
error_prct = 5;

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
legend('Correct function', 'Euler', 'Euler Fixed', 'Euler Modificated', 'Runge-Kutta');

for fun_nr = 1:3
    [h_el, y_h_eul, t_h_eul] = get_aprox_step_f(error_prct, @get_euler_aprox_f, fun_array(fun_nr), SIM_TIME, SIM_TIME/2);
    [h_el_fix, y_h_eul_fix, t_h_eul_fix] = get_aprox_step_f(error_prct, @get_euler_fixed_aprox_f, fun_array(fun_nr), SIM_TIME, SIM_TIME/2);
    [h_el_mod, y_h_eul_mod, t_h_eul_mod] = get_aprox_step_f(error_prct, @get_euler_mod_aprox_f, fun_array(fun_nr), SIM_TIME, SIM_TIME/2);
    [h_runKut, y_h_runKut, t_h_runKut] = get_aprox_step_f(error_prct, @get_rung_kut_aprox_f, fun_array(fun_nr), SIM_TIME, SIM_TIME/2);
    
    fprintf('Euler step = %f; Euler fixed step = %f; Euler mod step = %f; Run-Kut step = %f\n', h_el, h_el_fix, h_el_mod, h_runKut );

    figure(fun_nr+1)
    plot(t, y, t_h_eul, y_h_eul, t_h_eul_fix, y_h_eul_fix, t_h_eul_mod, y_h_eul_mod, t_h_runKut, y_h_runKut);
    title(['Function approximation with maximum time with ' ,  num2str(error_prct), '% error', ' for function nr: ' num2str(fun_nr) ]);
    xlabel('t, s');
    ylabel('amplitude');
    legend('Correct function', 'Euler', 'Euler Fixed', 'Euler Modificated', 'Runge-Kutta');
    
    
    
    [rctn_value, rctn_time, rctn_time_plot] = calculate_reaction_f(t_h_eul, y_h_eul)
    [p_val, p_time] = calculate_peak(t_h_eul, y_h_eul)
    [s_val, s_time] = get_settling_values(t_h_eul, y_h_eul, p_time)
%     [t_val, t_time] = calculate_time_constant(t_h_eul, y_h_eul)
    over_val = calculate_overshoot_prc(y_h_eul)
end




