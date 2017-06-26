## Copyright (C) 2016 Felipe Barbosa
##

## Author: Felipe Barbosa <Felipe Barbosa@FELIPE2>
## Created: 2016-08-06

## OBS1: Por hora lambda sera constante (lambda = 2)

function f = APP_MM(test_num, func_str, x0,xf, lambda_str, tol)

    func_str = char(func_str);
    lambda_str1 = char(lambda_str);

    if(tol == 1e-3)
      tol_srt = "$10\^{-3}$";
    elseif(tol == 1e-4)
      tol_srt = "$10\^{-4}$";
    else
      tol_srt = "$10\^{-5}$";
    endif


    func_str = ['@(x)' func_str];
    lambda_str = ['@(k)' lambda_str1];

    #DEFINIÇOES INICIAIS E ENTRADAS

    num_tests = 100;                # Nº MAXIMO DE TESTES
    #tol = 1e-5;                     # CRITERIO DE PARADA (mod(xk-x) < tol)
    lambda = eval(lambda_str);      # CONVERTE func_str PARA UMA FUNCAO E A ARMAZENA EM func
    num_it = 0;
    erro = 0;

    tic();                          # Zera a contagem do tempo de processamento

      xk = x0;

      for it = 1:num_tests

        num_it++;
      
        # GERAÇAO DA FUNC-K
        if(xk(1) >= 0 && xk(2) >=0)
          func_k = [func_str ' + ' num2str(lambda(it)) '/2 *((x(1) -' num2str(xk(1)) ').^2 + (x(2) -' num2str(xk(2)) ').^2)'];
        elseif(xk(2) >= 0)
          func_k = [func_str ' + ' num2str(lambda(it)) '/2 *((x(1) +' num2str(abs(xk(1))) ').^2 + (x(2) -' num2str(xk(2)) ').^2)'];
        elseif(xk(1) >= 0)
          func_k = [func_str ' + ' num2str(lambda(it)) '/2 *((x(1) -' num2str(xk(1)) ').^2 + (x(2) +' num2str(abs(xk(2))) ').^2)'];
        else
          func_k = [func_str ' + ' num2str(lambda(it)) '/2 *((x(1) +' num2str(abs(xk(1))) ').^2 + (x(2) +' num2str(abs(xk(2))) ').^2)'];
        endif

%      func_k = [func_str ' + ' num2str(lambda(it)) '*((x(1) -' num2str(xk(1)) ').^2 + (x(2) -' num2str(xk(2)) ').^2)'];

        func = eval(func_k);

        xAnt = xk;

        # ENCONTRAR O MÍNIMO DA FUNÇÃO GERADA
        [xk, fval] = fminunc(func, x0);


        # CONDICAO DE PARADA
        if(norm(xAnt - xk) <= tol)
          break;
        endif

      endfor #FOR

    tempo = toc(); # Retorna o tempo de processamento a partir da execuçao da funcao tic();

    # mostrar resultados (mínimo aproximado, erro, quantidade de iterações e etc)


%    xlswrite('/home/PIBIC/resultados/') #escrever direto em um arquivo xls

    fprintf('\n%2.d & %s & %3.d & %3.6f & %s & (%.8f, %.8f) & %.6f & \\\\ \n \\hline', test_num, tol_srt, num_it, tempo, lambda_str1, xk(1), xk(2), erro);
%    fprintf('\n%.5f | %d | %.5f | %s |(%.5f, %.5f) | (%.5f, %.5f) | (%.5f, %.5f) \n', tol, it_media, tempo_medio, lambda_str, xk_media(1), xk_media(2), xk_melhor(1), xk_melhor(2), xk_pior(1), xk_pior(2));


endfunction # FUNCTION
