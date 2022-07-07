% ***********Simulated Watermarking model******************************  
%%%%%%%% Please refer to following works, if you use our works:%%%%%%%%
% Written by: Arash Saboori

% [1] A. Saboori and S. A. Hosseini, "A novel non-blind watermarking scheme for color image using PCA transform 
%     and histogram matching technique," 2016 10th International Symposium on Communication Systems,
%     Networks and Digital Signal Processing (CSNDSP), Prague, 2016, pp. 1-5. 

% [2] A. Saboori and S. A. Hosseini, "Color image watermarking in YUV color space based on combination of DCT and PCA,"
%     2015 23rd Iranian Conference on Electrical Engineering, Tehran, 2015, pp. 308-313. doi: 10.1109/IranianCEE.2015.7146230

% [3] A. Saboori and S. A. Hosseini, "A new method for digital watermarking based on combination of DCT and PCA,
%      " 2014 22nd Telecommunications Forum Telfor (TELFOR), Belgrade, 2014, pp. 521-524.

% [4] S. Abolfazl Hosseini and A. Saboori, "A new method for color image watermarking based on combination of DCT and PCA," 
%     2015 International Conference on Communications, Signal Processing, and their Applications (ICCSPA'15), Sharjah, 2015, pp. 1-5.

% Written by: Arash Saboori 
%% ****************************************************************************
clc
close all
clear
watermarked_image= imread('Gray_watermarked.bmp');
%watermarked_image= imread('PCA_watermarked004.jpg');
imshow(watermarked_image);

orginal_image = imread('lena_gray.bmp');
%orginal_image = imread('Peppers_gray.png');
%orginal_image = imread('Goldhill_gray.png');

%orginal_image=imresize(orginal_image, [512 512]);


watermarked_image = double(watermarked_image);
orginal_image = double(orginal_image);
[Mw,Nw] = size(watermarked_image);
[Mo, No] = size(orginal_image);
blocksize=8;
max_message1=Mw*Nw/(blocksize^2);
%% ************************************************************
x=1; 
y=1;
i=1;
for i = 1:max_message1 
 
    % transform block using pca
    block_WatermarkedImg=dct2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1));
    matX(i,:)=reshape(block_WatermarkedImg,1,blocksize^2);
    if (x+blocksize) >= Nw 
        x=1; 
        y=y+blocksize; 
    else 
        x=x+blocksize; 
    end 
     
end
matX1=[matX(:,1),matX(:,9),matX(:,2),matX(:,3),matX(:,10),matX(:,17)];
[A1, PCs1] = princomp(matX1);
%% *********************************************************
x=1; 
y=1;
i=1;
for i = 1:max_message1 
 
    % transform block using pca
    block_orginalImg=dct2(orginal_image(y:y+blocksize-1,x:x+blocksize-1));
    matX2(i,:)=reshape(block_orginalImg,1,blocksize^2);
    if (x+blocksize) >= No 
        x=1; 
        y=y+blocksize; 
    else 
        x=x+blocksize; 
    end 
     
end
matX2=[matX2(:,1),matX2(:,9),matX2(:,2),matX2(:,3),matX2(:,10),matX2(:,17)];
[A, PCs2] = princomp(matX2);
%%*************************Recover_watermark***************************
i=1;
alfa=10;
for i=1:max_message1
    tempmessage(i,1)=((PCs1(i,1)-PCs2(i,1))./alfa) ;
    i=i+1;
end
%% ***********************************************************************
tempmessage=uint8(tempmessage);

Recover_watermark=reshape(tempmessage(:,1),64,64);
Recover_watermark=double(Recover_watermark');
% display psnr of watermarked image 

%psnr=psnr(orginal_image,Recover_watermark)
message_image = imread('Panda_binary.bmp');
message_image = double(message_image);

orginal_watermark=imresize(message_image, [64 64]);

orginal_watermark=round(orginal_watermark/255);
NC=NC(orginal_watermark,Recover_watermark)

watermarked_image=uint8(Recover_watermark); 
imwrite(Recover_watermark,'Recover watermark1','bmp');
imshow(Recover_watermark);
title('Recover watermark');