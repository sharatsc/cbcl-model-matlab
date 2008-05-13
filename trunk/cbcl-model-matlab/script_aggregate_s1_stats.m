 %---------------------------------------------------------------------------
 %prepare filters
 %---------------------------------------------------------------------------
    nbands  =   16;
    ndir    =   26;
    N       =   10000;
    if(0)
    clear all;
    close all;
    files = dir('s1_stats*.mat');
    for l=1:ndir
       cnt{l} = zeros(N,1); %
       lcnt{l}= zeros(N,1); %log count
    end;
    %---------------------------------------------------------------------------
    %prepare filters
    %---------------------------------------------------------------------------
    for i = 1:length(files)
      try
	fprintf('Processing: (%d of %d): %s\n',i,length(files),files(i).name);
	tmp               =  load(files(i).name);
	%process the s1 output
	for d=1:ndir
	  tmp.cnt{d}(1)= 0; %remove count for 0
	  tmp.lcnt{d}(1)=0; %remove 0 count
	  cnt{d}        = cnt{d}+ tmp.cnt{d};
	  lcnt{d}       = lcnt{d}+tmp.lcnt{d};
	end;
      catch
	continue;
      end;
    end;
      
  end;
   load s1_cnt;
   for d=1:ndir
      cnt{d}        = cnt{d}/sum(cnt{d});
      lcnt{d}       = lcnt{d}/sum(lcnt{d});;
   end;
   x = linspace(log(eps),log(1),N)';
   x = linspace(0,1,N)';
   for d = 1:ndir
     thresh{d} = max_lloyd_quantizer(x,cnt{d},16,0,1);%log(eps),log(1));
   end;
%end function

  
