function [out] = scalespace(img,scales)
    if(size(img,3)~=1)
        img = rgb2gray(img);
    end;
    img     = double(img);
    if(nargin<2)
        scales = sqrt(2).^[1:16];
    end;
    out   = zeros(size(img,1),size(img,2),length(scales)); 
    for i = 1:length(scales)
      out(:,:,i) = gauss_filter(img,scales(i));
    end;
%end function
