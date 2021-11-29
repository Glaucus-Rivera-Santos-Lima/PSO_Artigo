%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                         Funcao: 'sobrecarga2'                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function sobre = sobrecarga_2(resultados,sistema2)
    sobre = [[]];
    tamanho = size(resultados.branch);
    cont = 1;
    for k = 1:tamanho(1)
        rest = sqrt(resultados.branch(k,14)^2+resultados.branch(k,15)^2);
        if ceil(rest) >= sistema2.branch(k,6)
            sobre(cont,1) = resultados.branch(k,1); 
            sobre(cont,2) = resultados.branch(k,2);
            cont = cont + 1;
        end
    end 
end