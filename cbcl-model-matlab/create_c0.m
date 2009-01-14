function c0=create_c0(img,scale,levels)
  if(isrgb(img))
    img=rgb2gray(img);
  end;
  if(~isfloat(img))
  	img = im2double(img);
  end;
  if(nargin<2)
    scale = 2^(1/4);%1.113;
    levels= 11;
  end;
  [ht,wt] =size(img);
  %preserve range
  pmin   = min(img(:));
  pmax   = max(img(:));
  prange = pmax-pmin+eps;
  for i=0:levels-1
    out     =imresize(img,round([ht,wt]*(scale^-i)),'bicubic');
    %new range
    nmax    =max(out(:));
    nmin    =min(out(:));
    nrange  =nmax-nmin+eps;
    out     =(out-nmin)/nrange*prange+pmin;
    c0{i+1} =out;
  end;
%end function
