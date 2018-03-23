% Clean up input script
function retval = cleanup (input)
  data = loadjson(char(['../' input])).data;
  retval = data;
endfunction
