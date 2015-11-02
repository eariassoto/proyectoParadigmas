clear;
clc;

Matriz = csvread('../datos/datos-finales-72202.csv');

% separo el 70% para entrenamiento y el otro para pruebas
%[TrainMat, TestMat] = split(Matriz, 3, 0); 

trn_data.X = Matriz(:, 4);
trn_data.y = Matriz(:, 15);

%tst_data.X = TestMat(:, 11);
%tst_data.y = TestMat(:, 15);

h = plot(trn_data.X, trn_data.y, 'ko');

legend('Training');
y1 = max([trn_data.y]);
y2 = min([trn_data.y]);
axis([0 1 y2 y1]);