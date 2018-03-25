function retval= standardize(data)
  max=data(1,1);
  min=max;
  nbSamples=0;

  for idxSample=1:rows(data)
    for i=1:2
      if data(idxSample,i)>max
        max=data(idxSample,i);
      endif
      if data(idxSample,i)<min
        min=data(idxSample,i);
      endif
    end

  end

  for idxSample=1:rows(data)
      for i=1:2
        data(idxSample,i)=(max-data(idxSample,i))/(max-min);
        data(idxSample,i)=data(idxSample,i)*2 -1;
      end
  end

  retval=data;
endfunction
