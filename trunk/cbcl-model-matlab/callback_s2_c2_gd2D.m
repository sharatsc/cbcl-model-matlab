%--------------------------------------------------------
%c2_baseline
%sharat@mit.edu
%--------------------------------------------------------
function ftr = callback_s2_c2_gd2D(img,patches,scales)
 if(nargin<3)
	scales = [];
 end;
 num_patches = length(patches);
 if(iscell(img))%allow use of c1 directly
	c1     = img;
 else
 	ftr         = callback_c1_gd2D(img,scales);
 	c1          = ftr{2};
 end;
 c2          = [];
 s2          = cell(length(c1),1);
 for i =1:length(c1)
	tmp      = c1{i}(:,:,1);
	[ht,wt,d]=size(tmp);
	s2{i}    = zeros(ht,wt,num_patches);
 end;
 for i = 1:num_patches
  fprintf('.')
  [tmpc2,tmps2] = patch_response(c1,patches(i));
  for b=1:length(s2)
	s2{b}(:,:,i)= tmps2{b}; 
  end;
  c2  = [c2;tmpc2];
  ftr = {c1,s2,c2};
 end;
fprintf('\n')
