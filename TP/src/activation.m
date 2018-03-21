function retval = activation ()
  retval.fromName = @fnFromName;
endfunction

function retval = tanh_ (x)
  beta = 1;
  retval = tanh(beta * x);
endfunction

function retval = exp_ (x)
  beta = 1;
  retval = (1 + exp(-2 * x * beta)) .^ -1;
endfunction

function retval = id (x)
  retval = x;
endfunction

function retval = fnFromName (name)
  % To add a new activation function add the name to the nameFns array
  % and add the function to the fnMap structure.
  nameFns = ['TANH'; 'EXP'; 'ID'];

  fnMap.TANH = @tanh_;
  fnMap.EXP = @exp_;
  fnMap.ID = @id;

  validFn = any(strmatch(name, nameFns, 'exact'));

  if (!validFn)
    error('Invalid activation function');
    return;
  endif

  retval = fnMap.(name);
endfunction
