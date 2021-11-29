function [Gbest] = func_pso(sistema_a, sistema_b, sistema_c)

%% INICIANDO ALGORITMO DO PSO - OTIMIZA��O POR NUVEM DE PART�CULAS
%% Inicializando par�metros
c1 = 2.05;                  %fator de sensibilidade individual
c2 = 2.05;                  %fator de sensibilidade comunit�ria
p = 1;                    %tamanho da popula��o
num_iteracoes = 10;        %n�mero de itera��es
w_max = 0.9;                %in�rcia m�xima
w_min = 0.4;                %in�rcia m�nima


%% Janelamento
sist = size(sistema_a.branch);
qtd_linhas = sist(1);           %pegando a quantidade de linhas da matriz branch
x_min = 1;
x_max = qtd_linhas;


%% Inicializando X (posi��o) e V (velocidade) randomicamente
populacao = inicializa_populacao(p,x_min,x_max,sistema_a, sistema_b, sistema_c);       %� uma matriz de 4 colunas [posicaoinicial fitness velocidade Pbest_da_part�cula]
populacao = sortrows(populacao,2);                                                     %ordenando a popula��o na matriz do menor ao maior fitness para achar Gbest

clc
fprintf('Gerou populacao')
%pause

%% Inicializando Pbest
Pbest = populacao(:,4);          %melhor posi��o individual das part�culas


%% Inicializando Gbest
Gbest = populacao{1,1};          %melhor posi��o global


%% Iniciando processo de itera��o do PSO
cont_iteracao = 1;              %contador de itera��o
cont_piora = 1;                 %contador de piora das respostas
limite = 0.30*num_iteracoes;    %limite para a piora das respostas = 30% do n�mero m�ximo de itera��es
%vetor(1,1) = cont_iteracao;

while cont_iteracao <= num_iteracoes && cont_piora <= limite
    %Atualizando a posi��o da part�cula a cada itera��o
    for i=1:p
        posicao = populacao{i,1};
        linha = posicao{1};
        grau_a = posicao{2};
        grau_b = posicao{3};
        grau_c = posicao{4};
        
        %Atualizando posi��o
        velocidade = populacao{i,3};                            %velocidade � a 3� coluna da matriz populacao
        linha = round(linha + velocidade(1));                   %posi��o da linha � atualizada via velocidade(1)
        grau_a = grau_a + velocidade(2);                        %posi��o de L � atualizada via velocidade(2)
        grau_b = grau_b + velocidade(3);
        grau_c = grau_c + velocidade(4);
        
        %Controle do limite da linha
        if linha > qtd_linhas
            linha = qtd_linhas;
        elseif linha < 1
            linha = 1;
        end
        
        %Controle do limite do fator de compensa��o para os tr�s cen�rios analisados
        if grau_a > 0.7
            grau_a = 0.7;
        elseif grau_a < 0.2
            grau_a = 0.2;
        end
        
        if grau_b > 0.7
            grau_b = 0.7;
        elseif grau_b < 0.2
            grau_b = 0.2;
        end
        
        if grau_c > 0.7
            grau_c = 0.7;
        elseif grau_c < 0.2
            grau_c = 0.2;
        end
        
        %Atualiza��o da popula��o que � capaz de descongestionar o sistema
        posicao{1} = linha;
        posicao{2} = grau_a;
        posicao{3} = grau_b;
        posicao{4} = grau_c;
        [objetivo, congestionamento_a, congestionamento_b, congestionamento_c] = funcao_objetivo(sistema_a, sistema_b, sistema_c, posicao);
        
        %Verificando se a nova part�cula � capaz de descongestionar o STEE
        if congestionamento_a == 0 && congestionamento_b == 0 && congestionamento_c == 0
            populacao{i,1} = posicao;
            populacao{i,2} = objetivo;
        end
    end
    
    %Atualiza��o do Pbest
    [objetivo, congestionamento_a, congestionamento_b, congestionamento_c] = funcao_objetivo(sistema_a, sistema_b, sistema_c, posicao);
    
    if populacao{i,2} < objetivo
        populacao{i,4} = populacao{i,1};
    end
    
    %Atualizando Gbest
    populacao = sortrows(populacao,2);                              %ordenando a popula��o novamente para pegar o Gbest
    [objetivo, congestionamento_a, congestionamento_b, congestionamento_c] = funcao_objetivo(sistema_a, sistema_b, sistema_c, Gbest);
    
    if populacao{1,2} < objetivo
        Gbest = populacao{1,1};                                     %melhor posi��o global atualizada
        cont_piora = 0;
    else
        cont_piora = cont_piora + 1;                                %analiso piora da resposta
    end
    
    %Atualizando a velocidade
    w = w_max-(w_max-w_min)*cont_iteracao/num_iteracoes;            %atualiza��o do peso inercial de forma decrescente
    
    for i=1:p
        velocidade = populacao{i,3};
        posicao = populacao{i,1};
        Pbest = populacao{i,4};
        
        %Velocidades a serem atualizadas: a que se relaciona � linha e as que se relacionam ao fator L
        velocidade(1) = w*velocidade(1) + c1*rand()*(Pbest{1} - posicao{1}) + c2*rand()*(Gbest{1} - posicao{1});       %Linha
        velocidade(2) = w*velocidade(2) + c1*rand()*(Pbest{2} - posicao{2}) + c2*rand()*(Gbest{2} - posicao{2});       %L1
        velocidade(3) = w*velocidade(3) + c1*rand()*(Pbest{3} - posicao{3}) + c2*rand()*(Gbest{3} - posicao{3});       %L2
        velocidade(4) = w*velocidade(4) + c1*rand()*(Pbest{4} - posicao{4}) + c2*rand()*(Gbest{4} - posicao{4});       %L3
        populacao{i,3} = velocidade;                 %atualiza��o das duas velocidades
    end
    
    %Incremento do contador de itera��o
    cont_iteracao = cont_iteracao + 1;
end

end