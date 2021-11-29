function c2 = cenario1(qtd_barras, sistema1, sistema2)

configurar = mpoption('pf.alg','NR','verbose',3);
resultados1 = runopf(sistema1,configurar);
clc
printpf_caso1(resultados1);
fprintf('\nPressione ENTER para continuar...\n');
sobrecarga = sobrecarga_2(resultados1,sistema2);
imprime_sobrecarga_2(sobrecarga);
if(length(sobrecarga) > 0)
    c2 = true;
else
    c2 = false;
end
fprintf('\nPressione ENTER para continuar...\n');
pause