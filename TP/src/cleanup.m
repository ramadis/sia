% Clean up input script
function retval = cleanup (input)
  data = loadjson(char(['../' input])).data;
  retval = standarization.standarize(data);
endfunction
