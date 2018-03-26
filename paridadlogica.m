numIn = 3; #el numero de entradas
numCapa1=16; #numero de neuronas en la capa intermedia

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

desired_out = zeros(2^numIn, 1);

for i = 1:2^numIn
  for j = 1:numIn
    desired_out(i)+= input(i, j); #calculamos la paridad logica de cada entrada
  end
  desired_out(i) = mod(desired_out(i), 2);
end

desired_out

biasOut =  -1*5.*rand(1, 1);
biasCapa1 = -1*5.*rand(numCapa1, 1);
coeff = 1; #coeficiente de aprentizaje
rand('state',sum(100*clock));
weightsIn = -1*2.*rand(numIn, numCapa1, 1);
weightsCapa1 = -1*2.*rand(numCapa1, 1);


#entrenamiento
iterations = 1000;
for k=1:iterations

for i = 1:2^numIn
     [outCapa1, zCapa1]=computacionCapa(input(i, :).', weightsIn, biasCapa1); #ahi zCapa1 seria el resultado sin aplicar la funcion de salida
     [out, y]=computacionCapa(outCapa1, weightsCapa1, biasOut); #y y el resultado final sin aplicar la funcion
    
     deltaOut = desired_out(i)-out; #calculamos la diferencia de valor obtenido con lo que queremos
     
     [weightsCapa1, biasOut, deltaCapa1] = backpropagation(weightsCapa1, biasOut, deltaOut, coeff, outCapa1, y);
     [weightsIn, biasCapa1] = backpropagation(weightsIn, biasCapa1, deltaCapa1, coeff, input(i, :).', zCapa1);
end

end

#?evaluacion
out=zeros(2^numIn, 1);
for i = 1:2^numIn
     outCapa1=computacionCapa(input(i, :).', weightsIn, biasCapa1);
     out(i)=computacionCapa(outCapa1, weightsCapa1, biasOut);
end

out

error = (0.5*sum((desired_out - out) .^ 2)) / length(desired_out)
