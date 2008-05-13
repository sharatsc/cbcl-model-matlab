close all;
clear all;
load ~/gabriel/images/cph00156
%image    = imread('cameraman.tif');%imresize(image,0.75,'bicubic');
%-------------------------------------------
%extract patches
%-------------------------------------------
ftr      = callback_c1_baseline(image);
c1base   = ftr{2};
%--------------------------------------------
%new c1
%--------------------------------------------
tmp=load('~/ssdb/patches_gabor.mat');c0patches=tmp.patches_gabor;
c0      =   create_c0(image);
s1      =   s_generic_norm_filter(c0,c0patches);
c1      =   c_generic(s1,8,3,2);
c1new   =  c1;

[ht,wt]  = size(image);
x        = ceil(rand(1,100)*(wt-30));
y        = ceil(rand(1,100)*(ht-30));
for i = 1:100
  cy             = ceil(size(c1base{1},1)/ht*y(i));
  cx             = ceil(size(c1base{1},2)/wt*x(i));
  pbase(i).patch = c1base{1}(cy:cy+5,cx:cx+5,:);
  cy             = ceil(size(c1new{1},1)/ht*y(i));
  cx             = ceil(size(c1new{1},2)/wt*x(i));
  pnew(i).patch  = c1new{1}(cy:cy+5,cx:cx+5,:);
end;
%-------------------------------------------
%extract c2
%-------------------------------------------
c2baseref = zeros(100,1);
c2newref  = zeros(100,1);
for i = 1:length(pbase)
  c2baseref(i) = patch_response(c1base(1),pbase(i));
  c2newref(i)  = patch_response(c1new(1),pnew(i));
end;

%image = double(imread('cameraman.tif'));
%image = imresize(image,0.75);
imagesc(image);
res   = [];
resnew= [];
idx   = 1;
for scales = 0:7
  s     =  1.1.^scales;
  rimg  =  imresize(image,s,'bicubic');
  img   =  padarray(rimg,[200-ceil(size(rimg,1)/2),200-ceil(size(rimg,2)/2)],'both');
  figure(99);subplot(1,8,idx);imagesc(img);axis image; colormap('gray');pause(1);
  idx   = idx+1;
  ftr      = callback_c1_baseline(img);
  c1base   = ftr{2};

  c0      =   create_c0(img);
  s1      =   s_generic_norm_filter(c0,c0patches);
  c1      =   c_generic(s1,8,3,2);
  c1new   =  c1;
  %-------------------------------------------
  %extract c2
  %-------------------------------------------
  c2base = zeros(100,1);
  c2new  = zeros(100,1);
  for i = 1:length(pbase)
    c2base(i) = patch_response(c1base,pbase(i));
    c2new(i)  = patch_response(c1new,pnew(i));
  end;
  figure(1);cla;plot(c2base);hold on;plot(c2new,'r');pause(1);
  res  = [res,mse(c2base-c2baseref)];
  resnew=[resnew,mse(c2new-c2newref)];
end;
  
