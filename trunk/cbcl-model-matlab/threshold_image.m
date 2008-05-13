function out = threshold_image(img,th)
	tmp  = img;
	out  = zeros(size(tmp));
      for l=length(th):-1:2
	  out(tmp<th(l))=l-2;
      end;
%end function