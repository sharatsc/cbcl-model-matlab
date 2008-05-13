function annotate_points(img,lst,box,color,printnum,printline)
        if(nargin<5)
	  printnum=0;
        end;
        if(nargin<6)
	  printline=0;
        end;
        if(length(box)==1)
	  box(2)=box(1);
        end;
	[ht,wt,d]=size(img);
        x = 0; y =0;
	for i = 1:length(lst)
	  px=x;
          py=y;
	  x= lst(i).pos(1)*wt;
	  y= lst(i).pos(2)*ht;
	  s= lst(i).s*box;
	  rectangle('Position',[x-s(2)/2 y-s(1)/2 s(2) 	s(1)],'EdgeColor',color,'LineWidth',2,'LineStyle','-');
	  if(printnum)
    	     text(x-s(2)/2+5,y-s(1)/2+15,sprintf('%d',i),'Color',color,'FontWeight','bold','BackgroundColor','black');
          end;
	  if(i~=1 & printline)
	    line([px,x],[py,y],'LineStyle','--','Color',color,'LineWidth',2);
	  end;
	end;
%end function
