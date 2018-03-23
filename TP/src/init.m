% TODO: Standarize data
% TODO: Backprop optimizations
% TODO: Load and test using the test set

addpath('../lib/jsonlab');
rand('state', sum( 100 * clock )); % seed random state

configuration = config.parse(config.read('../config.json'));
mlp = network.train(network.build(configuration));
network.test(mlp)
