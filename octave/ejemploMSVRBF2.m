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

fprintf('Cargando los datos de entrenamiento para MSV con kernel Gaussiano (RBF).\n');
fprintf("Mostrando los datos en la figura.\n \
La clase 0 esta representada por O\n \
La clase 1 esta representada por +\n\n");

% Carga los datos en las matrices X y y
load('svmData3.mat');

% Mostrar los datos de entrenamiento
plotData(X, y);

fprintf('Programa en pausa. Presione Enter para continuar.\n\n');
pause;

fprintf('Entrenando MSV RBF.\n');

% Parametro C de la funcion de costo
% C muy grande: lower bias, high variance
% C muy pequeño: high bias, lower variance
C = 1;
gamma = 50;
% implementar el gamma
svmParam = cstrcat('-s 0 -t 2 -c ', num2str(C), ' -g ', num2str(gamma));
model = svmtrain(y, X, svmParam);


visualizeBoundary(X, y, model);
fprintf('Programa en pausa. Presione Enter para continuar.\n\n');
pause;

fprintf('Datos de prediccion:\n');

% Datos de prediccion

test_label = [1;0;0;1]; % valores random o conocidos mx1
Test_matrix = [-0.555 0.001; ; 0 -0.555; -0.1999 -0.444; -0.200 0.222]; % mxn

for i = 1:size(Test_matrix, 1)
  fprintf('%f, %f\n', Test_matrix(i,1), Test_matrix(i,2));
endfor

fprintf('Programa en pausa. Presione Enter para continuar.\n\n');
pause;

fprintf('Aplicando predicciones a los datos:\n');

[predicted_label] = svmpredict(test_label, Test_matrix, model);

for i = 1:size(Test_matrix, 1)
  fprintf('%f, %f pertenece a la clase %d\n', Test_matrix(i,1), Test_matrix(i,2), predicted_label(i));
endfor

fprintf('\nMostrando las predicciones en la figura.\n');
hold on;
plotData(Test_matrix, predicted_label, 17);