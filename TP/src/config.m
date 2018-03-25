function retval = config ()
  retval.parse = @parseConfig;
  retval.read = @readConfig;
endfunction

% This file assumes the config shape
function retval = readConfig (filepath)
  retval = loadjson(filepath);
endfunction

function retval = parseConfig (rawConfig)
  retval.eta = rawConfig.eta; % Initial eta for the network
  retval.epochs = rawConfig.epochs; % Amount of epochs to iterate the network
  retval.weights = cell2mat(rawConfig.weights); % Initial weights for the neural network. Not used currently.
  retval.test = cleanup(rawConfig.test); % Test set
  retval.error = errors.fromName(rawConfig.error); % Error function
  retval.training = cleanup(rawConfig.training); % Training set
  retval.optimization = arrayfun(parse.optimization, rawConfig.optimization); % Array of Optimization algorithms for backpropagation
  retval.layers = arrayfun(parse.layer, rawConfig.layers); % Layer configuration structure
endfunction
