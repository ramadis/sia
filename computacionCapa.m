
function [a, z] = computacionCapa (entradas, weights, bias)

numNeuro=size(bias, 1); #el numero de neuronas en la capa de salida
numEntradas=size(entradas, 1);
a=zeros(numNeuro, 1);
z=zeros(numNeuro, 1);

for i=1:numNeuro
  for j=1:numEntradas
      entradas(j);
      z(i)= z(i)+ weights(j, i)*entradas(j);
  end
  z(i)=z(i)+bias(i);
  a(i)=1/(1+exp(-z(i)));
end
  
  
endfunction
