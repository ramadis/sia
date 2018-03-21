function retval = network
  retval.build = @build;
  retval.train = @train;
  retval.test = @test;
endfunction

function retval = setInitialWeights (config) % TODO check function signature
  config.weights{1} = 2 * rand(2,3) - 1;
  config.weights{2} = 2 * rand(1,3) - 1;
  retval = config.weights;
  return;

  if (rows(weights) < 1)
    retval = 2 * rand(10,3) - 1; % random values within [-1;1] (Filas de la current x Columnas de las previous) + el bias (que no lee weights pero si da weights)
    return
  endif

  retval = weights;
endfunction

function retval = train (config)
  elem = [0; 0; 0]; % output ; inputs
  data = [ elem ];

  for epoch = 1:config.epochs % For each epoch
    weights = input = output = [];

    for sample = data % Iterate through each sample (Lets do it stochasticly, why not)

      % Initialize procedure with input data
      layer = config.layers(1);
      input{1} = sample(2:end);
      output{1} = input{1};

      % Useful variables
      correctOutput = sample(1);
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
      for idxLayer = (layerAmount - 1):2
        delta{idxLayer} = (config.weights{idxLayer}' * delta{idxLayer + 1}) .* (input{idxLayer + 1} .* (1 - input{idxLayer + 1}));
        config.weights{idxLayer} -= (config.eta * (delta{idxLayer + 1} * input{idxLayer + 1}'));
      end

      % Optimizations
    end

  end

  retval = config;
endfunction

function retval = test (data)
  retval = 1;
endfunction

function retval = build (config)
  retval = config;
  retval.weights = setInitialWeights(config);
endfunction
