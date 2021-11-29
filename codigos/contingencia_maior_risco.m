%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                    Funcao: 'contingencia_maior_rico'                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function maior_risco = contingencia_maior_risco(sistema1,sistema2)
    configurar = mpoption('pf.alg','DC','verbose',3);

    qtd_linhas_sistema = size(sistema2.branch);
    pi_flow = [[]];
    pi_volt = [[]];
    
    for m = 1:qtd_linhas_sistema(1)
        soma = 0;
        for n = 1:qtd_linhas_sistema(1)
            if m ~= n
                sistema_aux = sistema2;
                sistema_aux.branch(n,11) = 0;
                resultados_aux = runopf(sistema_aux,configurar);
                soma = (sqrt(resultados_aux.branch(m,14)^2+resultados_aux.branch(m,15)^2)/sistema2.branch(m,6))^(2*0.3458) + soma;
            end
        end
        pi_flow(m,1) = sistema2.branch(m,1);
        pi_flow(m,2) = sistema2.branch(m,2);
        pi_flow(m,3) = soma;
    end

    qtd_barras_sistema = size(sistema2.bus);
    
    for m = 1:qtd_linhas_sistema(1)
        soma = 0;
        sistema_aux = sistema2;
        sistema_aux.branch(m,11) = 0;
        resultados_aux = runopf(sistema_aux,configurar);
        for n = 1:qtd_barras_sistema(1)
            soma = (sistema_aux.bus(n,13)/resultados_aux.bus(n,8))^8.3407 + (resultados_aux.bus(n,8)/sistema_aux.bus(n,12))^8.3407 + soma;
        end
        
        pi_volt(m,1) = sistema2.branch(m,1);
        pi_volt(m,2) = sistema2.branch(m,2);
        pi_volt(m,3) = soma;
    end
    
    pi_hibrido = pi_flow(:,1:2);
    pi_hibrido(:,3) = 0.7*pi_flow(:,3)+0.3*pi_volt(:,3);
    
    qtd_linhas = size(sistema1.taxa_falha);
    probabilidade_contingencia = [[]];

    for m = 1:qtd_linhas
        probabilidade_contingencia(m,1) = sistema1.taxa_falha(m,2);
        probabilidade_contingencia(m,2) = sistema1.taxa_falha(m,3);
        probabilidade_contingencia(m,3) = (sistema1.taxa_falha(m,4)) * exp(-(sistema1.taxa_falha(m,4)));
    end

    for m = 1:qtd_linhas
        maior_risco(m,1) = probabilidade_contingencia(m,1);
        maior_risco(m,2) = probabilidade_contingencia(m,2);
        maior_risco(m,3) = probabilidade_contingencia(m,3)*pi_hibrido(m,3);
    end
    clc
    maior_risco = sortrows(maior_risco,3,'descend');
    probabilidade_contingencia = sortrows(probabilidade_contingencia,3,'descend');
    pi_hibrido = sortrows(pi_hibrido,3,'descend');
    
    
