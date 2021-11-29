%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                       Funcao: 'verifica_gargalos'                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function garg = verifica_gargalos(cortes,restricoes,t,s)
    gargalos = [[]];
    tam_cortes = size(cortes);
    tam_restricoes = size(restricoes);
    for k = 1:tam_cortes
        cortes(k,3) = 1;
    end
    cont = 1;
    for l = 1:tam_restricoes(1)
       
        for k = 1:tam_cortes(1)
            if (cortes(k,1) == restricoes(l,1) && cortes(k,2) == restricoes(l,2))
                cortes(k,3) = 0;
            end
        end
    end
    for l = 1:tam_restricoes(1)
        for k = 1:tam_cortes(1)
            verifica_presenca = 0;
            
            if (cortes(k,1) == restricoes(l,1) || cortes(k,1) == restricoes(l,2) || cortes(k,2) == restricoes(l,1) || cortes(k,2) == restricoes(l,2)) && (cortes(k,3) == 1)
                tam_gargalos = size(gargalos);
                if tam_gargalos(1) == 0
                    gargalos(cont,:) = cortes(k,1:2);
                    cont = cont + 1;
                end
                tam_gargalos = size(gargalos);
                for m = 1:tam_gargalos(1)
                    if cortes(k,1) == gargalos(m,1) && cortes(k,2) == gargalos(m,2)
                        verifica_presenca = 1;
                    end
                end
                if verifica_presenca == 0
                    gargalos(cont,:) = cortes(k,1:2);
                    cont = cont + 1;
                end
            end
        end
    end
    tam_gargalos = size(gargalos);
    for m = 1:tam_gargalos(1)
        if gargalos(m,1) == t || gargalos(m,2) == t || gargalos(m,1) == s || gargalos(m,2) == s
            gargalos(m,3) = 1;
        else
            gargalos(m,3) = 0;
        end
    end
    garg = [[]];
    cont = 1;
    for m = 1:tam_gargalos(1)
        if gargalos(m,3) == 0
            garg(cont,:) = gargalos(m,1:2);
            cont = cont + 1;
        end
    end
end