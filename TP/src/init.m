addpath('../lib/jsonlab');
configuration = config.parse(config.read('../config.json'));
mlp = network.build(configuration);
