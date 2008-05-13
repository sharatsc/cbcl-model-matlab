%---------------------------------------------------------------
%
%
%sharat@mit.edu
%---------------------------------------------------------------
function g= complex_image_gradient(img,sigma)
    img     = im2double(img);
    if(nargin>1)
      img     = gauss_filter(img,sigma);
    end;
    [px,py] = gradient(img);
    g       = complex(px,py);
%end function
