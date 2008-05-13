function [ftr,ftr_name,ver]=callback_c3_baseline(img,c0patches,c1patches,c2patches)
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
    c2      =   c_generic(s2,8,3,2);
    s3      =   s_generic_tuning(c2,c2patches);
    %s3      =   s_generic_norm_filter(c2,c2patches);
    c3      =   c_terminal(s3);
    %format the outputs
    ftr{1}       = c3(:);
    ftr_names{1} = 'C3';
    ver          = 1;
%end function

