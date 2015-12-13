% busca los mejores resultados de todas las mediciones realizadas por la optimización
% de parámetros
function [bestAccuracy, bestGamma, bestC] = obtenerMejoresParametros(accuracies, gammaParameters, cParameters)

  bestAccuracy = [0 0 0];
  bestC        = 0;
  bestGamma    = 0;
  
  [max_values index] = max(accuracies(1, :));
  bestAccuracy = accuracies(:, index);
  bestGamma    = gammaParameters(index);
  bestC        = cParameters(index);
  
  printf("Mejor precision posible: %d \n", bestAccuracy(1));
  printf("Mejor valor gamma: %d \n", bestGamma);
  printf("Mejor valor C: %d \n", bestC);
  fflush(stdout);
end