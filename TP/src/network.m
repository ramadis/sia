function retval = setInitialWeights (weights, size) % TODO check function signature
  if (rows(weights) < 1)
    retval = rand(size);
    return
  endif

  retval = weights;
endfunction

function net = build (config)
  weights = setInitialWeights(config.weights);


  function trainretval = train (data)
    trainretval = 1;
  endfunction

  function testretval = test (data)
    testretval = 1;
  endfunction

  net.train = train;
endfunction

network.build = build;
