
function result=YCBCRORGB(I);
I=double(I);
Y=I(:,:,1);
Cb=I(:,:,2);
Cr=I(:,:,3);
R=1.0*Y+1.14*(Cb-128);
G=1.0*Y-0.343*(Cb-128)-0.711*(Cr-128);
B=1.0*Y+1.765*(Cb-128);
I2(:,:,1)=R;
I2(:,:,2)=G;
I2(:,:,3)=B;
result=I2;

%figure,imshow(I);title('RGBͼ');
%figure,imshow(I2);title('YUVͼ');

%figure,imshow(I);title('RGBͼ');
%figure,imshow(I2);title('YUVͼ');