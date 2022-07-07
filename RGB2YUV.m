
function result=RGBTOYUV(I);
I=double(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

Y=0.299*R+0.587*G+0.114*B;
U=-0.148*R-0.289*G+0.437*B;
V=0.615*R-0.515*G-0.100*B;
I2(:,:,1)=Y;
I2(:,:,2)=U;
I2(:,:,3)=V;
result=I2;

%figure,imshow(I);title('RGBͼ');
%figure,imshow(I2);title('YUVͼ');