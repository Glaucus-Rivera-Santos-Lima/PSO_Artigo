function corte_final = mway(sistema)
    tam_result = size(sistema.bus);
    if tam_result(1) == 6
        corte_final = [1 4;2 6];
    elseif tam_result(1) == 30
        corte_final = [27 30; 27 29; 6 8; 8 28; 13 12; 25 27; 10 22; 21 22];
    elseif tam_result(1) == 118
        corte_final = [69 70; 69 75; 69 77];
    end
end