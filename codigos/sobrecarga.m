%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ci�ncias Exatas - ICEA                   %
%                                                                         %        
%                          Funcao: 'sobrecarga'                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function sobre = sobrecarga(resultados)
    sobre = [[]];
    tamanho = size(resultados.branch);
    cont = 1;
    for k = 1:tamanho(1)
        rest = sqrt(resultados.branch(k,14)^2+resultados.branch(k,15)^2);
        if rest > resultados.branch(k,6) || rest > resultados.branch(k,6)
            sobre(cont,1) = resultados.branch(k,1); 
            sobre(cont,2) = resultados.branch(k,2);
            cont = cont + 1;
            fprintf('Aqui');
            pause
        end
    end 
end