function cenario3(qtd_barras, sistema1, sistema2)

configurar = mpoption('pf.alg','NR','verbose',3);
resultados2 = runopf(sistema2,configurar);
clc
% printpf_caso1(resultados2);
sobrecar = sobrecarga_2(resultados2,sistema2);
% imprime_sobrecarga_2(sobrecar);
% fprintf('\nPressione ENTER para continuar...\n');
% pause
% clc
[corte,t,s] = corte_minimo(sistema2);
clc
imprime_corte(corte);
fprintf('\nPressione ENTER para continuar...\n');
pause
gargalos = verifica_gargalos(corte,sobrecar,t,s);
tam_gargalos = size(gargalos);

if tam_gargalos(1) == 0
    clc
    fprintf('\nO corte minimo nao pode ser aplicado para este caso!!!')
    fprintf('\nTodas as linhas vizinhas aos gargalos serao analisadas!!!')
    fprintf('\nPressione ENTER para continuar...\n');
    pause
    gargalos = linhas_vizinhas_gargalo(sobrecar,sistema1);
end

[garg,valor,taxa,taxa_otima,result_otimo,garg_otimo,sistema_otimo] = otimo(sistema2,gargalos,configurar,sistema2);
resultados = runopf(sistema_otimo,configurar);
imprime_result(garg,valor,taxa,garg_otimo);
fprintf('\nPressione ENTER para continuar...\n');
pause
clc
printpf_caso2(resultados);
sobrecar = sobrecarga_2(resultados,sistema2);
imprime_sobrecarga_2(sobrecar);
fprintf('\nPressione ENTER para continuar...\n');
pause