%o tam reikalinga patalpose palaikyti 22 0C.
%Reikia rasti optimali? pastato atitvaros (stogas, sienos, grindys, langai) vert? (apšiltinimo storio sluoksn?,...
%    o langams stiklo paketo stor?)

%skai?iavimuose naudoti 10 met? atsipirkimo laikotarp?,

%t.y. išlaidos medžiagoms ir ?rengimui turi b?ti lygios energijos nuostoli? kainai per 10 met?, kurie atsirast?
%d?l atitinkamo apšiltinimo sluoksnio ?rengimo.

%Šildymo sezon? laikyti lyg? 180 par?
clear, clc

format short

%C 8390
INSIDE_TEMP = 22;
OUTSIDE_TEMP = 3 - 8;
ENERGY_PRICE = 0.05; %energijos kaina 0,05 EUR/kWh
LABOR_COST = 0.5; %Apšiltinimo sluoksnio darb? kainas priimti 0,5 Eur / cm.
A = 8;
B = 3;
C = 9;
D = 10;

Area = [A*5+150, B*20+700, C*4+200,D*2+30];


building_matterials = { Matterial('Stone roof', 0.039, 30), Matterial('Poly wall', 0.035, 60), ...
    Matterial('Poly floor', 0.031, 70), Matterial('Glass window', 0.027, 7500)};
    
B_class = EnergyClass('B', 0.16, 0.2, 0.25, 1.6);
A_class = EnergyClass('A', 0.14, 0.15, 0.16, 1);
A_plus_class = EnergyClass('A+', 0.12, 0.13, 0.14, 0.9);
A_plus_plus_class = EnergyClass('A++', 0.10, 0.11, 0.12, 0.8);
pasive_class = EnergyClass('Passive', 0.08, 0.10, 0.10, 0.8);


all_energies = { EnergyClass('B', 0.16, 0.2, 0.25, 1.6), EnergyClass('A', 0.14, 0.15, 0.16, 1), ...
EnergyClass('A+', 0.12, 0.13, 0.14, 0.9), EnergyClass('A++', 0.10, 0.11, 0.12, 0.8), ...
EnergyClass('Passive', 0.08, 0.10, 0.10, 0.8)};

%vata = struct('laidumas',0.039, 'Kaina',30);

area = struct('Roof',A*5+150, 'Wall',B*20+700,'Floor',C*4+200, 'Windows',D*2+30);

tessssssssss = EnergyClass('B', 0.16, 0.2, 0.25, 1.6);

d_Roofs = zeros(1,length(all_energies));
for i = 1:length(all_energies)
    d_Roofs(i) = building_matterials(1).Conductivity_q / all_energies(i).Roof_U;
end

%d = vata.laidumas / B_klase.Stogai.U

%V = d* B_klase.Stogai.Area

%price_total = V * vata.Kaina % dar darbu kainu reikia!!
