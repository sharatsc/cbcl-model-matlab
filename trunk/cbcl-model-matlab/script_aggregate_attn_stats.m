 %---------------------------------------------------------------------------
 %prepare filters
 %---------------------------------------------------------------------------
    clear all;
    close all;
    files = dir('attn_stats*.mat')
    nchannels=   30;
    nscales  =   16;
    N       =   10000;
    %---------------------------------------------------------------------------
    %prepare filters
    %---------------------------------------------------------------------------
    for c=1:nchannels
       cnt{c} = zeros(N,1); %
       lcnt{c}= zeros(N,1); %log count
    end;

    for i = 1:length(files)
      try
	fprintf('Processing: (%d of %d): %s\n',i,length(files),files(i).name);
	tmp               =  load(files(i).name);
	%process the s1 output
	for c=1:nchannels
	  tmp.cnt{c}(1)= 0; %remove count for 0
	  tmp.lcnt{c}(1)=0; %remove 0 count
	  cnt{c}        = cnt{c}+ tmp.cnt{c};
	  lcnt{c}       = lcnt{c}+tmp.lcnt{c};
	end;
      catch
	keyboard;
	continue;
      end;
   end;
      
  for c=1:nchannels
      cnt{c}        = cnt{c}/sum(cnt{c});
      lcnt{c}       = lcnt{c}/sum(lcnt{c});;
  end;
  x = linspace(0,1,N)';
  for c=1:nchannels
     thresh{c} = max_lloyd_quantizer(x,cnt{c},16,0,1);
  end;
%end function

  
