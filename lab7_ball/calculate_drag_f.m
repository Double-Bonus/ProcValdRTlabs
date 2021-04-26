function drag = calculate_drag_f(d_coef, rho_air, m_ball, r_ball)
%retuns drag for sphere in m/s^2

    area = 2*pi*r_ball^2;
    drag = (d_coef * 0.5 * area * rho_air) / m_ball;
end
