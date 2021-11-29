function [valor_FO_STEE, avalia_descongestionamento] = fp(sistema, linha, L)

%% Alterando os par�metros X e B, respectivamente, da linha de aloca��o
sistema.branch(linha,4) = sistema.branch(linha,4) *(1 - L);
sistema.branch(linha,5) = sistema.branch(linha,4)/(sistema.branch(linha,4)^2 + sistema.branch(linha,3)^2)/sistema.baseMVA;


%% Apresentando na tela o STEE com devidas modifica��es em X e B da matrix branch
%sistema.branch


%% Configurando o MATPOWER
configurar = mpoption('pf.alg','NR','verbose',3);


%% Rodando o FPO
resultados = runopf(sistema, configurar);


%% Avaliando descongestionamento
sobrecarga = sobrecarga_2(resultados, sistema);             %vetor que cont�m quantidade de linhas sobrecarregadas
avalia_descongestionamento = length(sobrecarga);            %pegando quantidade de linhas congestionadas (0 para STEE descongestionado)
valor_FO_STEE = resultados.f;                              %acessando o valor da fun��o objetivo (.f)








