function out = laplacian_filter(ss)
scales = size(ss,3);
filt   = fspecial('laplacian');
out    = zeros(size(ss,1)-size(filt,1)+1,size(ss,2)-size(filt,2)+1,length(scales));
  for i = 1:scales
    out(:,:,i) = conv2(ss(:,:,i),filt,'valid');
  end;
%end function
