%---------------------------------------------------------------
%
%
%---------------------------------------------------------------
function [out,tout] = feature_pyramid(img)
	%config
	DEBUG		     = 0;
	pixel_per_degree = 20;
	visual_field_size= 16; %degrees
	sigma_range      = logspace(log10(0.125),log10(4),32)*20;;
	%normalize image size
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
	img              = imresize(img,[nht nwt]);
	%normalize intensity
	img              = im2double(img);
	%convert to gaussian scale space
	img              = rgb2e(img);
	if(DEBUG)
	  for i = 1:3
	 	figure(1);subplot(1,3,i);imagesc(img_scale(img(:,:,i)));axis image;
	  end;
	end;
	out              = [];
	for i = 1:3
	  fprintf('Color channel %d of %d\n',i,3);
	  tmp	        = lgn_s1(img_scale(img(:,:,i)),sigma_range);
	  out         	= cat(1,out,tmp);
	end;
	%-----------------------------
	%organize by scale
	%out is organized by channels
	%------------------------------
	nchannels= length(out);
	nscales  = length(sigma_range);
	tout     = cell(nscales,1);
	for s=1:nscales
            dx       = ceil(sigma_range(s)/2);
		[ht,wt,d]=size(out{1}(1:dx:end,1:dx:end,s));
		tout{s}  =zeros(ht,wt,nchannels);
		for c=1:nchannels
		  %subsample
		  if(dx~=1)
	  	  	tout{s}(:,:,c)=out{c}(1:dx:end,1:dx:end,s);
			out{c}	  =out{c}(1:dx:end,1:dx:end,s);
		  else
			tout{s}(:,:,c)=out{c}(:,:,s);
        	  end;
		end;
	end;
%end function

%-----------------------------------------------------------
%
%-----------------------------------------------------------
function [out] = lgn_s1(img,SCALES)
	%initialize
	num_ftr = 5;
	out     = cell(num_ftr,1);
	%second order differential structure
    	for s   = 1:length(SCALES)
      	fprintf('scale:%f\n',SCALES(s));
		[tmp,gd] = gd2D(img,2,2,SCALES(s));
		%----------------------------------
		%laplacian
		%----------------------------------
		[pos,neg]   	= pos_neg(0.5*(gd{1,3}+gd{3,1}));
		%out{1}(:,:,s)	= abs(pos-neg);
		out{1}(:,:,s)	= pos;
		out{2}(:,:,s)	= neg;
		%----------------------------------
		%get 2nd order edges
		%----------------------------------
		[pos,neg]    	= pos_neg(gd{1,3});
		%out{2}(:,:,s)	= abs(pos-neg);
		%out{3}(:,:,s)	= pos;
		%out{4}(:,:,s)	= neg;

		[pos,neg]    	= pos_neg(gd{3,1});
		out{3}(:,:,s)	= abs(pos-neg);
		%out{5}(:,:,s)	= pos;
		%out{6}(:,:,s)	= neg;

		[pos,neg]    	= pos_neg(gd{1,3}*cos(pi/4).^2+cos(pi/4).^2*gd{3,1}+2*cos(pi/4)*sin(pi/4)*gd{2,2});
		out{4}(:,:,s)	= abs(pos-neg);
		%out{7}(:,:,s)	= pos;
		%out{8}(:,:,s)	= neg;

		[pos,neg]    	= pos_neg(gd{1,3}*cos(-pi/4).^2+cos(-pi/4).^2*gd{3,1}+2*cos(-pi/4)*sin(-pi/4)*gd{2,2});
		out{5}(:,:,s)	= abs(pos-neg);		
		%out{9}(:,:,s)	= pos;
		%out{10}(:,:,s)	= neg;
	end;
%end function
