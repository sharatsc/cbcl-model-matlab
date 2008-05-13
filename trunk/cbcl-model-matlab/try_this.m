%----------------
%
SCALES=logspace(log10(0.125),log10(1),16)*40;
for p1=SCALES(1:2:end)
p0=1; s0=1; d0=1;rf0=1;                  %image
p1=p1; s1=ceil(p1/2); d1=s1*d0;rf1=rf0+(p1-1)*d0;   %s1
p2=3; s2=2; d2=s2*d1;rf2=rf1+(p2-1)*d1;   %c1
p3=4; s3=1; d3=s3*d2;rf3=rf2+(p3-1)*d2;   %s2
p4=3; s4=2; d4=s4*d3;rf4=rf3+(p4-1)*d3;   %c2
fprintf('%f ',rf4/2);
end;
fprintf('')