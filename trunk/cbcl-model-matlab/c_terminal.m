function cterm  = c_terminal(s)
  [sht,swt,nftr]=size(s{1});
  nbands        =length(s);
  cterm         =zeros(nftr,1);
  for i=1:nftr
    cterm(i)=0;
    for b=1:nbands
      tmp=s{b}(:,:,i);
      cterm(i)=max(cterm(i),max(tmp(:)));
    end;
  end;
%end function
