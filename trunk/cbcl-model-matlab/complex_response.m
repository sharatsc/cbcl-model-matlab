%---------------------------------------------------------------
%
%
%sharat@mit.edu
%---------------------------------------------------------------
function [i20,i11] = complex_response(g,s)
    i20 = imfilter(g.^2,s,'same','symmetric');
    i11 = imfilter(abs(g).^2,abs(s),'same','symmetric');
%end function
