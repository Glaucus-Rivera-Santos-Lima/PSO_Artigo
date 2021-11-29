function [retorno,pais] = BFS(grafo,s,t,pais)
    [linhas,colunas] = size(grafo);
    visitados = [];
    for k = 1:linhas
        visitados(k) = 0;
    end
    fila = [];
    fila(1) = s;
    visitados(s) = 1;
    while length(fila) ~= 0
        u = fila(1);
        fila(1) = [];
        for k = 1:colunas
            if visitados(k) == 0 && grafo(u,k) > 0
                fila(length(fila)+1) = k;
                visitados(k) = 1;
                pais(k) = u;
            end
        end
    end
    retorno = visitados(t);
end