function [weights, bias, deltaCapa1] = backpropagation (weights, bias, deltaCapa2, coeff, capa1Values, z2Values)
 
  capa1Size=size(capa1Values, 1);
  capa2Size=size(z2Values, 1);
  deltaCapa1=zeros(capa1Size, 1);
  
  for i = 1:capa1Size
    for j=1:capa2Size
      deltaCapa1(i)=deltaCapa1(i)+weights(i,j)*exp(-z2Values(j))/((1+exp(-z2Values(j)))^2)*deltaCapa2(j);
     end
  end
  
  for i = 1:capa1Size
    for j= 1:capa2Size
      weights (i,j) = weights (i,j) + capa1Values(i)*exp(-z2Values(j))/((1+exp(-z2Values(j)))^2)*deltaCapa2(j)*coeff; 
    end
  end 
  
  for j = 1:capa2Size
      bias (j) = bias(j) + exp(-z2Values(j))/((1+exp(-z2Values(j)))^2)*deltaCapa2(j)*coeff; 
  end
    
endfunction
