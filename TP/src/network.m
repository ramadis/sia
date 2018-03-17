function retval = setInitialWeights (weights, size) % TODO check function signature
  if (rows(weights) < 1)
    retval = rand(size);
    return
  endif

  % THETA1 = 2*rand(2,3) - 1; 2 x 3 matrix within [-1;1]

  retval = weights;
endfunction

function net = build (config)
  weights = setInitialWeights(config.weights);


  function trainretval = train (data)
    for epoch = 1:config.epochs % For each epoch

      for idxSample = 1:rows(data) % Iterate through each sample
        output = data[idxSample];

        for idxLayer = 1:rows(config.layers) % And through each layer
          input = [layer.bias; previousOutput]; % Add the layer bias to the input
          weight = weights[idxLayer]; % Get the weights for each layer
          output = layer.activation(weight * input);
        end

        % Here take place the optimizations
      end

      % Implement learning algorithm
    end
  endfunction

  function testretval = test (data)
    testretval = 1;
  endfunction

  net.train = train;
endfunction

network.build = build;
