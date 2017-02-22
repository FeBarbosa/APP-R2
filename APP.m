## Copyright (C) 2016 Felipe Barbosa
##

## Author: Felipe Barbosa <Felipe Barbosa@FELIPE2>
## Created: 2016-08-06

## OBS1: Por hora lambda sera constante (lambda = 2)
## OBS2: Problema na linha 27 -> quando se usa x0 com alguma coordenada negativa ocorre erro

function f = APP(func_str)

    #DEFINIÇOES INICIAIS E ENTRADAS

    num_tests = 100;                # Nº MAXIMO DE TESTES
    tol = 1e-3;                     # CRITERIO DE PARADA (mod(xk-x) < tol)
    x0 = input('x0: ');             # SOLICITA A ENTRADA DE X0 (INICIAL) AO USUARIO
    xf = input('xf: ');             # MINIMO GLOBLA DA FUNCAO
    lambda_str = '@(x) 2';
    lambda = eval(lambda_str);      # CONVERTE func_str PARA UMA FUNCAO E A ARMAZENA EM func
    
    xk = x0;

    for it = 1:num_tests

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

      # ENCONTRAR O MÍNIMO DA FUNÇÃO GERADA
      [xk, fval] = fminunc(func, x0);

      # CONDICAO DE PARADA
      if(norm(xf - xk) <= tol)
        break;
      end

    end #FOR
    
    erro = norm(xf - xk);
  
    # mostrar resultados (mínimo aproximado, erro, quantidade de iterações e etc)
    fprintf('\n%.5f | %d | (%.5f, %.5f) | %.5f\n', tol, it, xk(1), xk(2), erro);
    
end # FUNCTION
