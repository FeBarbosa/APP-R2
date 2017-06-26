%
%'100*sqrt(abs(x(2) - 0.01*x(1)^2)) + 0.01*abs(x(1) + 10)', # [-10 , 1] BUKIN FUNCTION N. 6
%         '(1 + cos(12*sqrt(x(1)^2+x(2)^2)))/(0.5*(x(1)^2+x(2)^2) + 2)', # [0,0] DROP-WAVE FUNCTION
%         '-(x(2)+47) * sin(sqrt(abs(x(2)+x(1)/2+47)))  - x(1) * sin(sqrt(abs(x(1)-(x(2)+47))))', # [512, 404.2319] EGGHOLDER FUNCTION
%         '(sin(3*pi*x(1)))^2 + (x(1)-1)^2 * (1+(sin(3*pi*x(2)))^2) + (x(2)-1)^2 * (1+(sin(2*pi*x(2)))^2)'[1, 1] LEVY FUNCTION N. 13
%     '(x(2) - 0.01*x(1)^2)^2 + (x(1) + 10)^2' # BUKIN FUNCTION N. 6 adaptada


# Script para automatizacao da geracao das tabelas para funcs de 1 minimo


#OBS1: Verificar como escrever em arquivo txt
#OBS2: Verificar como chamar funcoes dentro de funcoes


function f = testes_MM()

func  = ['(x(1) - 1)^2 + (x(2) - 1)^2'; # [1, 1]
         '(x(1) - 1)^2 + x(2)^2';  # [1, 0]
         '(x(2) - 0.01*x(1)^2)^2 + (x(1) + 10)^2']; # [-10, 1]


xf = [[1,1];
      [1,0];
      [-10,1]];

lambda = ['1';
          '2';
          '1 + 1/k';
          '1/k';
          '2 - 1/k';
          '4 + (-1)^k'];

   func = cellstr(func);
   lambda = cellstr(lambda);



%   for i = 1:2 # FUNCOES ######################################################

      %fprintf('Nº | Tol | it_media | t_medio | lambda | xk_media | erro_medio | erro_melhor | erro_pior\n');

      contador = 1;

      fprintf("\\hline");
      %fprintf("%s\n", char(func(2,1)));

      for j = 1:6 # LAMBDA ###################################################
         
         APP_MM(test_num, func_str, x0,xf, lambda_str, tol)
         
         APP_1M(contador, "(x(1) - 1)^2 * (x(1) - 6)^2 + (x(2) - 10)^2 + 10", [1, 10], lambda(j, 1), 1e-3);
         APP_1M(++contador, func(1, 1), [1, 0], lambda(j, 1), 1e-4);
         APP_1M(++contador, func(1, 1), [1, 0], lambda(j, 1), 1e-5);

         contador++;

      endfor

      fprintf("\n\n");

%   endfor

endfunction
