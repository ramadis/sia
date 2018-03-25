// TODO: Add Spliting into test and training set and file handling

const lines = a.split('\n')
lines.shift()
const nums = lines.map(line => line.split(' ')
                                   .filter(x => x)
                                   .map(Number))
                  .filter(x => x.length);
const parsed = nums.map(num => ({ output: [num.pop()], input: num }));
const final = { data : parsed };
JSON.stringify(final);
