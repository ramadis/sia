function retval = network
  retval.build = @build;
  retval.train = @train;
  retval.test = @test;
endfunction

function retval = setInitialWeights (config)
  % TODO: If initial weights are set, do not overwrite
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
  firstMomentumPass = firstEtaPass = 0;
  currentStep = 0;
  lastError = test(config, {config.training{1:end}});
  errors = [lastError];

  for epoch = 1:config.epochs % For each epoch
    epoch
    for idxSample = 1:rows(config.training') % Iterate through each sample (Lets do it stochasticly, why not)
      % Set sample shape correctly
      sample = config.training{idxSample};

      % Initialize procedure with input data
      layer = config.layers(1);
      input{1} = sample.input';
      output{1} = input{1};

      % Useful variables
      correctOutput = sample.output';
      lastWeights = config.weights;
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

      % Optimizations for sample
      for optimization = config.optimization
        if (strcmp(optimization.name, 'MOMENTUM'))
          if (firstMomentumPass == 0)
            % Initialize values
            lastWeights = config.weights;
            firstMomentumPass = 1;
          else
            for idxLayer = (layerAmount - 1):-1:1
              deltaWeights = config.weights{idxLayer} - lastWeights{idxLayer};
              config.weights{idxLayer} += deltaWeights * optimization.params.alpha;
              lastWeights = config.weights;
            end
          endif
        endif

        if (strcmp(optimization.name, 'ETAMEJORADO'))
          currentError = test(config, {config.training{1:end}});
          deltaError = currentError - lastError;

          % Add a step if the error is decreasing
          if (deltaError <= 0)
            currentStep += 1;
            lastWeights = config.weights;

            % If the error was reduced, jump!
            if (currentStep >= optimization.params.k)
              config.eta += optimization.params.alpha;
              currentStep = 0; % Start counting again
            endif
          else
            currentStep = 0;

            % If the error was increased, get back and walk with caution
            if (deltaError > 0)
              config.eta -= optimization.params.beta * config.eta;
              config.weights = lastWeights;
            endif
          endif
          lastError = currentError;
        endif
      end
    end

    % Optimizations for epoch
    for optimization = config.optimization
      if (strcmp(optimization.name, 'ETAMEJORADO_EPOCH'))
        currentError = test(config, {config.training{1:end}});
        deltaError = currentError - lastError;

        % Add a step if the error is decreasing
        if (deltaError <= 0)
          currentStep += 1;
          lastWeights = config.weights;

          % If the error was reduced, jump!
          if (currentStep >= optimization.params.k)
            config.eta += optimization.params.alpha;
            currentStep = 0; % Start counting again
          endif
        else
          currentStep = 0;

          % If the error was increased, get back and walk with caution
          if (deltaError > 0)
            config.eta -= optimization.params.beta * config.eta;
            config.weights = lastWeights;
          endif
        endif
        lastError = currentError;
      endif
    end

    lastError = test(config, {config.training{1:end}});
    errors = [errors lastError];
  end
  savejson('data', errors, 'errors.json');
  savejson('data', config.weights, 'weights.json');
  retval = config;
endfunction

function retval = test (config, test)
  for idxSample = 1:rows(test')
    % Set sample shape correctly
    sample = test{idxSample};

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
    instances.expectedOutput{idxSample} = sample.output;
    instances.output{idxSample} = finalOutput;
  end

  % Print values
  instances.expectedOutput; % Expected output
  instances.output; % Output
  diffs = cell2mat(instances.output) - cell2mat(instances.expectedOutput);
  savejson('data', diffs, 'diffs.json');
  retval = config.error(cell2mat(instances.expectedOutput), cell2mat(instances.output)); % Error
endfunction

function retval = build (config)
  retval = config;
  retval.weights = setInitialWeights(config);
endfunction
