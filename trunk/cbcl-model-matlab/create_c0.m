function c0=create_c0(img,scale,levels)
  img = imfilter(img,fspecial('gaussian'),'same');
  if(isrgb(img))
    img=rgb2gray(img);
  end;
  if(nargin<2)
    scale = 1.1;
    levels= 16;
  end;
  for i=0:levels-1
    c0{i+1}=imresize(img,scale^-i,'bicubic');
    %c0{i+1}=normalize_pinto(c0{i+1});
  end;
%end function
