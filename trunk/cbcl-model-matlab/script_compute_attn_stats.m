function script_compute_s1_stats
    files   = textread('bg.txt','%s','delimiter','\n');
    addpath('~/utils');
    MAXFILES= 1000;
    load('rand_1000','idx');
    files    = files(idx(1:MAXFILES));
    nchannels=   30;
    nscales  =   16;
    N        =   10000;
    for c=1:nchannels
       cnt{c} = zeros(N,1); %
       lcnt{c}= zeros(N,1); %log count
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
	%resize the image
	[ht,wt,dim]      = size(img);
	if(dim~=3)
		error('need an rgb image');
	end;
	%generate attn outputs
      [lst,out,tout]   = get_attn_points(img);
      %process the s1 output
      for c=1:nchannels
		for s=1:nscales
			tmp          = out{c}(:,:,s);
			n            = histc(tmp(:),linspace(0,1,N));
			ln           = histc(log(tmp(:)+eps),linspace(log(eps),log(1),N));
			cnt{c}       = cnt{c}+ n;
			lcnt{c}      = lcnt{c}+ln;
		end;
     end;
     save(sprintf('attn_stats_%06d',i),'cnt','lcnt'); 
   end;
%end function
