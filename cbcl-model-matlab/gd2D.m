%-----------------------------------------
%sharat@mit.edu
%usage
%[out,gd] = gd2D(img,m,n,sx,sy)
% img - 2D image
% m   - order in the x direction
% n   - order in the y direction
% sx  - variance in x
% sy  - variance in y
% gd  - 2D array containing gaussian derivatives upto m,n
% gd{a}{b}=(a-1)-th gaussian derivative in x, (b-1)-th gaussian derivative
%           in y
% out     =gd{end}{end}, highest gaussian derivative
%-----------------------------------------
function [out,gdout]=gd2D(img,m,n,sx,sy)
  if(nargin~=5)
    sy=sx;
  end;
  s = sqrt(sy.*sx);
  %define the filters
  for i = 1:length(sx)
    gd = cell(m+1,n+1);
    for dx = 0:m
      for dy = 0:n
	if(dx==0 && dy==0)
	  gd{dx+1,dy+1} = gauss_filter(img,sx(i),sy(i));
	elseif(dy==0)
	  [gx,gy]       = gradient(gd{dx,dy+1});%normalized derivative
	  %gy            = diff(gd{dx,dy+1},1,1);
	  gd{dx+1,dy+1} = s(i)*gy;
	else
	  [gx,gy]       = gradient(gd{dx+1,dy}); %normalized derivative
	  %gx            = diff(gd{dx+1,dy},1,2);
	  gd{dx+1,dy+1} = s(i)*gx;
	end;
      end;
    end;
    gdout{i} = gd;
    out{i}   = gd{end,end};
  end;
  if(length(sx)==1) %remove annoying cell
    tgd = gdout{1}; clear gdout; gdout=tgd;
    tout= out{1};   clear out;   out  =tout;
  end;
%end function
