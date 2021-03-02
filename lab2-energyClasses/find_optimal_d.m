%input area of roof wall floor and windows in meters.
%return optimal insulation size in meters for each part 
function distace = find_optimal_d(roof, wall, floor, window)
    A = 8;
    B = 3;

    TEMP_INSIDE = 22;
    TEMP_OUTSIDE = B - A;
    ENERGY_PRICE_W = 0.05 / 1000;
    LABOR_COST = 50; % 50 Eur/m^3, insulation labor cost

    PRICE_ROOF_MATT = 30;
    PRICE_WALL_MATT = 60;
    PRICE_FLOOR_MATT = 70;
    PRICE_WINDOW_MATT = 7500;
    TIME_HR = 180 * 24 * 10; % 10 years in hours
    increasing = 1; % set flag to 1 if electricity price is incresing
    POINT_CNT = 5000; % presition for calculations
    
    area_S = [roof, wall, floor, window];
    temp_diff = TEMP_INSIDE - TEMP_OUTSIDE;
    
    d_roof_B = 0.2437; % width need for achieve B class
    d_wall_B = 0.1750;
    d_floor_B = 0.1240;
    d_window_B = 0.0169;
        
    d_roof = linspace(d_roof_B, 4*d_roof_B, POINT_CNT);
    d_wall = linspace(d_wall_B, 4*d_wall_B, POINT_CNT);
    d_floor = linspace(d_floor_B, 4*d_floor_B, POINT_CNT);
    d_window = linspace(d_window_B, 4*d_window_B, POINT_CNT);
    
    
    price_roof = d_roof * area_S(1) * (PRICE_ROOF_MATT + LABOR_COST);
    price_wall = d_wall * area_S(2) * (PRICE_WALL_MATT + LABOR_COST);
    price_floor = d_floor * area_S(3) * (PRICE_FLOOR_MATT + LABOR_COST);
    price_window = d_window * area_S(4) * (PRICE_WINDOW_MATT + LABOR_COST);

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

    total = total_build_prices + total_en_price;
    
    [~,ii] = min(total,[],2);
      
    distace = [d_roof(ii(1)), d_wall(ii(2)), d_floor(ii(3)), d_window(ii(4))];

    
    

    if 0
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