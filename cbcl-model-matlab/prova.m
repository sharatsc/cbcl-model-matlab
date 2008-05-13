clc;
close all;
clear;

x=[-16:1:16];
y=[-16:1:16];
dimx=size(x,2);
dimy=size(y,2);
varianza=3;
filtro=zeros(dimx,dimy);
for ii=1:dimx
    for jj=1:dimy
        esponente=exp(-(x(ii)^2+y(jj)^2)/(2*varianza^2));
        filtro(ii,jj)=1/(2*pi*varianza^2)*esponente;
    end
end


x=[-200:200];
y=[-200:200];
dimx=size(x,2);
dimy=size(y,2);
im=zeros(dimx,dimy);
for ii=1:dimx
    for jj=1:dimy
        im(ii,jj)=exp(-0.01*((x(ii)-20)^2+(y(jj)+30)^2));
    end
end

ingresso=im;
%ingresso=rand(400,400);


tic;
y1=conv2(ingresso,filtro,'same');
toc;

tic;
y2=gaussian(ingresso,varianza,30);
toc

mesh(y2-y1)








