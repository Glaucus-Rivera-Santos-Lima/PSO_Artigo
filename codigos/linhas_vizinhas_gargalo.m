%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                    Funcao: 'linhas_vizinhas_gargalo'                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function linhas_vizinhas = linhas_vizinhas_gargalo(gargalos, sistema)
    linhas = sistema.branch;
    tam_linhas = size(linhas);
    tam_gargalos = size(gargalos);
    cont = 1;
    for m = 1:tam_gargalos(1)
        for n = 1:tam_linhas(1)
            if (gargalos(m,1) == linhas(n,1) || gargalos(m,2) == linhas(n,2) || gargalos(m,1) == linhas(n,2) || gargalos(m,2) == linhas(n,1))
                for o = 1:tam_gargalos(1)
                    if ~(gargalos(o,1) == linhas(n,1) && gargalos(o,2) == linhas(n,2)) || (gargalos(o,2) == linhas(n,1) && gargalos(o,1) == linhas(m,2))
                        linhas_vizinhas(cont,1:2) = linhas(n,1:2);
                        cont = cont + 1;
                    end
                end
            end
        end
    end
    
end