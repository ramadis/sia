function retval = momentum (params)
  retval = 1;
endfunction

function retval = etaimproved (params)
  retval = 2
endfunction

function retval = fnFromName (name)
  validFn = any(nameFns == name);

  if (!validFn)
    error('Invalid optimization method');
    return;
  endif

  retval = fnMap.(name);
endfunction

% To add a new optimization function add the name to the nameFns array
% and add the function to the fnMap structure.
nameFns = ['ETA MEJORADO'; 'MOMENTUM'];
fnMap.ETA = etaimproved;
fnMap.MOMENTUM = momentum;

optimization.fromName = fnFromName;
