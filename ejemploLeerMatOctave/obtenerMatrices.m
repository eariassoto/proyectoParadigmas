function [MatrizAtmosfericos, MatrizPrecipitacion] = obtenerMatrices()
  MatrizAtmosfericos =  load ("-ascii", "../datos/datos-limpios/datos-atmosfericos-finales.txt");
  MatrizPrecipitacion =  load ("-ascii", "../datos/datos-limpios/datos-precipitacion-finales.txt");

  colAtmos = size(MatrizAtmosfericos, 2); % size(A, 2) indice num columnas matriz

  % fusiono ambas matrices
  M = [MatrizAtmosfericos MatrizPrecipitacion]; 

  % mezclo simultaneamente
  M = obtenerMatrizAleatoria(M);

  % separo las matrices
  MatrizAtmosfericos  = M(:, [1 : colAtmos]);
  MatrizPrecipitacion = M(:, [(colAtmos+1) : end]);

  % guardo
  save "MatrizPrecipitacion.mat" MatrizPrecipitacion;
  save "MatrizAtmosfericos.mat" MatrizAtmosfericos;

endfunction