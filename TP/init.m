addpath('./lib/jsonlab');
addpath('./utils/utils');

configuration = config.parse(config.read('./config.json'));
mlp = network.build(configuration);
