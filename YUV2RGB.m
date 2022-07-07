function result=YUVTORGB(I);
I=double(I);
Y=I(:,:,1);
U=I(:,:,2);
V=I(:,:,3);
R=1.0*Y+1.14*V;
G=1.0*Y-0.395*U-0.581*V;
B=1.0*Y+2.032*U;
I2(:,:,1)=R;
I2(:,:,2)=G;
I2(:,:,3)=B;
result=I2;

%figure,imshow(I);title('RGBͼ');
%figure,imshow(I2);title('YUVͼ');