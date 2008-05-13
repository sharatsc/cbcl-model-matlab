function ftr=callback_c2_gd2D(img,c1patches,varargin)
    if(size(img,3)==3)
      img = rgb2gray(img);
    end;
    img     = im2double(img);
    %----------------------
    %
    %----------------------
    s1      =   s1_gd2D(img);
    c1      =   c_generic(s1,8,3,2);
    s2      =   s_generic_tuning(c1,c1patches);
    c2      =   c_generic(s2,8,3,2);
    c2b     =   c_terminal(s2);
    %format the outputs
    ftr{1}       = c1;
    ftr{2}       = c2;
    ftr{3}       = c2b;
    ftr_names{1} = {'c1','c2','c2b'};
    ver          = 1;
%end function

