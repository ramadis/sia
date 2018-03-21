function retval = network
  retval.build = @build;
  retval.train = @train;
  retval.test = @test;
endfunction

function retval = setInitialWeights (weights, size) % TODO check function signature
  if (rows(weights) < 1)
    retval = 2 * rand(10,3) - 1; % random values within [-1;1] (Filas de la current x Columnas de las previous)
    return
  endif

  retval = weights;
endfunction

function retval = train (config)
  elem = [2; 3; 4]; % output ; inputs
  data = [ elem ];

  for epoch = 1:config.epochs % For each epoch
    weights = input = output = [];

    for sample = data % Iterate through each sample (Lets do it stochasticly, why not)
      layer = config.layers(1);
      output{1} = [ layer.bias ; sample(2:end) ];

      % Forward passing
      for idxLayer = 2:size(config.layers, 2)
        layer = config.layers(1, idxLayer);
        input = output{idxLayer - 1};
        weights = config.weights{idxLayer - 1};
        output{idxLayer} = [ layer.bias; layer.activation(weights * input) ];
      end

      % Backpropagation
      for idxLayer = rows(config.layers):2
        %(weights[idxLayer - 1]' * delta[idxLayer]) .* (output[idxLayer] .* (1 - output[idxLayer]))(2:end);
      end

      % Optimizations
    end

  end

  retval = config;
  % retval.weights = weights;
endfunction

function retval = test (data)
  retval = 1;
endfunction

function retval = build (config)
  retval = config;
  retval.weights{1} = setInitialWeights(config.weights);
endfunction
