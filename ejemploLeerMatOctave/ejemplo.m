clear; 
close all;
clc

[MatrizAtmosfericos, MatrizPrecipitacion] = obtenerMatrices();

lim = fix(size(MatrizAtmosfericos, 1) * 0.7); % 70% de las tuplas

AtmosfericosEntrenamiento = MatrizAtmosfericos([1:lim], :);
AtmosfericosValidacion = MatrizAtmosfericos([(lim+1): end], :);

precipitacionEntrenamiento = MatrizPrecipitacion([1:lim], 4); % la 4 col es la precip
precipitacionValidacion = MatrizPrecipitacion([(lim+1): end], 4);


C = 40;
gamma = 100;
% implementar el gamma
svmParam = cstrcat('-s 3 -t 2 -c ', num2str(C), ' -g ', num2str(gamma));
model = svmtrain(precipitacionEntrenamiento, AtmosfericosEntrenamiento, svmParam);

precipitacionValidacion(1, :)

svmpredict(precipitacionValidacion(1, :), AtmosfericosValidacion(1, :), model)
