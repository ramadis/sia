function retval = errors ()
  retval.fromName = @fnFromName;
endfunction

function error = MSE(expectedValues, obtainedValues)
	error = (0.5*sum((expectedValues - obtainedValues) .^ 2)) / length(expectedValues);
endfunction

function retval = fnFromName (name)
  % To add a new activation function add the name to the nameFns array
  % and add the function to the fnMap structure.
  nameFns = ['MSE'];

  fnMap.MSE = @MSE;

  validFn = any(strmatch(name, nameFns, 'exact'));

  if (!validFn)
    error('Invalid activation function');
    return;
  endif

  retval = fnMap.(name);
endfunction
