%-----------------------------------------------------------
%
%sharat@mit.edu
%-----------------------------------------------------------
function xout=threshold_feature_maps(tout)
	DEBUG = 0;
	load attn_thresh;
	%thresh=thresh([1 2 11 12 21 22]);
	SCALES=logspace(log10(0.5),log10(4),16)*10;
	nscales=length(tout);
	nftr   =size(tout{1},3);
	for s=1:nscales
	  fprintf('.');
	  xout{s}=tout{s};
	  for i = 1:nftr
	     xout{s}(:,:,i) = threshold_image(tout{s}(:,:,i),thresh{i});
	     tmp            = lri_zscore(xout{s}(:,:,i));
	     if(DEBUG)
		subplot(1,2,1);imagesc(xout{s}(:,:,i));colorbar;
		subplot(1,2,2);imagesc(tmp);axis image;colorbar;
		pause;
	      end;
          end;
	end;
%end function

function out = lri_cs(img)
   tmp	=img.^2;
   [t,gd]   =gd2D(tmp,2,2,5);
   [pos,neg]=pos_neg(gd{1,3}+gd{3,1});
   out      =neg;
%end function

function out = lri_zscore(img)
   tmp	=img;
   m        =mean(tmp(:)).^2;
   sd       =max(std(tmp(:)),0.05);
   tmp      =(tmp-m)/(sd);
   out      =max(0,tmp-2);
%end function

function out = lri_mean(img)
   tmp	=img.^2;
   m        =mean(tmp(:));
   out      =tmp./(m+1);
%end function

function out = lri_gaussian(img)
   tmp	=img.^2;
   m        =mean(tmp(:));
   out      =tmp./(m+1);
%end function

