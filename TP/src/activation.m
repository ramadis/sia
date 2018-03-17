function retval = tanh (x)
  retval = @tanh(x);
endfunction

function retval = exp (x)
  retval = @exp(x);
endfunction

function retval = id (x)
  retval = x
endfunction

function retval = fnFromName (name)
  validFn = any(nameFns == name);

  if (!validFn)
    error('Invalid activation function');
    return;
  endif

  retval = fnMap.(name);
endfunction

% To add a new activation function add the name to the nameFns array
% and add the function to the fnMap structure.
nameFns = ['TANH'; 'EXP', 'ID'];
fnMap.TANH = tanh;
fnMap.EXP = exp;
fnMap.ID = id;

activation.fromName = fnFromName;
