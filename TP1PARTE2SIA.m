# OR
rand('state',sum(100*clock)); # seed random state
#input = [0 0; 1 0; 0 1; 1 1];
input = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
numIn = 8;
desired_out = [0;1;1;1;1;1;1;1]; # [0;0;0;1] for AND
bias = -1;
coeff = rand(); # random learing rate
weights = rand(4,1); # random initial weights [0.43, 0.234, 0.12]
out = zeros(4,1); # initialize output array
iterations = 1000;
function ret = g (x)
  ret = 1/(1+exp(-x));
endfunction

jsondecode('["one", "two", "three"]')

# Algorithm
for i = 1:iterations
  for j = 1:numIn # iterate throug each sample from input arrays
    sample = input(j,:);
    biased_sample = [bias sample];
    h = dot(weights, biased_sample);
    out(j) = g(h);

    # Learning algorithm
    delta = coeff * (desired_out(j) - out(j));
    weights  += (biased_sample * delta)';
   end
end

out;
