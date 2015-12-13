% muestra en una figura los resultados de las precisiones
function[] = plotParametros(accuracies, gammaParameters, cParameters, tipoKernel)
  figure;
  x = cParameters;
  y = gammaParameters;
  z = accuracies(1, :);
  
  scatter3 (x(:), y(:), z(:), [], z(:));
  title ({'Grafica de precisiones', ...
         tipoKernel});
         
  xlabel('Parametro C') 
  ylabel('Parametro Gamma')
  zlabel('Precision obtenida') 
end