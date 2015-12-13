% realiza la optimización de los parámetros C y Gamma por medio de ciclos
% anidados. Para cada ietración entrena una modelo de MSV y mide su precisión
% por medio del conjunto de datos de validación cruzada. Devuelve todos los resultados
% del análisis
function [accuracies, gammaParameters, cParameters] = optimizarParametros(gammaParameter, cParameter, trainData, testData, kernelName, kernelPar)

  printf(cstrcat("Optimizacion de parametros para ",kernelName,"\n"));

  printf("Se probaran los valores para gamma: ");
  printf("%d ", gammaParameter);
  printf("\n");
  printf("Se probaran los valores para C: ");
  printf("%d ", cParameter);
  printf("\n");
  fflush(stdout);
  
  gammaSize = size(gammaParameter, 2);
  cParSize  = size(cParameter, 2);

  accuracies      = zeros(3, gammaSize*cParSize);
  gammaParameters = zeros(1, gammaSize);
  cParameters     = zeros(1, cParSize);

  cont = 1;
  for i = 1:gammaSize
    for j = 1:cParSize
      
      C = cParameter(j);
      g = gammaParameter(i);
      
      printf("Gamma = %d C = %d\n", g, C);
      fflush(stdout);
      
      svmParam = cstrcat('-s 0 ', kernelPar, ' -c ', num2str(C), ' -g ', num2str(g), ' -h 0 -q');
      model = svmtrain(trainData.y, trainData.X, svmParam);

      [predicted_label, accuracy, decision_values] = svmpredict(testData.y, testData.X, model, '-q');
      
      accuracies(:, cont) = accuracy;
      gammaParameters(cont) = g;
      cParameters(cont) = C;
      cont = cont+1;
      
      endfor
  endfor

end