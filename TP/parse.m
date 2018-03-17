function retval = parseLayer (rawLayer)
  retval.fn = activation.fromName(rawLayer{1});
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
