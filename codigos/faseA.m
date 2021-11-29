%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                             Funcao: 'cenarios'                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function faseA(qtd_barras)
if qtd_barras == 6
    sistema1 = sistema6_caso1correto;
    sistema2 = sistema6_caso2correto;
elseif qtd_barras == 14
    sistema1 = sistema14_caso1correto;
    sistema2 = sistema14_caso2correto;
elseif qtd_barras == 30
    sistema1 = sistema30_caso1correto;
    sistema2 = sistema30_caso2correto;
elseif qtd_barras == 118
    sistema1 = sistema118_caso1correto;
    sistema2 = sistema118_caso2correto;
elseif qtd_barras == 300
    sistema1 = sistema300_caso1correto;
    sistema2 = sistema300_caso2correto;
end

clc
fprintf('CENÁRIO 1A\n');
fprintf('Determinar solução do FPO para o Cenário 1A?\n')
fprintf('[1] Sim\n');
fprintf('[2] Não\n');
fprintf('[0] Voltar\n');
opcao = input('-> ');
while opcao ~= 0
    switch opcao
        case 1
            c2 = cenario1(qtd_barras, sistema1, sistema2);
            if c2 == 1
                clc
                fprintf('CENÁRIO 2A\n')
                fprintf('Tentar descongestionar o STEE através do redespacho da geração e determinar uma solução para o FPO?\n');
                fprintf('[1] Sim\n');
                fprintf('[2] Não\n');
                fprintf('[0] Voltar\n');
                opcao2 = input('-> ');
                while(opcao2 ~= 0 && opcao2 ~= 2)
                    switch opcao2
                        case 1
                            c3 = cenario2(qtd_barras, sistema1, sistema2);
                            if(c3 == 1)
                                clc
                                fprintf('CENÁRIO 3A\n');
                                fprintf('O redespacho da geração não foi suficiente para descongestionar o sistema.\n')
                                fprintf('Tentar alocar TCSC e determinar uma solução para o FPO?\n');
                                fprintf('[1] Sim\n');
                                fprintf('[2] Não\n');
                                fprintf('[0] Voltar\n');
                                opcao3 = input('-> ');
                                while(opcao3 ~= 0 && opcao3 ~= 3)
                                    switch opcao3
                                        case 1
                                            cenario3(qtd_barras, sistema1, sistema2);
                                            opcao3 = 0;
                                        case 2
                                            opcao3 = 0;
                                        case 3
                                            opcao3 = 0;
                                        otherwise
                                            fprintf('ERRO: Opção inválida!!!\n');
                                            fprintf('Pressione ENTER para continuar...\n');
                                            pause;
                                            
                                    end
                                    if(opcao3 ~= 0)
                                        clc
                                        fprintf('CENÁRIO 3A\n');
                                        fprintf('O redespacho da geração não foi suficiente para descongestionar o sistema.\n')
                                        fprintf('Tentar alocar TCSC e determinar uma solução para o FPO?\n');
                                        fprintf('[1] Sim\n');
                                        fprintf('[2] Não\n');
                                        fprintf('[0] Voltar\n');
                                        opcao3 = input('-> ');
                                    end
                                end
                            end
                            opcao2 = 0;
                        case 2
                            opcao2 = 0;
                        case 0
                            opcao2 = 0;
                        otherwise
                            fprintf('ERRO: Opção inválida!!!\n');
                            fprintf('Pressione ENTER para continuar...\n');
                            pause;
                    end
                    if(opcao2 ~= 0)
                        clc
                        fprintf('CENÁRIO 2A\n')
                        fprintf('Tentar descongestionar o STEE através do redespacho da geração e determinar uma solução para o FPO?\n');
                        fprintf('[1] Sim\n');
                        fprintf('[2] Não\n');
                        fprintf('[0] Voltar\n');
                        opcao2 = input('-> ');
                    end
                end
            end
            opcao = 0;
        case 2
            opcao = 0;
        otherwise
            fprintf('ERRO: Opção inválida!!!\n');
            fprintf('Pressione ENTER para continuar...\n');
            pause;
    end
    if(opcao ~= 0)
        clc
        fprintf('CENÁRIO 1A\n');
        fprintf('Determinar solução do FPO para o Cenário 1A?\n')
        fprintf('[1] Sim\n');
        fprintf('[2] Não\n');
        fprintf('[0] Voltar\n');
        opcao = input('-> ');
    end
end