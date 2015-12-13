% divide un conjunto de valores en subconjuntos
%
% profe esta funcion no la hicimos nosotros solo que no sé qué hice el link de donde
% la saque
% - Emmanuel
function [learn, val] = split(data, nfold, i)
  lim = size(data, 1);
  index = 1:nfold:(lim-mod(lim,nfold));
  index = i.+index;
  val = data(index, :);
  
  index = setdiff(1:lim, index);
  learn = data(index, :);