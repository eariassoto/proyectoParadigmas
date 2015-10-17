%% Ejemplo de máquina de soporte vectorial con kernel lineal
%
% este código utiliza la biblioteca LIBSVM para Matlab/Octave disponible
% en http://www.csie.ntu.edu.tw/~cjlin/libsvm/#matlab
%
% los datos de ejemplo son tomados del curso Machine Learning impartido en Coursera
% por la Universidad de Stanford
%
% Emmanuel Arias Soto

clear ; close all; clc

fprintf('Cargando los datos de entrenamiento para MSV lineal.\n');
fprintf("Mostrando los datos en la figura.\n \
La clase 0 esta representada por O\n \
La clase 1 esta representada por +\n\n");

% Carga los datos en las matrices X y y
load('svmData1.mat');

% Mostrar los datos de entrenamiento
plotData(X, y);

fprintf('Programa en pausa. Presione Enter para continuar.\n\n');
pause;

fprintf('Entrenando MSV lineal.\n');

% Parametro C de la funcion de costo
% C muy grande: lower bias, high variance
% C muy pequeño: high bias, lower variance
C = 1;
svmParam = cstrcat('-s 0 -t 0 -c ', num2str(C));
model = svmtrain(y, X, svmParam);

w = model.SVs' * model.sv_coef;
b = -model.rho;
if (model.Label(1) == -1)
    w = -w; b = -b;
end

visualizeBoundaryLinear(X, y, w, b);
fprintf('Programa en pausa. Presione Enter para continuar.\n\n');
pause;

fprintf('Datos de prediccion:\n');

% Datos de prediccion

test_label = [1;0;0;0;1]; % valores random o conocidos mx1
Test_matrix = [2.7 4.1; 1.5 2.3;3.0 2.7;0.4 4.3; 1.6 3.8]; % mxn

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
plotData(Test_matrix, predicted_label, 10);