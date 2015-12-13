%% Código fuente para el proyecto del curso Paradigmas Computaciones
%  Tema: Predicción Climática usando Máquinas de soporte vectorial
%
% este código utiliza la biblioteca LIBSVM para Matlab/Octave disponible
% en http://www.csie.ntu.edu.tw/~cjlin/libsvm/
%
% IMPORTANTE
% Profe, los .mex incluidos en este proyecto sin las bibliotecas dinámicas del
% paquete libSVM, pero yo las compile en Windows, no estoy seguro si le irán a servir.
% Si no le sirve, descomprima el zip libsvm-3.20.zip
% y con su Octave entre al directorio libsvm-3.20/matlab y ejecuta el comando make
% entonces, se le deberían crear los .mex y nada más los viene a reemplazar acá
%
% en todo caso el libsvm-3.0.zip trae un README claro.
%
% Autores Emmanuel Arias y Yara Corrales

% limpieza general
clear ; close all; clc

% obtener los conjuntos de datos
[trainData, testData, evalData, evalDataDates] = obtenerConjuntosDatos('datos-finales-72202.csv');

printf("Profe, la optimizacion de paramatros dura bastante. Puede ir por un cafe mientras termina, o puede interrumpir el programa y poner las variables autoR y autoP en 1.\n\n");

autoR = 0;
autoP = 0;

if(autoR == 0)
  % Optimizacion parametros RBF
  gammaParameter = [0.01 0.1 0.5 1 2 3 5 10 15];
  cParameter = [0.01 0.1 1 5 10 15 25 50 75 100];
  [accuraciesRBF, gammaParametersRBF, cParametersRBF] = optimizarParametros(gammaParameter, cParameter, trainData, testData, 'kernel Gaussiano RBF', '-t 2');
  [bestAccuracyRBF, bestGammaRBF, bestCRBF] = obtenerMejoresParametros(accuraciesRBF, gammaParametersRBF, cParametersRBF);
  plotParametros(accuraciesRBF, gammaParametersRBF, cParametersRBF, 'Kernel Gaussiano RBF');
else
   bestCRBF = 100;
   bestGammaRBF = 0.1;
endif

if(autoP == 0)
  % Optimizacion parametros Polinomial
  gammaParameter = [0.001 0.01 0.1 0.25 0.3 0.4 0.5 1 5];
  cParameter = [5 7.5 10 12.2 15 17.5 25];
  [accuraciesPoly, gammaParametersPoly, cParametersPoly] = optimizarParametros(gammaParameter, cParameter, trainData, testData, 'kernel Polinomial', '-t 1 -d 2');
  [bestAccuracyPoly, bestGammaPoly, bestCPoly] = obtenerMejoresParametros(accuraciesPoly, gammaParametersPoly, cParametersPoly);
  plotParametros(accuraciesPoly, gammaParametersPoly, cParametersPoly, 'Kernel Polinomial');
else
   bestGammaPoly = 1;
   bestCPoly = 15;
endif

 
% se calcula el modelo optimo para kernel RBF
svmParam = cstrcat('-s 0 -t 2 -c ', num2str(bestCRBF), ' -g ', num2str(bestGammaRBF), ' -h 0 -q');
modelRBF = svmtrain(trainData.y, trainData.X, svmParam);

[predicted_labelRBF, accuracyRBF, decision_valuesRBF] = svmpredict(evalData.y, evalData.X, modelRBF, '-q');

printf("\nPrecision lograda con el modelo que utiliza el kernel RBF: %d\n", accuracyRBF(1));

% se calcula el modelo optimo para kernel Polinomial
svmParam = cstrcat('-s 0 -t 1 -d 2 -c ', num2str(bestCPoly), ' -g ', num2str(bestGammaPoly), ' -h 0 -q');
modelPoly = svmtrain(trainData.y, trainData.X, svmParam);

[predicted_labelPoly, accuracyPoly, decision_valuesPoly] = svmpredict(evalData.y, evalData.X, modelPoly, '-q');

printf("Precision lograda con el modelo que utiliza el kernel Polinomial: %d\n", accuracyPoly(1));

printf("Ejemplo de predicciones. Las primeras tres columnas corresponden a la fecha del dia que se quiere predecir.\nLa segunda columna corresponde a la clase real del dia.\nLa quinta y sexta columna corresponde a las predicciones que hicieron los modelos seleccionados utilizando el kernel RBF y polinomial respectivamente.\n")
[evalDataDates(1:10, :) evalData.y(1:10, :) predicted_labelPoly(1:10, :) predicted_labelRBF(1:10, :)]
