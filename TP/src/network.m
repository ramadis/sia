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
  %{
  function trainretval = train (data)
    for epoch = 1:config.epochs % For each epoch

      for idxSample = 1:rows(data) % Iterate through each sample (Lets do it stochasticly, why not)
        output[1] = data[idxSample];

        % Forward passing
        for idxLayer = 1:rows(config.layers)
          layer = config.layers[idxLayer];
          input[idxLayer] = [layer.bias; output];
          weights[idxLayer] = config.weights[idxLayer];
          output[idxLayer + 1] = layer.activation(weight * input);
        end

        % Backpropagation
        for idxLayer = rows(config.layers):2
          (weights[idxLayer - 1]' * delta[idxLayer]) .* (output[idxLayer] .* (1 - output[idxLayer]))(2:end);

        end

        % Here take place the optimizations (After k samples, or 1 epoch)
      end

    end
    %}
  endfunction

  function testretval = test (data)
    testretval = 1;
  endfunction

  net.train = train;
  net.test = test;
endfunction

network.build = build;
