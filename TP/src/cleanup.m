% Clean up input script
function retval = cleanup (input)
  retval = loadjson(char(['../' input])).data;
endfunction
