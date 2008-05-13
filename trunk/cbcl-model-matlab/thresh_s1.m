%-----------------------------------------------
%sharat@mit.edu
%-----------------------------------------------
function out = thresh_s1(s1)
  load s1_thresh;
  for b = 1:length(s1)
    for d=1:size(s1{b},3)
      th   = thresh{d+8}; %discarded 1:8(check s1_gd2D)
      tmp  = (s1{b}(:,:,d));
      stmp = zeros(size(tmp));
      for l=length(th):-1:2
	stmp(tmp<th(l))=l-2;
      end;
      s1{b}(:,:,d)=stmp;
    end;
  end;
  out = s1;
%end function
