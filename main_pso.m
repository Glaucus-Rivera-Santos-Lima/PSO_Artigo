%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               Universidade Federal de Ouro Preto - UFOP               %%
%%                  Instituto de Ciências Exatas - ICEA                  %%
%%                                                                       %%
%%                             ARTIGO - PSO                              %%
%%                                                                       %%
%% Autor:        Glaucus Rivera Santos Lima                              %%
%% Orientador:   Dr. Carlos Henrique Nogueira de Resende Barbosa         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear all


tic
%% Adicionando pastas
addpath('mathpower');
addpath('sistemas');
addpath('codigos');


%% Chamando a função PSO
result = func_pso(sistema6_caso2corretoA, sistema6_caso2corretoB, sistema6_caso2corretoC);
% result = func_pso(sistema30_caso2corretoA, sistema30_caso2corretoB, sistema30_caso2corretoC);
% result = func_pso(sistema118_caso2corretoA, sistema118_caso2corretoB, sistema118_caso2corretoC);
% result = func_pso(sistema300_caso2corretoA, sistema300_caso2corretoB, sistema300_caso2corretoC);


%% Apresentando os resultados
fprintf('\n=============== RESULTADO =================\n');
fprintf('[Linha]    [L1]        [L2]        [L3]\n');
disp(result)
toc
fprintf('===========================================\n');    





