
function result=RGBTOYCBCR(I);
I=double(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

Y=0.299*R+0.587*G+0.114*B;
Cb=-0.169*R-0.331*G+0.5*B+128;
Cr=0.5*R-0.419*G-0.081*B+128;
I2(:,:,1)=Y;
I2(:,:,2)=Cb;
I2(:,:,3)=Cr;
result=I2;

%figure,imshow(I);title('RGBͼ');
%figure,imshow(I2);title('YUVͼ');