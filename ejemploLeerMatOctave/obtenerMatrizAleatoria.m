function MatrizDesordenada = obtenerMatrizAleatoria(Matriz)
  MatrizDesordenada = Matriz(randperm(size(Matriz,1)),:);
 endfunction