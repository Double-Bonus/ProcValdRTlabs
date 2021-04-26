function [x, y, t] = calculate_trajectory_f(h0, v0, angle_d, time, D_v)
%Fuction that calculates ball trajectory - x, y, t
    
    STEP = 0.001; % if takes to long increse
    t = 0:STEP:time;
        
    pos_x(1) = 0;
    pos_y(1) = h0;
    vel_x(1) = cosd(angle_d) * v0;
    vel_y(1) = cosd(angle_d) * v0;
    
    for ii = 1:length(t)
        
        if t(ii)==0
            continue;
        end

        drag_y = vel_y(ii-1).^2 .* D_v;
        drag_x = vel_x(ii-1).^2 .* D_v;
        
        if (vel_y(ii-1) > 0)
            drag_y = -drag_y; 
        end
        
        accel_y(ii) = -9.81 + drag_y;    
        accel_x(ii) = -drag_x;

        vel_y(ii) = vel_y(ii-1) + accel_y(ii).*STEP;
        vel_x(ii) = vel_x(ii-1) + accel_x(ii).*STEP;

        pos_y(ii) = pos_y(ii-1) + vel_y(ii-1).*STEP + (accel_y(ii) .* STEP.^2) ./ 2;
        pos_x(ii) = pos_x(ii-1) + vel_x(ii-1).*STEP + (accel_x(ii) .* STEP.^2) ./ 2;

        if pos_y(ii) <= 0
            vel_y(ii) = -0.8 .* vel_y(ii);
            pos_y(ii) = 0;
        end

    end
    x = pos_x;
    y = pos_y;
 
end
