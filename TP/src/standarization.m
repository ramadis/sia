function retval = standarization
  retval.standarize = @standarize;
endfunction

function norm_value = normalised_diff( data )
  % Normalise values of an array to be between -1 and 1
  % original sign of the array values is maintained.
  if abs(min(data)) > max(data)
        max_range_value = abs(min(data));
        min_range_value = min(data);
  else
      max_range_value = max(data);
      min_range_value = -max(data);
  endif
  norm_value = 2 .* data ./ (max_range_value - min_range_value);
end


function retval= standarize(data)
  % Normalize input and outputs
  % And shape them as a matrix
  output = normalised_diff([cell2mat(data).output]);
  setAmount = rows(output');
  rawInput = [cell2mat(data).input];
  input = reshape(normalised_diff(rawInput), [setAmount, rows(rawInput') / setAmount]);

  % Rebuild initial data structure
  for idx = 1:rows(input)
    data = [ data struct('output', [output(idx)], 'input', input(idx, 1:end)) ];
  end

  % Remove repeated values
  retval = data(1:end/2);
endfunction
