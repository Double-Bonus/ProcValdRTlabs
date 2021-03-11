% Simple optimization problem
% Lab work 2021, PVRT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear, close all;

[volume, metal_price, labor_cost] = get_user_input();

fprintf('---------------------------\n');
tic;
[tank_size, tank_radius] = optimize_size_f(volume);
toc;
fprintf('Optimal S: %f\n', tank_size);
fprintf('Optimal R: %f\n', tank_radius);

[price_min, radius] = optimize_cost_f(volume, metal_price, labor_cost);
fprintf('---------------------------\n');
fprintf('Final price: %f\n', price_min);
fprintf('Optimal R: %f\n', radius);

[tank_open_size, tank_open_radius] = optimize_size_open_f(volume);
fprintf('---------------------------\n');
fprintf('Optimal S: %f, with open end tank.\n', tank_open_size);
fprintf('Optimal R: %f, with open end tank.\n', tank_open_radius);

[P_min_open, radius_open] = optimize_cost_open_f(volume, metal_price, labor_cost);
fprintf('---------------------------\n');
fprintf('Final price: %f, with open end tank.\n', P_min_open);
fprintf('Optimalus R: %f, with open end tank.\n', radius_open);

