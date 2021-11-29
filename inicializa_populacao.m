function populacao = inicializa_populacao(tamanho, x_min, x_max, sistema_a, sistema_b, sistema_c)
mantem_linha = 0;
cont_mantem_linha = 0;
mantem_linha_1 = 0;
for i=1:tamanho
    stop = 0;
    while stop == 0
        if mantem_linha == 0 || cont_mantem_linha >= tamanho
            linha = round((x_max - x_min)*rand() + x_min);         %inicia posi��o randomicamente dentro da janela (1 at� total_de_linhas)
            cont_mantem_linha = 0;
            mantem_linha_1 = 0;
            mantem_linha = 0;
        elseif mantem_linha_1 == 0
            cont_mantem_linha = cont_mantem_linha + 1;
        elseif mantem_linha_1 == 1
            cont_mantem_linha = cont_mantem_linha + round(tamanho/5);
        end
        %format bank
        valor_L_a = 0.2 + (0.7 - 0.2)*rand();                    %L de forma rand�mica (entre 0.2 e 0.7)
        valor_L_b = 0.2 + (0.7 - 0.2)*rand();
        valor_L_c = 0.2 + (0.7 - 0.2)*rand();
        local = {linha,valor_L_a, valor_L_b, valor_L_c};                               %c�lula com posi��o e valor_L
        velocidade(1) = linha*0.1;                             %inicia velocidade da vari�vel linha randomicamente sendo 1/10 da posi��o inicial
        velocidade(2) = valor_L_a*0.1;                           %inicia velocidade da vari�vel L
        velocidade(3) = valor_L_b*0.1;
        velocidade(4) = valor_L_c*0.1;
        [objetivo,congestionamento_a, congestionamento_b, congestionamento_c] = funcao_objetivo(sistema_a, sistema_b, sistema_c, local);            %fun��o objetivo/fitnes + avalia��o do descongestionamento
        
        %Limitando resposta do fitness que descongestione o sistema
        if congestionamento_a == 0 && congestionamento_b == 0 && congestionamento_c == 0
            stop = 1;
            mantem_linha = 1;
            mantem_linha_1 = 1;
            cont_mantem_linha = 0;
        elseif congestionamento_a == 0 || congestionamento_b == 0 || congestionamento_c == 0
            mantem_linha = 1;
        end
    end
    
    %Montando a c�lula com dados iniciais de todas as part�culas
    populacao{i,1} = local;                 %posi��o da part�cula
    populacao{i,2} = objetivo;              %fitness
    populacao{i,3} = velocidade;            %velocidade da part�cula
    populacao{i,4} = local;                 %melhor posi��o inicial, Pbest
end

