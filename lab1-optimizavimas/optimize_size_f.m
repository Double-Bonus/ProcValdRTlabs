function [size, radius] = optimize_size_f(volume)
    X = 0.01:0.001:1;
    S = 2*pi.*X.^2 + ((volume*2) ./ X);
    [size, inx] = min(S);
    radius = X(inx);
end