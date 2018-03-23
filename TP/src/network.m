function retval = network
  retval.build = @build;
  retval.train = @train;
  retval.test = @test;
endfunction

function retval = setInitialWeights (config)
  layerAmount = size(config.layers, 2);

  % Generate random initial weights given the size of each layer
  for idxLayer = 1:(layerAmount - 1)
    layer = config.layers(1, idxLayer);
    nextLayer = config.layers(1, idxLayer + 1);
    config.weights{idxLayer} = 2 * rand(nextLayer.neurons,layer.neurons + 1) - 1;
  end

  retval = config.weights;
endfunction

function retval = train (config)
  for epoch = 1:config.epochs % For each epoch
    for idxSample = 1:rows(config.training') % Iterate through each sample (Lets do it stochasticly, why not)
      % Set sample shape correctly
      sample = config.training{idxSample};

      % Initialize procedure with input data
      layer = config.layers(1);
      input{1} = sample.input';
      output{1} = input{1};

      % Useful variables
      correctOutput = sample.output';
      layerAmount = size(config.layers, 2);

      % Forward passing
      for idxLayer = 1:(layerAmount - 1)
        layer = config.layers(1, idxLayer);
        input{idxLayer + 1} = [layer.bias; layer.activation(output{idxLayer})];
        weights = config.weights{idxLayer};
        output{idxLayer + 1} = weights * input{idxLayer + 1};
      end
      finalOutput = config.layers(1, layerAmount).activation(output{layerAmount});

      % Backpropagation
      delta{layerAmount} = finalOutput - correctOutput;

      for idxLayer = (layerAmount - 1):-1:2
        delta{idxLayer} = ((config.weights{idxLayer}' * delta{idxLayer + 1}) .* (input{idxLayer + 1} .* (1 - input{idxLayer + 1})))(2:end);
      end

      for idxLayer = (layerAmount - 1):-1:1
        config.weights{idxLayer} -= (config.eta * (delta{idxLayer + 1} * input{idxLayer + 1}'));
      end

      % Optimizations
    end
  end

  retval = config;
endfunction

function retval = test (config)

  for idxSample = 1:rows(config.training')
    % Set sample shape correctly
    sample = config.training{idxSample};

    % Set initial variables
    layer = config.layers(1);
    input{1} = sample.input';
    output{1} = input{1};

    % Useful variables
    layerAmount = size(config.layers, 2);

    % Forward passing
    for idxLayer = 1:(layerAmount - 1)
      layer = config.layers(1, idxLayer);
      input{idxLayer + 1} = [layer.bias; layer.activation(output{idxLayer})];
      weights = config.weights{idxLayer};
      output{idxLayer + 1} = weights * input{idxLayer + 1};
    end

    finalOutput = config.layers(1, layerAmount).activation(output{layerAmount});
  end

  retval = 1;
endfunction

function retval = build (config)
  retval = config;
  retval.weights = setInitialWeights(config);
endfunction
