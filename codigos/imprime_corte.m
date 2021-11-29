%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                         Funcao: 'imprime_corte'                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function imprime_corte(corte)
    tam_corte = size(corte);
    if tam_corte(1) > 0
        fprintf('\n============================');
        fprintf('\n|  Linhas do corte minimo  |');
        fprintf('\n============================');
        fprintf('\nBarra de        Barra para');
        fprintf('\n---------       -----------\n');
        for m = 1:tam_corte
            fprintf('%5d',corte(m,1)); fprintf('%17d',corte(m,2));
            fprintf('\n');
        end
   % else
      % fprintf('\n=====================================');
       %fprintf('\nNao existem linhas congestionadas')
       %fprintf('\n=====================================\n')
    end
        