function [valor_FO_STEE, avalia_descongestionamento_a, avalia_descongestionamento_b, avalia_descongestionamento_c] = funcao_objetivo(sistema_a, sistema_b, sistema_c, posicao)

%% Pegando os dados
linha = posicao{1};                         %linha é um vetor de duas posições: [linha_de  linha_para]
L_a = posicao{2};                             %valor de compensação
L_b = posicao{3};
L_c = posicao{4};


%% Alterando os parâmetros X e B, respectivamente, da linha de alocação
sistema_a.branch(linha,4) = sistema_a.branch(linha,4) *(1 - L_a);
sistema_a.branch(linha,5) = sistema_a.branch(linha,4)/(sistema_a.branch(linha,4)^2 + sistema_a.branch(linha,3)^2)/sistema_a.baseMVA;

sistema_b.branch(linha,4) = sistema_b.branch(linha,4) *(1 - L_b);
sistema_b.branch(linha,5) = sistema_b.branch(linha,4)/(sistema_b.branch(linha,4)^2 + sistema_b.branch(linha,3)^2)/sistema_b.baseMVA;

sistema_c.branch(linha,4) = sistema_c.branch(linha,4) *(1 - L_c);
sistema_c.branch(linha,5) = sistema_c.branch(linha,4)/(sistema_c.branch(linha,4)^2 + sistema_c.branch(linha,3)^2)/sistema_c.baseMVA;



%% Apresentando na tela o STEE com devidas modificações em X e B da matrix branch
%sistema.branch


%% Configurando o MATPOWER
configurar = mpoption('pf.alg','NR','verbose',3);


%% Rodando o FPO
resultados_a = runopf(sistema_a, configurar);
resultados_b = runopf(sistema_b, configurar);
resultados_c = runopf(sistema_c, configurar);


%% Avaliando descongestionamento
sobrecarga_a = sobrecarga_2(resultados_a, sistema_a);             %vetor que contém quantidade de linhas sobrecarregadas
sobrecarga_b = sobrecarga_2(resultados_b, sistema_b);
sobrecarga_c = sobrecarga_2(resultados_c, sistema_c);
avalia_descongestionamento_a = length(sobrecarga_a);            %pegando quantidade de linhas congestionadas (0 para STEE descongestionado)
avalia_descongestionamento_b = length(sobrecarga_b);
avalia_descongestionamento_c = length(sobrecarga_c);
valor_FO_STEE = resultados_a.f + resultados_b.f + resultados_c.f;                              %acessando o valor da função objetivo (.f)








