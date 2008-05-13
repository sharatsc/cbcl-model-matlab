function s3=callback_s3_baseline(img,c1patches,c2patches)
    if(size(img,3)==3)
      img = rgb2gray(img);
    end;
    img     = im2double(img);
    opts    = default_options;
    filters = init_gabor(opts);
    if(nargin<2)
      load    patches_hmax; 
    end;
    %img     = normalize_image(img);
    %----------------------
    %
    %----------------------
    s1      =   s1_baseline(img,filters,opts);
    c1      =   c1_baseline(s1,opts);
%end function

%end function
