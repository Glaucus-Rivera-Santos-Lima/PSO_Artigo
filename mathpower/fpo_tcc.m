function [s,t,corte] = corte_minimo(resultados)
    [q_linhas,c] = size(resultados.branch);
    [q_barras,c] = size(resultados.bus);

    %Cria uma matriz de zeros onde serão inseridos as informações das linhas
    linhas_sep = zeros(q_linhas,3);

    %Armazena a informacao e potencia de cada uma das linhas
    for k = 1:q_linhas
        linhas_sep(k,1) = resultados.branch(k,1);
        linhas_sep(k,2) = resultados.branch(k,2);
        linhas_sep(k,3) = resultados.branch(k,14);
    end

    %Criando os vertices s e t
    %s = indice da ultima barra + 1
    %t = indice da ultima barra + 2
    s = q_barras + 1;
    t = q_barras + 2;

    %armazena a quantidade de linhas e colunas tem a matriz com os dados de
    %geração
    [l_gen,c_gen] = size(resultados.gen);

    %o k está armazenando a quantidade de linhas que tem o sep
    k = k+1;

    %Adiciona as novas linhas que ligam o sep ao s e t
    for l = 1:q_barras
        if resultados.bus(l,2) == 3 || resultados.bus(l,2) == 2
            linhas_sep(k,1) = s;
            linhas_sep(k,2) = resultados.bus(l,1);
            for m = 1:l_gen
                if resultados.gen(m,1) == linhas_sep(k,2)
                    linhas_sep(k,3) = resultados.gen(m,2);
                end
            end
            k = k+1;
        elseif resultados.bus(l,2) == 1
            linhas_sep(k,2) = t;
            linhas_sep(k,1) = resultados.bus(l,1);
            linhas_sep(k,3) = resultados.bus(l,3);
            k = k+1;
        end
    end

    % %Cria a matriz de adjacencia do grafo
    % %Armazena a quantidade de linhas e colunas da matriz linhas_sep
    [qtd_linhas,qtd_colunas] = size(linhas_sep);
    % %a matriz de adjacencia nxn onde n é o numero de vértices + 2, onde esses
    % %ultimos sao os vertices s e t
    grafo = zeros(q_barras+2);
    for k = 1:qtd_linhas
        grafo(linhas_sep(k,1),linhas_sep(k,2)) = linhas_sep(k,3);
    end
    corte = minCut(grafo,s,t);
end


