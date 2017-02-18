## Copyright (C) 2016 Felipe Barbosa
##

## Author: Felipe Barbosa <Felipe Barbosa@FELIPE2>
## Created: 2016-08-06

## OBS1: Por hora lambda sera constante (lambda = 2)

function f = APP_1M(func_str, xf, lambda_str)

    #DEFINIÇOES INICIAIS E ENTRADAS

    num_tests = 100;                # Nº MAXIMO DE TESTES
    tol = 1e-5;                     # CRITERIO DE PARADA (mod(xk-x) < tol)
    lambda = eval(lambda_str);      # CONVERTE func_str PARA UMA FUNCAO E A ARMAZENA EM func
    xk_media = [0 0];
    it_media = 0;
    xk_melhor = [100000, 100000];
    xk_pior = xf;
    erro_medio = 0;
    
    tic();                          # Zera a contagem do tempo de processamento
    
    for i = 1:100
    
      x0 = -10 + (20)*rand(1,2);
      xk = x0;
      
      for it = 1:num_tests

        # GERAÇAO DA FUNC-K
          
        if(xk(1) >= 0 && xk(2) >=0)
          func_k = [func_str ' + ' num2str(lambda(it)) '*((x(1) -' num2str(xk(1)) ').^2 + (x(2) -' num2str(xk(2)) ').^2)'];
        elseif(xk(2) >= 0)
          func_k = [func_str ' + ' num2str(lambda(it)) '*((x(1) +' num2str(abs(xk(1))) ').^2 + (x(2) -' num2str(xk(2)) ').^2)'];
        elseif(xk(1) >= 0)
          func_k = [func_str ' + ' num2str(lambda(it)) '*((x(1) -' num2str(xk(1)) ').^2 + (x(2) +' num2str(abs(xk(2))) ').^2)'];
        else
          func_k = [func_str ' + ' num2str(lambda(it)) '*((x(1) +' num2str(abs(xk(1))) ').^2 + (x(2) +' num2str(abs(xk(2))) ').^2)'];
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
      
%      fprintf('(%.5f, %.5f) | %.8f\n', xk(1), xk(2), norm(xk - xf));
      
      #MELHOR CASO
      if(norm(xk - xf) < norm(xk_melhor - xf))
        xk_melhor = xk;
      endif
      
      #PIOR CASO
      if(norm(xk - xf) > norm(xk_pior - xf))
        xk_pior = xk;
      endif
      
      
      erro_medio += norm(xk - xf);
      it_media += it;
      xk_media += xk;
  
    endfor
    
    xk_media /= 100;
    it_media /= 100;

    erro_medio /= 100;
    erro_melhor = norm(xk_melhor - xf);
    erro_pior = norm(xk_pior - xf);
    
    
    tempo_medio = toc()/100; # Retorna o tempo de processamento a partir da execuçao da funcao tic();

    # mostrar resultados (mínimo aproximado, erro, quantidade de iterações e etc)
    fprintf('Tol | it_media | t_medio | lambda | xk_media | erro_medio | erro_melhor | erro_pior');
    fprintf('\n%.5f | %d | %.5f | %s |(%.5f, %.5f) | %.8f | %.8f | %.8f \n', tol, it_media, tempo_medio, lambda_str, xk_media(1), xk_media(2), erro_medio, erro_melhor, erro_pior);
%    fprintf('\n%.5f | %d | %.5f | %s |(%.5f, %.5f) | (%.5f, %.5f) | (%.5f, %.5f) \n', tol, it_media, tempo_medio, lambda_str, xk_media(1), xk_media(2), xk_melhor(1), xk_melhor(2), xk_pior(1), xk_pior(2));
    
    
endfunction # FUNCTION
