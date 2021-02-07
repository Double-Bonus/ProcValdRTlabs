%Simple optimization problem
% Lab work 2021
%%%%%%%%%%%%%%%%%

clc, clear

[volume, metal_price, labor_cost] = get_user_input();

tic;
[tank_size, tank_radius] = optimize_size_f(volume);
toc;
fprintf('Optimal S: %f\n', tank_size);
fprintf('Optimal R: %f\n', tank_radius);


%labor_cost = 1;
%metal_price = 1;

fprintf('labor_cost: %f\n', labor_cost);
fprintf('metal_price: %f\n', metal_price);

[P_min, radius] = optimize_cost_f(volume, metal_price, labor_cost);
fprintf('Final price: %f\n', P_min);
fprintf('Optimalus R: %f\n', radius);


[tank_open_size, tank_open_radius] = optimize_size_open_f(volume);
fprintf('Optimal S: %f, with open end tank.\n', tank_open_size);
fprintf('Optimal R: %f, with open end tank.\n', tank_open_radius);



[P_min_open, radius_open] = optimize_cost_open_f(volume, metal_price, labor_cost);
fprintf('Final price: %f\n', P_min_open);
fprintf('Optimalus R: %f\n', radius_open);

