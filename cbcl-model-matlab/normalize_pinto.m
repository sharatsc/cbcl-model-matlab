function out = normalize_pinto(img)
    img     =  imfilter(img,fspecial('gaussian',7,0.5),'same');
    if(size(img,3)==3)
      img   = rgb2gray(img);
    end;
    if(~isfloat(img))
     img    =  im2double(img);%
    end;
    %zero mean unit variance
    img     =  padarray(img,1,'both','replicate');
    %high pass
    img     =  imfilter(img,-[1 1 1;1 -8 1;1 1 1]/9,'same');
    %local normalization
    img2    =  sqrt(conv2(ones(3,1),ones(3,1),img.^2,'same'));
    %strip the borders
    out     =  img./min(img2+0.1,1);
    out     =  out(2:end-1,2:end-1);
%end function
