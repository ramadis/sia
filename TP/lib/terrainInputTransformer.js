// TODO: Add Spliting into test and training set and file handling

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;
  while (0 !== currentIndex) {

  // Pick a remaining element
  randomIndex = Math.floor(Math.random() * currentIndex);
  currentIndex -= 1;

  // And swap it with the current element.
  temporaryValue = array[currentIndex];
  array[currentIndex] = array[randomIndex];
  array[randomIndex] = temporaryValue;
  }
  return array;
}

function buildSets() {
  const lines = a.split('\n');
  lines.shift();
  const nums = lines.map(line => line.split(' ')
                                     .filter(x => x)
                                     .map(Number))
                    .filter(x => x.length);

  // Shuffle to randomly select elements
  const parsed = shuffle(nums.map(num => ({ output: [num.pop()], input: num })));
  const trainingSet = parsed.splice(Math.floor( parsed.length * 0.8 ));
  const testSet = parsed;

  // Build final files
  const trainingSetJSON = JSON.stringify({ data: trainingSet  });
  const testSetJSON = JSON.stringify({ data: testSet  });

  console.log(trainingSetJSON);
  console.log(testSetJSON);
}
