# Generic Multi-layer Perceptron

## Run

To run the program clone this repo and run on the console

```sh
cd TP\ PARTE\ 2/src
octave init.m
```

## Configuration

The algorithm is highly parametrized by the file `config.json`. To understand what it contains, please read the report `informe.pdf`.

## Inputs

If you want to add a new terrain, use the `javascript` file `./lib/terrainInputTransformer.js`. Feed it with the raw data, and it will output two different JSON files: a training set and a test set with a randomized 80/20 ratio. Then add these files to `terrain` directory, and into the `training` or `test` folder accordingly. Remember to edit `config.json` to set the new path to the training and test sets.

## Credits

Ramiro Hernán Olivera Fedi          	rolivera@itba.edu.ar                       56498
Alan Arturo Hernández Gutiérrez       alhernandez@itba.edu.ar                  	 60438
Kevin Chidiac                         kchidiac@itba.edu.ar                       60431
Romain Thibaut Marie Latron           rlatron@itba.edu.ar                        60440
