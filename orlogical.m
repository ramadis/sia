numIn = 5; #el numero de entradas

input=zeros(2^numIn, numIn);

for i=2:2^numIn
  j=1;
  input(i, :)=input(i-1, :);
  
  if input(i-1, j) == 0
    input(i, j)=1;
  else
    j=j+1;
    while j<numIn+1
        
      if input(i-1, j) == 0;
        input(i, j)=1;
        
        for k=j-1:-1:1  
          input(i, k)=0;
        end  
        
        break;
      else
       j=j+1;
      endif

    endwhile
  endif  
end  

for i = 1:2^numIn
  desired_out(i)= input(i, 1); 
  for j = 2:numIn
    desired_out(i)= desired_out(i) | input (i, j);
  end
end

bias = 1; 
coeff = 0.7; 
rand('state',sum(100*clock));
weights = -1*2.*rand(numIn,1);

#entrenamiento
iterations = 100;
for k=1:iterations

for i = 1:2^numIn #ahi z seria el resultado sin aplicar la funcion de salida
     [out, y]=computacionCapa(input(i, :).', weights, bias);
    
     deltaOut = desired_out(i)-out;
     
     [weights, bias] = backpropagation(weights, bias, deltaOut, coeff, input(i, :).', y);
end

end

#?evaluacion
out=zeros(2^numIn, 1);
for i = 1:2^numIn
     outCapa1=computacionCapa(input(i, :).', weightsIn, biasCapa1);
     out(i)=computacionCapa(outCapa1, weightsCapa1, biasOut);
end

out

error = (0.5*sum((desired_out' - out) .^ 2)) / length(desired_out)