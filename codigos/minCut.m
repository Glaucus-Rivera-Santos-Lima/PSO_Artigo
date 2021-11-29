%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                            Funcao: 'minCut'                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function corte = minCut(grafo,origem,sorvedouro)
    [linhas,colunas] = size(grafo);
    grafo_original = grafo;
    pais = [];
    for k = 1:linhas
        pais(k) = -1;
    end
    fluxo_maximo = 0;
    [retorno,pais] = BFS(grafo,origem,sorvedouro,pais);
    while retorno == 1
        caminho_fluxo = Inf;
        s = sorvedouro;
        while s ~= origem
            caminho_fluxo = min(caminho_fluxo,grafo(pais(s),s));
            s = pais(s);
        end
        fluxo_maximo = fluxo_maximo + caminho_fluxo;
        v = sorvedouro;
        while v ~= origem
            u = pais(v);
            grafo(u,v) = grafo(u,v) - caminho_fluxo;
            grafo(v,u) = grafo(v,u) + caminho_fluxo;
            v = pais(v);
        end
        [retorno,pais] = BFS(grafo,origem,sorvedouro,pais);
    end
    corte = [[]];
    cont = 1;
    for k = 1:linhas
        for l = 1:colunas
            if grafo(k,l) == 0 && grafo_original(k,l) > 0
                aresta = [k l];
                corte(cont,:) = aresta;
                cont = cont + 1;
            end
        end
    end
end