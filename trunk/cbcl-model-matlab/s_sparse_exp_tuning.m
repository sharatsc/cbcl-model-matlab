%---------------------------------------------------------
%
%
%sharat@mit.edu
%---------------------------------------------------------
function [s] = s_sparse_exp_tuning(c,patches,sidx)
DEBUG            = 0;
num_bands        = length(c);
s                = cell(num_bands,1);
for b = 1:num_bands
  c_tmp          = c{b};
  [cht,cwt,cdir] = size(c_tmp);
  s{b}           = zeros(cht,cwt,length(patches));
  for p = 1:length(patches)
    patch                = patches{p};
    [pht,pwt,pdir]       = size(patch);
	pmsk                 = zeros(size(patch));
	pmsk(find(patch))    = 1;
    patch                = patch.*pmsk;
    ptch2                = sum(patch(:).^2);
	if(nargin<3)
		sigma  			 = 3;%sqrt(ptch2)/3;
	else
	    sigma            = sidx(p);
	end;
    res_tmp              = zeros(cht,cwt)+ptch2;
    for d     = 1:pdir
      img      = c_tmp(:,:,d);
      tmp      = conv2(img,patch(end:-1:1,end:-1:1,d),'same');
	  img2 = conv2(img.^2,pmsk(end:-1:1,end:-1:1,d),'same');
      res_tmp  = res_tmp+img2-2*tmp;
    end;
    res_tmp    = exp(-res_tmp/(2*sigma*sigma));
	if(nargin==3)
		s{b}(:,:,p)=res_tmp/sigma;
	else
		s{b}(:,:,p)=res_tmp;
	end;

  end;
end;
%imagesc(tmp);pause(1);

