clc, clear
T = 9;
K = 1;

syms s
transf_fnk_1 = ilaplace( K / (T*s + 1))
transf_fnk_2 = ilaplace(K / (T*s^2 + T*s + 1))
transf_fnk_3 = ilaplace((K*s +1 ) / (T*s + 1))

syms t
f_1(t) = exp(-t/9)/9;
f_2(t) =(2*5^(1/2)*exp(-t/2)*sinh((5^(1/2)*t)/6))/15;
f_3(t) = (8*exp(-t/9))/81 + dirac(t)/9;

if 1
%Euler metd:
h = 0.5;
x = 0:h:10;
else % VIENETINIS SUOLIS???
    x(1) = 1;
    h = 10;
    for j = 2:h-1
        x(j) = 1;
    end
    
end


y = zeros(size(x)); % allocate the result y
y(1) = f_1(0); % the initial y value  ???????????
n = numel(y);
derived_1 = diff(f_1) % the expression for y' in your DE
for i=1:n-1
    y(i+1) = y(i) + h * derived_1(x(i));
end


true_y_1 = zeros(size(x));
for i = 1:n
    true_y_1(i) =f_1(x(i));
end
% true_y_1 = f_1(0:h:10)



Y = exp(-x/9)/9;
plot(x, Y, x, y)