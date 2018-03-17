function retval = readConfig (filepath)
  retval = loadjson(filepath);
endfunction

function retval = parseConfig (rawConfig)
  retval.weights = rawConfig{5}; % Initial weights for the neural network
  retval.test = rawConfig{4}; % Test set
  retval.training = rawConfig{3}; % Training set
  retval.optimization = rawConfig{2} % Optimization algorithms for backpropagation
  retval.layers = arrayfun(parseLayer, rawConfig{1}); % Layer configuration structure
endfunction

config.parse = parseConfig;
config.read = readConfig;
