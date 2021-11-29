%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Universidade Federal de Ouro Preto - UFOP                %     
%                   Instituto de Ci�ncias Exatas - ICEA                   %
%                                                                         %        
%                                 PSO                                     %
%                                                                         %
%  Aloca��o �tima de TCSC em Linhas de Transmiss�o para Garantir o Fluxo  %
%      de Pot�ncia �timo com Restri��o de Seguran�a em Condi��o de        %
%                         Congestionamento de Rede                        %
%                                                                         %
% Autor:      Glaucus Rivera Santos Lima                                  %
% Orientador: Dr. Carlos Henrique Nogueira de Rezende Barbosa             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

clc
warning off;

addpath('codigos');
addpath('mathpower');
addpath('sistemas');

fprintf('Informe o STEE a ser simulado:\n[1] 6 Barras\n[2] 30 Barras\n[3] 118 Barras \n[4] 300 Barras\n[0] Sair\n');
opcao = input('-> ');

while opcao ~= 0
    switch opcao
        case 1
            clear all
            fases(6);
        case 2
            clear all
            fases(30);
        case 3
            clear all
            fases(118);
        case 4
            clear all
            fases(300);
        otherwise
            clc
            fprintf('ERRO: Op��o inv�lida!!!\n');
            fprintf('Pressione ENTER para continuar...\n')
            pause
    end 
    
    clc
    
fprintf('Informe o STEE a ser simulado:\n[1] 6 Barras\n[2] 30 Barras\n[3] 118 Barras \n[4] 300 Barras\n[0] Sair\n');
    opcao = input('-> ');
    
end

