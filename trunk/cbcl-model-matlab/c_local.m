function out  = c_generic(s,POOL,STEP,SCALEPOOL,SCALESTEP)
  if(nargin<2)
	POOL        = 9;
  end;
  if(nargin<3)
	STEP        = 5;
  end;
  if(nargin<4)
	SCALEPOOL   = 2;
  end;
  if(nargin<5)
    SCALESTEP   = SCALEPOOL;
  end;
  BANDS       = length(1:SCALESTEP:length(s)-SCALEPOOL+1)
  %---------------------------
  %max in bands
  %--------------------------
  b         = 1;
  for start = 1:SCALESTEP:length(s)-SCALEPOOL+1
    [ht,wt,d]     = size(s{start});
    out{b}        = zeros(ht,wt,d);
    for off  = 0:SCALEPOOL-1
      stmp   = imresize(single(s{start+off}),[ht wt]);
      out{b} = max(out{b},imdilate(single(stmp),ones(POOL),'same'));
    end;	
    b             = b+1;
  end;
  for b = 1:BANDS
    out{b}= out{b}(floor(POOL/2)+1:STEP:end-ceil(POOL/2)+1,floor(POOL/2)+1:STEP:end-ceil(POOL/2)+1,:);
  end;
%end function

