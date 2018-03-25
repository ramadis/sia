% Clean up input script
function retval = cleanup (input)
  data = loadjson(char(['../' input])).data;
  %data = standardize(data);
  retval = data;  
endfunction
