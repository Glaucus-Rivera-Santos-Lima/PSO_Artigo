%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                         Funcao: 'imprime_result'                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function imprime_result(gargalo,valor,taxa,garg_otimo)
    clc
    fprintf('--------------------------------------------------\n');
    fprintf('                     Perfil Otimo                 \n')
    fprintf('--------------------------------------------------\n')
    fprintf('|      GARGALO     |   VALOR $/hr  |     TAXA    |\n');
    fprintf('--------------------------------------------------\n');
    for k = 1:length(valor)
        if valor(k) == Inf
            fprintf('%9d',gargalo(k,1)); fprintf(' - '); fprintf('%d',gargalo(k,2)); fprintf('\t\t\t   x'); fprintf('\t\t\t  x'); fprintf('\n')
        else
            fprintf('%9d',gargalo(k,1)); fprintf(' - '); fprintf('%d',gargalo(k,2)); fprintf('%18.2f',valor(k)); fprintf('%14.2f',1-taxa(k)); fprintf('\n')
            %fprintf('|     %d - %d        |    %.2f    |     %.2f    |\n',gargalo(k,1),gargalo(k,2),valor(k),taxa(k));
        end
    end
    fprintf('--------------------------------------------------\n');
    fprintf('\n')
    fprintf('Linha para alocacao otima: %d - %d\n', garg_otimo(1), garg_otimo(2));

end