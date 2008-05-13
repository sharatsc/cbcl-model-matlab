function out = cs_normalize(img)
	h  = sum(fspecial('gaussian',9,1));
	h  = gradient(gradient(h));
	[pos,neg]= pos_neg(conv2(h,h,img,'same'));
	out      = neg;
%end function;