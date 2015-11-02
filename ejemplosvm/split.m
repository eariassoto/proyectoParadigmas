function [learn, val] = split(data, nfold, i)
  lim = size(data, 1);
  index = 1:nfold:(lim-mod(lim,nfold));
  index = i.+index;
  val = data(index, :);
  
  index = setdiff(1:lim, index);
  learn = data(index, :);