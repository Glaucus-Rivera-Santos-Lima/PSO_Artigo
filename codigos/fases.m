function fases(qtd_barras)
clc
fprintf('Informe a fase desejada: \n');
fprintf('[1] Fase A: FPO em condição normal de rede\n');
fprintf('[2] Fase B: FPORS em condição de contingenciamento mais severo\n');
fprintf('[3] Fase C: FPORS em condição de contingenciamento de maior risco\n');
fprintf('[0] Voltar\n');
opcao = input('-> ');

while opcao ~= 0
    switch opcao
        case 1
            faseA(qtd_barras);
        case 2
            faseB(qtd_barras);
        case 3
            faseC(qtd_barras)
        otherwise
            clc
            fprintf('ERRO: Opção inválida!!!\n');
            fprintf('Pressione ENTER para continuar...\n')
            pause
    end 
    clc
    fprintf('Informe a fase desejada: \n');
    fprintf('[1] Fase A: FPO em condição normal de rede\n');
    fprintf('[2] Fase B: FPORS em condição de contingenciamento mais severo\n');
    fprintf('[3] Fase C: FPORS em condição de contingenciamento de maior risco\n');
    fprintf('[0] Voltar\n');
    opcao = input('-> ');
end
