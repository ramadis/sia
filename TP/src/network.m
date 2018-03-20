function retval = network
  retval.build = @build;
  retval.train = @train;
  retval.test = @test;
endfunction

function retval = setInitialWeights (weights, size) % TODO check function signature
  if (rows(weights) < 1)
    retval = 2 * rand(4,1) - 1; % random values within [-1;1]
    return
  endif

  retval = weights;
endfunction

function retval = train (config)
  data = [];

  for epoch = 1:config.epochs % For each epoch
    input = output = [];

    for idxSample = 1:rows(data) % Iterate through each sample (Lets do it stochasticly, why not)
      output = [ data(idxSample) ];

      % Forward passing
      for idxLayer = 1:rows(config.layers)
        layer = config.layers(idxLayer);
        input = [ input [layer.bias; output] ];
        weights = [ weights config.weights(idxLayer) ];
        output = [ output layer.activation(weight * input)];
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
  retval.weights = setInitialWeights(config.weights);
endfunction
