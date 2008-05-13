function ftr=callback_c1_gd2D(img)
    if(size(img,3)==3)
      img = rgb2gray(img);
    end;
    img     = im2double(img);
    %----------------------
    %
    %----------------------
    s1      =   s1_gd2D(img);
    c1      =   c_generic(s1,8,3,2);
    %format the outputs
    ftr{1}       = [];
    ftr{2}       = c1;
    ftr_names{1} = {'empty','C1'};
    ver          = 1;
%end function

