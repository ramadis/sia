function retval = parseLayer (rawLayer)
  retval.fn = activation.fromName(rawLayer{1});
  retval.bias = rawLayer{2};
  retval.neurons = rawLayer{3};
endfunction

function retval = parseOptimization (rawOptimization)
  retval.type = rawOptimization{1};
  retval.params = rawOptimization{2}; % TODO: Edit to add params for optimizations
endfunction

parse.optimization = parseOptimization;
parse.layer = parseLayer;
