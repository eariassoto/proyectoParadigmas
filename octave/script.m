clear;
clc;

Matriz = csvread('datos-finales-72202.csv');

% separo el 70% para entrenamiento y el otro para pruebas
[TrainMat, TestMat] = split(Matriz, 3, 0); 

trainData.X = TrainMat(:, 4:14);
trainData.y = TrainMat(:, 15);

testData.X = TestMat(:, 4:14);
testData.y = TestMat(:, 15);


tmp = load('train.txt', '-ascii');
trainData.X = tmp(:,1);
trainData.y = tmp(:,2);

tmp = load('test.txt', '-ascii');
testData.X = tmp(:,1);
testData.y = tmp(:,2);


% esta funcion escala los datos en un rango de 0-1 con respecta al conjunto de
% datos de entrenamiento
%[trainData, testData, jn2] = scaleSVM(trainData, testData, trainData, 0, 1);

% lista de parametros para la maquina de soporte de regresión

param.s = 3; 					                          % epsilon MSR
param.C = max(trainData.y) - min(trainData.y);	% parametro C de regularización
param.t = 2; 				                          	% kernel RBF 
param.gset = 2.^[-7:7];			                   	% rango del parametro gamma
param.eset = [0:5];			                      	% rango del parametro epsilon
param.nfold = 5;			                        	% 5 dobleces validación

Rval = zeros(length(param.gset), length(param.eset));
printf("Iniciando\n", i);
fflush(stdout);
for i = 1:param.nfold
	% partition the training data into the learning/validation
	% in this example, the 5-fold data partitioning is done by the following strategy,
	% for partition 1: Use samples 1, 6, 11, ... as validation samples and
	%			the remaining as learning samples
	% for partition 2: Use samples 2, 7, 12, ... as validation samples and
	%			the remaining as learning samples
	%   :
	% for partition 5: Use samples 5, 10, 15, ... as validation samples and
	%			the remaining as learning samples
	data = [trainData.y, trainData.X];
	[learn, val] = split(data, param.nfold, i);
	lrndata.X = learn(:, 2:end);
	lrndata.y = learn(:, 1);
	valdata.X = val(:, 2:end);
	valdata.y = val(:, 1);

	for j = 1:length(param.gset)
		param.g = param.gset(j);

		for k = 1:length(param.eset)
      printf("Iteracion: %d gamma %d, epsilon %d\n", i, j, k);
      fflush(stdout);
			param.e = param.eset(k);
			param.libsvm = ['-s ', num2str(param.s), ' -t ', num2str(param.t), ...
					' -c ', num2str(param.C), ' -g ', num2str(param.g), ...
					' -p ', num2str(param.e), ' -h 0 -q'];

			% build model on Learning data
			model = svmtrain(lrndata.y, lrndata.X, param.libsvm);

			% predict on the validation data
			[y_hat, Acc, projection] = svmpredict(valdata.y, valdata.X, model, '-q');

			Rval(j,k) = Rval(j,k) + mean((y_hat-valdata.y).^2);
		end
	end

end

Rval = Rval ./ (param.nfold);

[v1, i1] = min(Rval);
[v2, i2] = min(v1);
optparam = param;
optparam.g = param.gset( i1(i2) );
optparam.e = param.eset(i2);

printf("gamma %d, epsilon %d\n", optparam.g, optparam.e);
fflush(stdout);

optparam.libsvm = ['-s ', num2str(optparam.s), ' -t ', num2str(optparam.t), ...
		' -c ', num2str(optparam.C), ' -g ', num2str(optparam.g), ...
		' -p ', num2str(optparam.e), ' -h 0'];

model = svmtrain(trainData.y, trainData.X, optparam.libsvm);

% MSE for test samples
[y_hat, Acc, projection] = svmpredict(testData.y, testData.X, model);
MSE_Test = mean((y_hat-testData.y).^2);
NRMS_Test = sqrt(MSE_Test) / std(testData.y);

% MSE for training samples
[y_hat, Acc, projection] = svmpredict(trainData.y, trainData.X, model);
MSE_Train = mean((y_hat-trainData.y).^2);
NRMS_Train = sqrt(MSE_Train) / std(trainData.y);
