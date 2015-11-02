%% Ejemplo de máquina de soporte vectorial con kernel gaussiano
%
% este código utiliza la biblioteca LIBSVM para Matlab/Octave disponible
% en http://www.csie.ntu.edu.tw/~cjlin/libsvm/#matlab
%
% los datos de ejemplo son tomados del curso Machine Learning impartido en Coursera
% por la Universidad de Stanford
%
% Emmanuel Arias Soto

clear ; close all; clc

%load('svmData2.mat');
Matriz = csvread('2datos-finales-72202.csv');

% separo el 70% para entrenamiento y el otro para pruebas
[TrainMat, TestMat] = split(Matriz, 3, 0); 

trainData.X = TrainMat(:, 4:14);
trainData.y = TrainMat(:, 15);

testData.X = TestMat(:, 4:14);
testData.y = TestMat(:, 15);

[trainData, testData, jn2] = scaleSVM(trainData, testData, trainData, 0, 1);

% Parametro C de la funcion de costo
% C muy grande: lower bias, high variance
% C muy pequeño: high bias, lower variance
C = 1;
gamma = 0.01;
% implementar el gamma
svmParam = cstrcat('-s 0 -t 2 -c ', num2str(C), ' -g ', num2str(gamma), ' -h 0');
model = svmtrain(trainData.y, trainData.X, svmParam);

[predicted_label] = svmpredict(testData.y, testData.X, model);
