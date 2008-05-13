function out  = c_generic(s,POOL,STEP,SCALEPOOL)
  if(nargin<2)
	POOL        = 5;
  end;
  if(nargin<3)
	STEP        = 3;
  end;
  if(nargin<4)
	SCALEPOOL   = 2;
  end;
  BANDS       = floor(length(s)/SCALEPOOL);
  %---------------------------
  %max in space
  %--------------------------
  scale = 0;
  for sidx =1:length(s)
      s{sidx} = imdilate(s{sidx},ones(POOL));
  end;
  %---------------------------
  %max in bands
  %--------------------------
  b         = 1;
  for start = 1:SCALEPOOL:length(s)-SCALEPOOL+1
    [ht,wt,d]     = size(s{start});
    out{b}        = zeros(ht,wt,d);
    for off  = 0:SCALEPOOL-1
      out{b}=max(out{b},imresize(s{start+off},[ht wt]));
    end;	
    b             = b+1;
  end;
  for b = 1:BANDS
    out{b}= out{b}(1:STEP:end,1:STEP:end,:);
  end;
%end function
