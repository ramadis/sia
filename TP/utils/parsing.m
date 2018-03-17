function retval = parseLayer (rawLayer)
  retval.fn = activation.actFnFromName(rawLayer{1});
  retval.bias = rawLayer{2};
  retval.neurons = rawLayer{3};
endfunction

function retval = parseOptimization (rawOptimization)
  retval.type = rawConfig{2}{1};
  retval.params = rawConfig{2}{2}; % TODO: Edit to add params for optimizations
endfunction
