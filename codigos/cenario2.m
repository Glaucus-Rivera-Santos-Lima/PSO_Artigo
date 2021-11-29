function c3 = cenario2(qtd_barras, sistema1, sistema2)

configurar = mpoption('pf.alg','NR','verbose',3);
resultados = runopf(sistema2,configurar);
clc
printpf_caso2(resultados);
sobrecar = sobrecarga_2(resultados,sistema2);
imprime_sobrecarga(sobrecar);
if (length(sobrecar) > 0)
    c3 = 1;
else
    c3 = 0;
end
fprintf('\nPressione ENTER para continuar...\n');
pause