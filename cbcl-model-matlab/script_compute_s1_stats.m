function script_compute_s1_stats
    files   = textread('bg.txt','%s','delimiter','\n');
    addpath('~/utils');
    MAXFILES= 1000;
    load('rand_1000','idx');
    files   = files(idx(1:MAXFILES));
    nbands  =   16;
    ndir    =   26;
    N       =   10000;
    for l=1:ndir
       cnt{l} = zeros(N,1); %
       lcnt{l}= zeros(N,1); %log count
    end;
    %---------------------------------------------------------------------------
    %prepare filters
    %---------------------------------------------------------------------------
    for i = 1:length(files)
      lock_file = sprintf('lock_%06d.lock',i);
      fprintf('Processing: (%d of %d): %s\n',i,length(files),files{i});
      if(exist(lock_file))
	continue;
      end;
      save(lock_file,'lock_file');
      img            = imread(files{i});
	if(size(img,3)==3)
		%img          = rgb2gray(img);
      end;
	%resize the image
	[ht,wt,dim]      = size(img);
	if(dim~=3)
		error('need an rgb image');
	end;
	%resize width to 12 degrees
	if(ht>wt)
		nht              = pixel_per_degree*visual_field_size;
		nwt              = ceil(nht/ht*wt);
	else
		nwt              = pixel_per_degree*visual_field_size;
		nht              = ceil(nwt/wt*ht);
	end;	
      img            = img_scale(log(max(1,double(img))));
	img            = rgb2e(img);
      s1             = s1_gd2D(img(:,:,1));
      %process the s1 output
      for d=1:ndir
	for b = 1:nbands
          s1_tmp       = s1{b}(:,:,d);
	    n            = histc(s1_tmp(:),linspace(0,1,N));
	    ln           = histc(log(s1_tmp(:)+eps),linspace(log(eps),log(1),N));
	    cnt{d}       = cnt{d}+ n;
	    lcnt{d}      = lcnt{d}+ln;
	end;
     end;
     save(sprintf('s1_a_stats_%06d',i),'cnt','lcnt'); 
   end;
%end function
