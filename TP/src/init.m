% TODO: Backprop optimizations

addpath('../lib/jsonlab');
rand('state', 42); % seed random state

configuration = config.parse(config.read('../config.json'));
mlp = network.train(network.build(configuration));
network.test(mlp, configuration.test)
