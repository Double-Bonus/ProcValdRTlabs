function [volume, metal_price, labor_cost] = get_user_input()
    default_value = 1;
    input_names = ["Tank volume: ", "Metal price: ", "Labor cost: "];
    buffer = [1, 1, 1]; 
    
    for i = 1:length(input_names)
        buffer(i) = input(convertStringsToChars(strcat("Input ", input_names(i))));
        if(~isnumeric(buffer(i)))
            fprintf('Incorect format using default value: %d\n', default_value);
            buffer(i) = default_value;
        else
            fprintf('Inserted ' + input_names(i) + '%d\n' ,buffer(i));
        end
    end   
    volume = buffer(1);
    metal_price = buffer(2);
    labor_cost = buffer(3); 
end