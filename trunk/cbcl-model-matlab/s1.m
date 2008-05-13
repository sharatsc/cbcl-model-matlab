function out = s1(img)
  %----------------------------------
  %-----------------------------------
  [ht,wt]= size(img);
  SCALES = logspace(log10(0.125),log10(0.25),6)*10;
  OCTAVES= 3;
  if(isrgb(img))
    img = rgb2gray(img);
  end;
  [orght,orgwt]=size(img);
  scale = 0;
  for o = 1:OCTAVES
    for s = 1:length(SCALES)
      fprintf('scale:%f\n',SCALES(s));
      if(o~=OCTAVES & s==length(SCALES))
	continue;
      end;
      [tmp,gd] = gd2D(img,2,2,s);
      scale    = scale+1;
      tmps1    = zeros(size(img,1),size(img,2),30);
      %----------------------------------
      %get 1st order edges
      %----------------------------------
      [pos,neg]   = pos_neg(gd{1,2});
      tmps1(:,:,1)= pos;tmps1(:,:,2)= neg;
      [pos,neg]   = pos_neg(gd{2,1});
      tmps1(:,:,3)= pos;tmps1(:,:,4)= neg;
      [pos,neg]   = pos_neg(gd{1,2}*cos(pi/4)+sin(pi/4)*gd{2,1});
      tmps1(:,:,5)= pos;tmps1(:,:,6)= neg;
      [pos,neg]   = pos_neg(gd{1,2}*cos(-pi/4)+sin(-pi/4)*gd{2,1});
      tmps1(:,:,7)= pos;tmps1(:,:,8)= neg;
      %----------------------------------
      %get 2nd order edges
      %----------------------------------
      [pos,neg]    = pos_neg(gd{1,3});
      tmps1(:,:,9) = pos;tmps1(:,:,10)= neg;
      [pos,neg]    = pos_neg(gd{3,1});
      tmps1(:,:,11)= pos;tmps1(:,:,12)= neg;
      [pos,neg]    = pos_neg(gd{1,3}*cos(pi/4).^2+cos(pi/4).^2*gd{3,1}+2*cos(pi/4)*sin(pi/4)*gd{2,2});
      tmps1(:,:,13)= pos;tmps1(:,:,14)= neg;
      [pos,neg]    = pos_neg(gd{1,3}*cos(-pi/4).^2+cos(-pi/4).^2*gd{3,1}+2*cos(-pi/4)*sin(-pi/4)*gd{2,2});
      tmps1(:,:,15)= pos;tmps1(:,:,16)= neg;
      %----------------------------------
      %laplacian
      %----------------------------------
      [pos,neg]   = pos_neg(gd{1,3}+gd{3,1});
      tmps1(:,:,17)= pos;tmps1(:,:,18)= neg;
      %----------------------------------
      %corner detection
      %----------------------------------
      [pos,neg]     = pos_neg(2*gd{1,2}.*gd{2,1}.*gd{2,2}-gd{1,3}.*gd{2,1}.^2-gd{3,1}.*gd{1,2}.^2);
      tmps1(:,:,19) = pos.^(1/3);tmps1(:,:,20)=neg.^(1/3);
      %----------------------------------
      %ridges
      %----------------------------------
      [pos,neg]    = pos_neg(-(2*gd{1,2}.*gd{2,1}.*gd{2,2}-gd{1,3}.*gd{2,1}.^2-gd{3,1}.*gd{1,2}.^2)./(gd{1,2}.^2+gd{2,1}.^2+eps));
      tmps1(:,:,21) = pos;tmps1(:,:,22)=neg;
      %----------------------------------
      %isophote curvature
      %---------------------------------- 
      [pos,neg]    = pos_neg(-(2*gd{1,2}.*gd{2,1}.*gd{2,2}-gd{1,3}.*gd{2,1}.^2-gd{3,1}.*gd{1,2}.^2)./sqrt(gd{1,2}.^2+gd{2,1}.^2+.1).^3);
      tmps1(:,:,23) = pos.^(2/3); 1./(1+exp(-pos));tmps1(:,:,24)=neg.^(2/3);
      %----------------------------------
      %gaussian curvature
      %---------------------------------- 
      [pos,neg]    = pos_neg(gd{1,3}.*gd{3,1}-gd{2,2}.^2);
      tmps1(:,:,25) = sqrt(pos);tmps1(:,:,26)=sqrt(neg);
	if(1)
      %---------------------------------
      %hyperbolic grating
      %---------------------------------
      g            = complex(gd{1,2},gd{2,1});
      s            = symmetry_derivative(-2,1);
      [i20,i11]    = complex_response(g,s);
      tmps1(:,:,27)= abs(i20);
      %----------------------------------
      %Y junction
      %---------------------------------
      s            = symmetry_derivative(1,1);
      [i20,i11]    = complex_response(g,s);
      tmps1(:,:,28)  = abs(i20);
      %----------------------------------
      %+ junction
      %---------------------------------
      s            = symmetry_derivative(2,1);
      [i20,i11]    = complex_response(g,s);
      tmps1(:,:,29)  = abs(i20);
      %----------------------------------
      %low pass
      %---------------------------------
      tmps1(:,:,30)  = gd{1,1};
	end;
      out{scale}     = imresize(tmps1,[orght orgwt],'bilinear');
    end;
    img = 2*imfilter(img,fspecial('gauss',9,1.5));%
    img = gd{1,1}(1:2:end,1:2:end);
  end;
%end function
