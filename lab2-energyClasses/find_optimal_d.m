function distace = find_optimal_d(roof, wall, floor, window)
%viena optimali? stori? radimui, Funkcij? ??jimo parametrai – pastato atitvar? plotai.

    A = 8;
    B = 3;
    C = 9;
    D = 10;

    TEMP_INSIDE = 22;
    TEMP_OUTSIDE = B - A;
    ENERGY_PRICE_W = 0.05 / 1000; %energijos kaina 0,05 EUR/kWh {ENERGY NEED TO BE IN WATTS?}
    LABOR_COST = 50; %Apšiltinimo sluoksnio darb? kainas priimti 0,5 Eur / cm.

    PRICE_ROOF_MATT = 30;
    PRICE_WALL_MATT = 60;
    PRICE_FLOOR_MATT = 70;
    PRICE_WINDOW_MATT = 7500;
    TIME_HR = 180 * 24 * 10;
    increasing = 1;
    
    area_S = [roof, wall, floor, window];
    temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;

    d_roof = 0.001:0.001:2;     %nereikia  4 uz tenka 1
    d_wall = 0.001:0.001:2;
    d_floor = 0.001:0.001:2;
    d_window = 0.001:0.001:2;

    price_roof = d_roof * area_S(1) * PRICE_ROOF_MATT + d_roof * area_S(1) * LABOR_COST;
    price_wall = d_wall * area_S(2) * PRICE_WALL_MATT + d_wall * area_S(2) * LABOR_COST;
    price_floor = d_floor * area_S(3) * PRICE_FLOOR_MATT + d_floor * area_S(3)* LABOR_COST;
    price_window = d_window * area_S(4) * PRICE_WINDOW_MATT + d_window * area_S(4) * LABOR_COST;

    roof_U = 0.039 ./ d_roof;
    wall_U = 0.035 ./ d_wall;
    floor_U = 0.031 ./ d_floor;
    windows_U = 0.027 ./ d_window;

    
    energy_loss = [roof_U.*area_S(1); wall_U.*area_S(2); floor_U.*area_S(3); windows_U.*area_S(4)];
    if increasing
        tempLost = energy_loss;
        for indx = 1:10
            total_en_price = tempLost * (TIME_HR/10) * temp_diff * ENERGY_PRICE_W;
            tempLost = tempLost*1.091;
        end
    else 
        total_en_price = energy_loss * TIME_HR * temp_diff * ENERGY_PRICE_W;
    end
    total_build_prices = [price_roof; price_wall; price_floor; price_window];
    %total_build_prices = {price_roof, price_wall, price_floor, price_window};

    total = total_build_prices + total_en_price;
    

    [~,ii] = min(total,[],2)
   % out = [X(ii)',Y(:)]
        %[size, inx] = min(S);
        
    distace = d_roof(ii); % return vector for optimal parameters
    
    

    if 1
        sum_total_build = 0;
        sum_en = 0;
        for jj = 1:4
            best_loss_en_W = energy_loss(jj, ii(jj)) * TIME_HR * temp_diff
            sum_total_build = sum_total_build + total_build_prices(jj, ii(jj));
            sum_en = sum_en + best_loss_en_W;
        end
        fprintf('Total build price of optimal d %f\n', sum_total_build);
        
        
        %%% ROI
            back_price = sum_total_build;
            back_el_price_year =  sum_en / 10 * ENERGY_PRICE_W;
            year = 0;
            
            %YEAH ITS HARDCODED NEEDS CHANNING !!!!!!!!!!!!!!!!!
            B_class_cost = 28217;
            B_class_en_cost = 1874;

            test = 1;
            while (B_class_cost < back_price)
                year = year + 1;
                back_price = back_price + back_el_price_year;
                B_class_cost = B_class_cost + B_class_en_cost;
                if increasing
                    back_el_price_year = back_el_price_year*1.091;
                    B_class_en_cost = B_class_en_cost*1.091;
                    test = test*1.091;
                end
            end
            fprintf('Return year %d\n', year);
        
    end
    


end