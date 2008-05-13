%---------------------------------------------------------
%
%
%sharat@mit.edu
%---------------------------------------------------------
function [snext,cnext] = s_generic(c,patch)
DEBUG            = 0;
num_bands        = length(c);
[cht,cwt,num_dir]= size(c1{1});
c2               = 0;
[pht,pwt]        = size(patch(:,:,1));
ptch2            = sum(patch(:).^2);
sigma            = sqrt(ptch2+eps)/3;
s2               = zeros(cht,cwt);
for b = 1:num_bands
  c1_tmp    = c1{b};%imresize(c1{b},[cht cwt],'bilinear');
  img2      = conv2(ones(pht,1),ones(pwt,1),sum(c1_tmp.^2,3),'same');
  res_tmp   = img2+ptch2;
  for d     = 1:num_dir
     img      = c1_tmp(:,:,d);
     tmp      = conv2(img,patch(end:-1:1,end:-1:1,d),'same');
     res_tmp  = res_tmp-2*tmp;
  end;
  if(DEBUG)
    imagesc(res_tmp); pause;
  end;
  res_tmp   = exp(-res_tmp/(2*sigma*sigma));
  s2        = max(s2,imresize(res_tmp,[cht cwt],'bilinear'));
end;
%pad the rest
%s2   = padarray(s2,[floor(pht/2) floor(pwt/2)],'pre');
%s2   = padarray(s2,[cht-size(s2,1),cwt-size(s2,2)],'post');
%imagesc(tmp);pause(1);
c2          = max(max(s2)); 
c2          = c2(1); 
