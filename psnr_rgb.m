
function psnr_rgb=psnr_rgb(tu1,tu2)
tu1=im2double(tu1);
tu2=im2double(tu2);

r1=tu1(:,:,1);     
g1=tu1(:,:,2);     
b1=tu1(:,:,3);     
r2=tu2(:,:,1);    
g2=tu2(:,:,2);     
b2=tu2(:,:,3);     

d1=mean(mean((r1-r2).^2));
m1=max(max(r1(:)),max(r2(:)));
m1=m1^2;
psnr1=10*log10(m1/d1);

d2=mean(mean((g1-g2).^2));
m2=max(max(g1(:)),max(g2(:)));
m2=m2^2;
psnr2=10*log10(m2/d2);

d3=mean(mean((b1-b2).^2));
m3=max(max(b1(:)),max(b2(:)));
m3=m3^2;
psnr3=10*log10(m3/d3);

psnr_rgb=(psnr1+psnr2+psnr3)/3
