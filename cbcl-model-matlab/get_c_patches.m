%---------------------------------------------------------
%get_random_patches
%Given a set of training images, the function returns 
%c1 patches of several sizes (specified by opt_func below). 
%These patches are used as prototype features in computing 
%the S2b and C2b layers in the model. 
%sharat@mit.edu
%---------------------------------------------------------
function patches = get_c_patches(image_set,bands,CALLBACK,varargin)
DEBUG      = 0;
%-------------------------------------------
%establish funciton to call
%-------------------------------------------
if(isempty(CALLBACK))
  CALLBACK  = 'callback_c1_baseline';
end;
num_images      = length(image_set);
if(isempty(bands))
  bands           = [1:3];
end;
patches_per_img = 3;
patch_sizes     = [4:2:12];
num_sizes       = length(patch_sizes);
%-------------------------------------------
%get filters
%--------------------------------------------
patch_idx = 1;
for i = 1:num_images
  fprintf('Processing %d of %d\n',i,num_images);
  img       = image_set{i};
  %----------------------------
  %extract s1 and c1
  %----------------------------
  [iht,iwt,tt]=size(img);
  if(iht<32|iwt<32) continue;end;
  ftr      = feval(CALLBACK,img,varargin{:});
  c1_org   = ftr{2};
  for pnum = 1:patches_per_img
    %----------------------------
    %select random size and band
    %---------------------------
    trial= 0;
    while(trial<500)
	trial =trial+1;
      idx = floor(rand*num_sizes)+1;
      sz  = patch_sizes(idx);
      idx = floor(rand*length(bands))+1;
      bnd = bands(idx);
      c1  = c1_org{bnd};
      [ht,wt,ndir] = size(c1);
      if(ht < sz | wt < sz)
	 fprintf('X');
	 continue;
      end;
	%------------------------------------
    	%select random patches for each size
    	%-----------------------------------
    	x                  = floor(rand*(wt-sz))+1;
    	y                  = floor(rand*(ht-sz))+1;
    	tmp                = c1(y:y+sz-1,x:x+sz-1,:);
		pnorm			   = norm(tmp(:))/sz;
		fprintf('pnorm:%f\n',pnorm);
    	if(pnorm<0.25)
	 fprintf('*');
	 continue;
	else
	 break;
    	end;
    end;
    fprintf('.');
    if(DEBUG)
	for m=1:size(tmp,3)
		subplot(4,ceil(size(tmp,3)/4),m);
		imagesc(tmp(:,:,m));axis off;
	end;
	pause;
    end;
    patches{patch_idx}       = tmp;
    patch_idx                = patch_idx+1;
  end
end;
