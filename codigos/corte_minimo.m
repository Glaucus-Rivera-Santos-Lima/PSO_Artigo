%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                         Funcao: 'corte_minimo'                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [corte_final,t,s] = corte_minimo(sistema)
[q_linhas,c] = size(sistema.branch);
[q_barras,c] = size(sistema.bus);


corte_final = [[]];
%Cria uma matriz de zeros onde serao inseridos as informacoes das linhas
linhas_sep = zeros(q_linhas,3);

%Armazena a informacao e potencia de cada uma das linhas
for k = 1:q_linhas
    linhas_sep(k,1) = sistema.branch(k,1);
    linhas_sep(k,2) = sistema.branch(k,2);
    linhas_sep(k,3) = sistema.branch(k,6);
end

%Criando os vertices s e t
%s = indice da ultima barra + 1
%t = indice da ultima barra + 2
s = q_barras + 1;
t = q_barras + 2;

%Armazena a quantidade de linhas e colunas tem a matriz com os dados de
%geracao
[l_gen,c_gen] = size(sistema.gen);

%O k esta armazenando a quantidade de linhas que tem o SEP
k = k+1;

%Adiciona as novas linhas que ligam o SEP ao s e t
for l = 1:q_barras
    if sistema.bus(l,2) == 3 || sistema.bus(l,2) == 2
        linhas_sep(k,1) = s;
        linhas_sep(k,2) = sistema.bus(l,1);
        for m = 1:l_gen
            if sistema.gen(m,1) == linhas_sep(k,2)
                linhas_sep(k,3) = sqrt(sistema.gen(m,2)^2 + sistema.gen(m,3)^2);
            end
        end
        k = k+1;
    elseif sistema.bus(l,2) == 1
        linhas_sep(k,2) = t;
        linhas_sep(k,1) = sistema.bus(l,1);
        linhas_sep(k,3) = sqrt(sistema.bus(l,3)^2 + sistema.bus(l,4)^2);
        k = k+1;
    end
end

stop = 0;

while stop == 0
    
    %Criando grafo
    grafo = digraph(linhas_sep(:,1),linhas_sep(:,2),linhas_sep(:,3));
    
    %Calculando o fluxo maximo para obter os vertices pertencentes a cada
    %parte do corte
    [mf,~,cs,ct] = maxflow(grafo,s,t);
   
    %Quantidade de linhas no SEP, contando com as novas adicionadas
    [l_sep,c_sep] = size(linhas_sep);
    
    %Percorre as linhas do SEP e verifica se elas serao de corte minimo de
    %acordo com os vetores cs e ctfunction [corte,t,s] = corte_minimo(sistema)
    
        cont = 1;
        corte = [[]];
        for m = 1:l_sep
            for n = 1:length(cs)
                for o = 1:length(ct)
                    if (cs(n) == linhas_sep(m,1) && ct(o) == linhas_sep(m,2))||(cs(n) == linhas_sep(m,2) && ct(o) == linhas_sep(m,1))
                        corte(cont,1) = linhas_sep(m,1);
                        corte(cont,2) = linhas_sep(m,2);
                        cont = cont + 1;
                    end
                end
            end
        end
        
        tam_corte = size(corte);
        for m = 1:tam_corte(1)
            if corte(m,1) == t || corte(m,2) == t || corte(m,1) == s || corte(m,2) == s
                corte(m,3) = 1;
            else
                corte(m,3) = 0;
            end
        end
        corte_final = [[]];
        cont = 1;
        for m = 1:tam_corte(1)
            if corte(m,3) == 0
                corte_final(cont,:) = corte(m,1:2);
                cont = cont + 1;
            end
        end
        tam_cfinal = size(corte_final);
        if tam_cfinal(1) > 0
            stop = 1;
        else
            for m = 1:l_sep
                if linhas_sep(m,1) == s || linhas_sep(m,2) == s || linhas_sep(m,1) == t || linhas_sep(m,2) == t
                    linhas_sep(m,3) = linhas_sep(m,3)*2;
                end
            end
        end
    end
end



