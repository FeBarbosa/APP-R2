# Script para automatizacao da geracao das tabelas para funcs de 1 minimo

func  = ['@(x) (x(1) - 1)^2 + (x(2) - 1)^2', # [1, 1]
         '@(x) (x(1) - 1)^2 + x(2)^2',      # [1, 0] 
         '@(x) 100*sqrt(abs(x(2) - 0.01*x(1)^2)) + 0.01*abs(x(1) + 10)', # [-10 , 1] BUKIN FUNCTION N. 6
         '@(x) (1 + cos(12*sqrt(x(1)^2+x(2)^2)))/(0.5*(x(1)^2+x(2)^2) + 2)', # [0,0] DROP-WAVE FUNCTION
         '@(x) -(x(2)+47) * sin(sqrt(abs(x(2)+x(1)/2+47)))  - x(1) * sin(sqrt(abs(x(1)-(x(2)+47))))', # [512, 404.2319] EGGHOLDER FUNCTION
         '@(x) (sin(3*pi*x(1)))^2 + (x(1)-1)^2 * (1+(sin(3*pi*x(2)))^2) + (x(2)-1)^2 * (1+(sin(2*pi*x(2)))^2)' ]; # [1, 1] LEVY FUNCTION N. 13

        
xf = [[1,1], 
      [1,0], 
      [-10,1],
      [0,0], 
      [512,404.2319], 
      [1,1]];

lambda = ['@(k) 1', 
          '@(k) 2', 
          '@(k) 1 + 1/k',
          '@(k) 1/k', 
          '@(k) 2 - 1/k', 
          '@(k) 4 (-1)^k'];
          

