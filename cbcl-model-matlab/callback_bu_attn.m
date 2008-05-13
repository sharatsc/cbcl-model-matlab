%---------------------------------------------------------------
%
%
%---------------------------------------------------------------
function [ftr] = callback_bu_attn(img)
	%config
	DEBUG		     = 0;
	sigma_range      = [20.500000 27.298770 34.352753 41.743492 55.578583 76.000000 97.195079 125.411011]/2;
	%normalize image size
	[ht,wt,dim]      = size(img);
	if(dim~=1)
		error('need an gray-scale image');
	end;
	%normalize intensity
		img              = im2double(img);
      out		     = lgn_s1(img_scale(img),sigma_range);
	%-----------------------------
	%organize by scale
	%out is organized by channels
	%------------------------------
	nscales  = length(sigma_range);
	tout     = cell(nscales,1);
	for s=1:nscales
            dx       = ceil(sigma_range(s)/2);
		[ht,wt,d]=size(out(1:dx:end,1:dx:end,s));
		tout{s}  =zeros(ht,wt);
  	  	tout{s}  =out(1:dx:end,1:dx:end,s);
	end;
	ftr={tout,out};
%end function

%-----------------------------------------------------------
%
%-----------------------------------------------------------
function [out] = lgn_s1(img,SCALES)
    	for s   = 1:length(SCALES)
      	fprintf('scale:%f\n',SCALES(s));
		[tmp,gd]          = gd2D(img,2,2,SCALES(s));
		[pos,neg]   	= pos_neg(0.5*(gd{1,3}+gd{3,1}));
		out(:,:,s)		= abs(pos-neg).^2;
	end;
%end function