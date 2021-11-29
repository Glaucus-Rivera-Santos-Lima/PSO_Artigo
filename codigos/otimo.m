%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                              Funcao: 'otimo'                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [garg,val,tx,taxa_otima,result_otimo,gargalo_otimo,sistema_otimo] = otimo(sistema,gargalos,configuracao,sistema2)
    valor_otimo = Inf;
    result_otimo = [];
    sistema_otimo = [];
    gargalo_otimo = [];
    taxa_otima = 0;
    tam_gargalos = size(gargalos);
    garg = [[]];
    val = [];
    tx = [];
    for k = 1:tam_gargalos(1)
        gargalo_k = gargalos(k,:);
        [valor_k, sistema_k, result_k, taxa_k] = otimo_2(sistema,gargalo_k,configuracao,sistema2);
        garg(k,:) = gargalo_k;
        val(k) = valor_k;
        tx(k) = taxa_k;
        if(length(result_k) ~= 0)
            sobrecar = sobrecarga_2(result_k,sistema2);
            tam_sobrecar = size(sobrecar);
            if valor_k < valor_otimo && tam_sobrecar(1) == 0
                valor_otimo = valor_k;
                result_otimo = result_k;
                sistema_otimo = sistema_k;
                gargalo_otimo = gargalo_k;
                taxa_otima = taxa_k;
            end
        end
    end
end