%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                      Funcao: 'cimprime_sobrecarga2'                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function imprime_sobrecarga_2(sobrecarga)
    tam_sobrecarga = size(sobrecarga);
    if tam_sobrecarga(1) > 0
        fprintf('\n============================');
        fprintf('\n|  Linhas sobrecarregadas  |');
        fprintf('\n============================');
        fprintf('\nBarra de        Barra para');
        fprintf('\n---------       -----------\n');
        for m = 1:tam_sobrecarga
            fprintf('%5d',sobrecarga(m,1)); fprintf('%17d',sobrecarga(m,2));
            fprintf('\n');
        end
    else
       fprintf('\n=====================================');
       fprintf('\nNao existem linhas congestionadas')
       fprintf('\n=====================================\n')
    end
        