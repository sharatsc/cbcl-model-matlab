%-----------------------------------------------------------------------
%
%sharat@mit.edu
%-----------------------------------------------------------------------
function DL=find_fixation_points(map,scales,min_val,max_points)
   global DEBUG;
   %locate the maximum
   maxval  = 0;
   num     = 1;
   if(nargin<3)
   	min_val = 0.1;
   end;
   if(nargin<4)
     max_points = 10;
   end;
   DL      = [];
   %---------------------------
   %determine masking radius
   %---------------------------	
   SIGMA   = [3 3];

   while(num<=max_points) %max objects
     if(num<0)
       ret_val   =eps;
       ret_pos   =[0.5,0.5];
       ret_scale =1;
     else
       %---------------------------
       %find maximum
       %---------------------------
       ret_val   =-inf;
       ret_pos   =[0,0];
       ret_scale =0;
       for m   = 1:length(map)
	 tmap       = map{m};
 	 [y,x]      = find(tmap==max(max(tmap)),1);
	 if(tmap(y,x)>ret_val)
	   ret_val   = tmap(y,x);
	   ret_pos   = [y/size(map{m},1),x/size(map{m},2)];%relative position
	   ret_scale = m;
	 end;
       end;
     end;
     if(num==1 | num==2)
	 maxval=ret_val;
     end;
     if(ret_val<min_val*maxval)
       return;
     end;
     ret_pos          = ret_pos(2:-1:1);  %xy switcheroo
     DL(num).pos      = ret_pos;
     DL(num).val      = ret_val;
     DL(num).s        = scales(ret_scale); %relative scale
     DL(num).sidx     = ret_scale;
     %---------------------------------
     %supression
     %---------------------------------
     if(DEBUG)
       for m=1:length(map)
	 subplot(4,ceil(length(map)/4),m);imagesc(map{m});colorbar;
       end;
       pause;
     end;
     for m       = 1:length(map)
	  [ht,wt]   = size(map{m});
	  [cpos]    = ret_pos.*[wt,ht];        %center
	  [X,Y]     = meshgrid(1:wt,1:ht);      
	  sigma     = SIGMA;
	  gmap      = exp(-(X-cpos(1)).^2/(2*sigma(1)^2)-(Y-cpos(2)).^2/(2*sigma(2)^2));
	  decay     = exp(-(m-ret_scale)^2/(2*8^2));
	  map{m}    = map{m}.*(1-decay*gmap);
     end;
     num = num+1;
   end;
   %[t,idx] = sort([DL.val],'descend');
   %DL      = DL(idx);
%end function
