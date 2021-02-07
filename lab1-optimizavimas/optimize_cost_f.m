function [price, radius] = optimize_cost_f(volume, metal_price, labor_cost)
    X = 0.01:0.001:1; %radius array
    fprintf('labor_cost: %f\n', labor_cost);
    fprintf('metal_price: %f\n', metal_price);

    %Kainos
    total_labor = ((4*pi.*X) + volume./(pi * X.^2) ) .* labor_cost;
    total_metal = metal_price.*(2*pi.*X.^2 + ((volume*2) ./ X));
    P = total_labor + total_metal;
    [price, p_inx] = min(P);
    radius = X(p_inx);
end