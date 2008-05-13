function ftr=callback_c2b_baseline(img,c0patches,c1patches,varargin)
    if(size(img,3)==3)
      img = rgb2gray(img);
    end;
    img     = im2double(img);
    %----------------------
    %
    %----------------------
    c0      =   create_c0(img);
    s1      =   s_generic_norm_filter(c0,c0patches);
    c1      =   c_generic(s1,8,3,2);
    s2      =   s_generic_tuning(c1,c1patches);
    c2b     =   c_terminal(s2);
    %format the outputs
    ftr{1}       = c2b;
    ftr{2}       = c1;
    ftr_names{1} = {'C2b','C1'};
    ver          = 1;
%end function

