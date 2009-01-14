function cterm  = c_terminal(s,domin)
  if(nargin<2)
	domin=0;
  end;
  [sht,swt,nftr]=size(s{1});
  nbands        =length(s);
  if(domin)
	cterm         = inf(nftr,1);
  else
	cterm         = zeros(nftr,1);
  end;
  for i=1:nftr
    for b=1:nbands
      tmp=s{b}(:,:,i);
	  if(domin)
		cterm(i)=min(cterm(i),min(tmp(:)));
	  else
		cterm(i)=max(cterm(i),max(tmp(:)));
	  end;
    end;
  end;
%end function
