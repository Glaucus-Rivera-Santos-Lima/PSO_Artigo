%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                          Funcao: 'restricao'                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function restricao(gen,ong,conf)
    ctol = conf.opf.violation;
    for k = 1:length(ong)
        i = ong(k);
        if (gen(i, PG) < gen(i, PMIN) + ctol || ...
                gen(i, PG) > gen(i, PMAX) - ctol || ...
                gen(i, MU_PMIN) > ptol || gen(i, MU_PMAX) > ptol))
            fprintf(fd, '\n%4d%6d ', i, gen(i, GEN_BUS));
            if gen(i, PG) < gen(i, PMIN) + ctol || gen(i, MU_PMIN) > ptol
                fprintf(fd, '%10.3f', gen(i, MU_PMIN));
            else
                fprintf(fd, '      -   ');
            end
            if gen(i, PG)
                fprintf(fd, '%10.2f%10.2f%10.2f', gen(i, [PMIN, PG, PMAX]));
            else
                fprintf(fd, '%10.2f       -  %10.2f', gen(i, [PMIN, PMAX]));
            end
            if gen(i, PG) > gen(i, PMAX) - ctol || gen(i, MU_PMAX) > ptol
                fprintf(fd, '%10.3f', gen(i, MU_PMAX));
            else
                fprintf(fd, '      -   ');
            end
        end
    end
end