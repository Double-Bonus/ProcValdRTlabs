function [price, radius] = optimize_cost_f(volume, metal_price, labor_cost)
    X = 0.01:0.001:1; %radius array
    total_labor = (4*pi.*X) + volume./(pi * X.^2);
    total_metal = 2*pi.*X.^2 + ((volume*2) ./ X);
    P = total_labor .* labor_cost  + total_metal .* metal_price;
    [price, p_inx] = min(P);
    radius = X(p_inx);
end