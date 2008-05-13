function s3=callback_s3_baseline(img,c1patches,c2patches)
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
	c2		=	c_generic(s2,8,3,2);
	s3		=	s_generic_tuning(c2,c2patches);
	c3		=	c_generic(s3);
	c3b		=	c_terminal(s3);
    %format the outputs
    ftr{1}       = c1;
    ftr{2}       = c2;
	ftr{3}		 = c3;
	ftr{3}	     = c3b;		
    ftr_names{1} = {'C2b','C1'};
    ver          = 1;
%%end function

%end function
