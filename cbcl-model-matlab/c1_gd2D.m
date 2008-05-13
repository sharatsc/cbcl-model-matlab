function out  = c1_gd2D(s1,POOL,STEP,SCALEPOOL)
  if(nargin<2)
	POOL        = 5;
  end;
  if(nargin<3)
	STEP        = 3;
  end;
  if(nargin<4)
	SCALEPOOL   = 2;
  end;
  BANDS       = floor(length(s1)/SCALEPOOL);
  %---------------------------
  %max in space
  %--------------------------
  scale = 0;
  for s =1:length(s1)
      s1{s} = imdilate(s1{s},ones(POOL));
  end;
  %---------------------------
  %max in bands
  %--------------------------
  b         = 1;
  for start = 1:SCALEPOOL:length(s1)-SCALEPOOL+1
    [ht,wt,d]     = size(s1{start});
    out{b}        = zeros(ht,wt,d);
    for off  = 0:SCALEPOOL-1
      out{b}=max(out{b},imresize(s1{start+off},[ht wt]));
    end;	
    b             = b+1;
  end;
  for b = 1:BANDS
    out{b}= out{b}(1:STEP:end,1:STEP:end,:);
  end;
%end function
