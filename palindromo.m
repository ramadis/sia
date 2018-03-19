input = [0 0 0; 0 0 1; 0 1 0; 1 0 0; 0 1 1; 1 0 1; 1 1 0; 1 1 1];
numIn = 3; #el numero de entradas
numOut = 3;
numCapa1=16; #numero de neuronas en la capa intermedia

desired_out=zeros(8, numIn);

for i = 1:8
  for j = 0:numIn-1
    desired_out(i, j+1)= input(i, numIn-j);
  end
end

desired_out
  
biasOut =  -1*5.*rand(numOut, 1);
biasCapa1 = -1*5.*rand(numCapa1, 1);
coeff = 1; #coeficiente de aprentizaje
rand('state',sum(100*clock));
weightsIn = -1*2.*rand(numIn, numCapa1, 1);
weightsCapa1 = -1*2.*rand(numCapa1, numOut, 1);


#entrenamiento
iterations = 100;
for k=1:iterations

for i = 1:8
     [outCapa1, zCapa1]=computacionCapa(input(i, :).', weightsIn, biasCapa1); #ahi zCapa1 seria el resultado sin aplicar la funcion de salida
     [out, y]=computacionCapa(outCapa1, weightsCapa1, biasOut); #y y el resultado final sin aplicar la funcion
    
     for j=1:numOut    
        deltaOut(j) = desired_out(i, j)-out(j); #calculamos la diferencia de valor obtenido con lo que queremos     
     end
     
     [weightsCapa1, biasOut, deltaCapa1] = backpropagation(weightsCapa1, biasOut, deltaOut, coeff, outCapa1, y);
     [weightsIn, biasCapa1] = backpropagation(weightsIn, biasCapa1, deltaCapa1, coeff, input(i, :).', zCapa1);
end

end

#?evaluacion
out=zeros(8, 3);
for i = 1:8
     outCapa1=computacionCapa(input(i, :).', weightsIn, biasCapa1);
     out(i, :)=computacionCapa(outCapa1, weightsCapa1, biasOut);
end

out