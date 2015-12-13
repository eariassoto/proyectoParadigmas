% devuelve los conjuntos de datos ya mezclados, escalados y separados

function [trainData,testData,evalData,evalDataDates]=obtenerConjuntosDatos(src)
  
  % lee el csv con los datos
  Matriz = csvread(src);

  % mezcla la matriz
  Matriz = Matriz(randperm(size(Matriz,1)),:);

  % separo el 70% para entrenamiento, 15% validación cruzada y 15% de evaluacion
  [TrainMat, TestMat] = split(Matriz, 3, 0); 

  [CVMat, EvalMat] = split(TestMat, 2, 0); 

  trainData.X = TrainMat(:, 4:14);
  trainData.y = TrainMat(:, 15);

  testData.X = CVMat(:, 4:14);
  testData.y = CVMat(:, 15);

  evalData.X = EvalMat(:, 4:14);
  evalData.y = EvalMat(:, 15);
  
  evalDataDates = EvalMat(:, 1:3);
 
 [trainData, testData, evalData] = scaleSVM(trainData, testData, evalData, 0, 1);
 
end