function [size, radius] = optimize_size_analitic_f(volume)
    fun=@(x) 2*pi*x(1)^2 + ((volume*2) / x(1)); % lambda function
    radius=fminsearch(fun, 0);
    size=fun(radius);
end