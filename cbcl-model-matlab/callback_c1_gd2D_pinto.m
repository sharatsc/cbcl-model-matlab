%function 
function [ftr,ftr_names,ver] = callback_c1_gd2D_pinto(img,SCALES,THRESHOLD)
    if(nargin~=2)
      SCALES=[]; %use default
    end;
    if(nargin<3)
      THRESHOLD=0;
    end;
    img     =  normalize_pinto(img);
    %----------------------
    %resize and compute c1
    %----------------------
    s1      =   s1_gd2D_abs(img,SCALES);
    c1      =   c1_gd2D(s1);
    c1ftr   =   [];
    for b   = 1:length(c1)
      %c1ftr = [c1ftr;c1{b}(:)];
    end;
    %format the outputs
    ftr{1}       = c1ftr(:);
    ftr{2}       = c1;
    ftr_names    = {'C1vec','C1'};
    ver          = 1;
%end function
