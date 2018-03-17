% This file assumes the config shape
% TODO: It should be merged with the config.m or vice versa

function retval = parseLayer (rawLayer)
  retval.activation = activation.fromName(rawLayer{1});
  retval.bias = rawLayer{2};
  retval.neurons = rawLayer{3};
endfunction

function retval = parseOptimization (rawOptimization)
  name = rawOptimization{1};
  params = rawOptimization{2}; % TODO: Edit to add params for optimizations
  retval = optimization.fromName(name)(params);
endfunction

parse.optimization = parseOptimization;
parse.layer = parseLayer;
