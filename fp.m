function [valor_FO_STEE, avalia_descongestionamento] = fp(sistema, linha, L)

%% Alterando os parâmetros X e B, respectivamente, da linha de alocação
sistema.branch(linha,4) = sistema.branch(linha,4) *(1 - L);
sistema.branch(linha,5) = sistema.branch(linha,4)/(sistema.branch(linha,4)^2 + sistema.branch(linha,3)^2)/sistema.baseMVA;


%% Apresentando na tela o STEE com devidas modificações em X e B da matrix branch
%sistema.branch


%% Configurando o MATPOWER
configurar = mpoption('pf.alg','NR','verbose',3);


%% Rodando o FPO
resultados = runopf(sistema, configurar);


%% Avaliando descongestionamento
sobrecarga = sobrecarga_2(resultados, sistema);             %vetor que contém quantidade de linhas sobrecarregadas
avalia_descongestionamento = length(sobrecarga);            %pegando quantidade de linhas congestionadas (0 para STEE descongestionado)
valor_FO_STEE = resultados.f;                              %acessando o valor da função objetivo (.f)








