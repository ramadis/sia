% This file assumes the config shape
% TODO: It should be merged with the config.m or vice versa

function retval = parse()
  retval.optimization = @parseOptimization;
  retval.layer = @parseLayer;
endfunction

function retval = parseLayer (rawLayer)
  rawLayer = rawLayer{1};
  retval.activation = activation.fromName(rawLayer.activation);
  retval.bias = rawLayer.bias;
  retval.neurons = rawLayer.neurons;
endfunction

function retval = parseOptimization (rawOptimization)
  rawOptimization = rawOptimization{1};
  name = rawOptimization.type;
  params = rawOptimization.params; % TODO: Edit to add params for optimizations
  retval = optimization.fromName(name)(params);
endfunction
