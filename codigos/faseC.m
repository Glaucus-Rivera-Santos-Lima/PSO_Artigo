%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ciências Exatas - ICEA                   %
%                                                                         %        
%                             Funcao: 'cenarios'                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function faseC(qtd_barras)
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
end

configurar = mpoption('pf.alg','NR','verbose',3);
resultados = runopf(sistema2,configurar);
sobrecar = sobrecarga_2(resultados,sistema2);
maior_risco = contingencia_maior_risco(sistema2,sistema2);
qtd_linhas_sistema = size(sistema2.branch);
tam_pi = size(maior_risco);
tam_sobrecar = size(sobrecar);
indice_pi = 1;
sair = 0;
linha_removida = [];

for m = 1:tam_pi
    sair = 1;
    for n = 1:tam_sobrecar
        if maior_risco(m,1) == sobrecar(n,1) && maior_risco(m,2) == sobrecar(n,2)
            sair = 0;
            indice_pi = indice_pi+1;
            break
        end
    end
    if sair == 1
        break
    end
end
sair = 0;
while sair ~= 1
    for m = 1:qtd_linhas_sistema
        if sistema2.branch(m,1) == maior_risco(indice_pi,1) && sistema2.branch(m,2) == maior_risco(indice_pi,2)
            sistema2.branch(m,11) = 0;
            sistema1.branch(m,11) = 0;
            linha_removida(1) = sistema2.branch(m,1);
            linha_removida(2) = sistema2.branch(m,2);
        end
    end    
    
    configurar = mpoption('pf.alg','NR','verbose',3);
    resultados = runopf(sistema2,configurar);
    sobrecar = sobrecarga_2(resultados,sistema2);
    tam_sobrecar = size(sobrecar);
    
    if resultados.success == 0 || tam_sobrecar(1) == 0
        for m = 1:qtd_linhas_sistema
            if sistema2.branch(m,1) == maior_risco(indice_pi,1) && sistema2.branch(m,2) == maior_risco(indice_pi,2)
                sistema2.branch(m,11) = 1;
                sistema1.branch(m,11) = 1;
            elseif sistema2.branch(m,1) == maior_risco(indice_pi+1,1) && sistema2.branch(m,2) == maior_risco(indice_pi+1,2)
                sistema2.branch(m,11) = 0;
                sistema1.branch(m,11) = 0;
                linha_removida(1) = sistema2.branch(m,1);
                linha_removida(2) = sistema2.branch(m,2);
            end
        end
        indice_pi = indice_pi + 1;
    else
        sair = 1;
    end
end

clc
fprintf('Linha removida: %d - %d\n', linha_removida(1), linha_removida(2));
fprintf('Pressione ENTER para continuar...\n')
pause

clc
fprintf('CENÁRIO 1C\n');
fprintf('Determinar solução do FPORS para o Cenário 1C?\n')
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
                fprintf('CENÁRIO 2C\n')
                fprintf('Tentar descongestionar o STEE através do redespacho da geração e determinar uma solução para o FPORS?\n');
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
                                fprintf('CENÁRIO 3C\n');
                                fprintf('O redespacho da geração não foi suficiente para descongestionar o sistema.\n')
                                fprintf('Tentar alocar TCSC e determinar uma solução para o FPORS?\n');
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
                                        fprintf('CENÁRIO 3C\n');
                                        fprintf('O redespacho da geração não foi suficiente para descongestionar o sistema.\n')
                                        fprintf('Tentar alocar TCSC e determinar uma solução para o FPORS?\n');
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
                        fprintf('CENÁRIO 2C\n')
                        fprintf('Tentar descongestionar o STEE através do redespacho da geração e determinar uma solução para o FPORS?\n');
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
        fprintf('CENÁRIO 1C\n');
        fprintf('Determinar solução do FPORS para o Cenário 1C?\n')
        fprintf('[1] Sim\n');
        fprintf('[2] Não\n');
        fprintf('[0] Voltar\n');
        opcao = input('-> ');
    end
end