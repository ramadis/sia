addpath('../lib/jsonlab');
configuration = config.parse(config.read('../config.json'));
mlp = network.build(configuration);
mlp.train(parse.input('../input/train.json'));
