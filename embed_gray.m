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

cover_image= imread('lena_gray.bmp');
figure
imshow(cover_image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
message_image = imread('Panda_binary.bmp');

%message_image=imresize(message_image, [64 64]);

figure
imshow(message_image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
message_image = double(message_image);
cover_image = double(cover_image);
Mc=size(cover_image,1);	                 
Nc=size(cover_image,2);	                
Mm=size(message_image,1);	                
Nm=size(message_image,2);

tempMessage=round(reshape(message_image',Mm*Nm,1)./255); 
blocksize=8;
%% ********************************************************************
max_message=Mc*Nc/(blocksize^2);

x=1; 
y=1;
i=1;
for (kk = 1:max_message) 
 
    % transform block using pca
    block_CoverImg=dct2(cover_image(y:y+blocksize-1,x:x+blocksize-1));
    matX(i,:)=reshape(block_CoverImg,1,blocksize^2);
    i=i+1;
    % move on to next block. At and of row move to next row 
    if (x+blocksize) >= Nc 
        x=1; 
        y=y+blocksize; 
    else 
        x=x+blocksize; 
    end 
     
end 

matX1=[matX(:,1),matX(:,9),matX(:,2),matX(:,3),matX(:,10),matX(:,17)];

[coeff,pca_dct_block]= princomp(matX1);
m=mean(matX1);

%% **************************************************

alfa=30;
for i=1:max_message
   pca_dct_block(i,1)=pca_dct_block(i,1)+alfa*tempMessage(i,1);
end

%% ********************************************************
%inverse PCA
x_protect = pca_dct_block*((coeff)^-1)+repmat(m,max_message,1);

matX(:,1)=x_protect(:,1);
matX(:,9)=x_protect(:,2);
matX(:,2)=x_protect(:,3);
matX(:,3)=x_protect(:,4);
matX(:,10)=x_protect(:,5);
matX(:,17)=x_protect(:,6);

%% ***************************************************************
x=1; 
y=1;
i=1;
for (kk = 1:max_message)
    
  watermarked_image(y:y+blocksize-1,x:x+blocksize-1)=idct2(reshape(matX(i,:),blocksize,blocksize));
  i=i+1;    
 % move on to next block. At and of row move to next row 
    if (x+blocksize) >= Nc 
        x=1; 
        y=y+blocksize; 
    else 
        x=x+blocksize; 
    end 
end 
watermarked_image=uint8(watermarked_image);

%%*********************************************************************************
%% ************************** Attack  *****************************************

%%********************Compressed*********************************************
%imwrite(watermarked_image,'PCA_watermarked004.jpg','Quality',30);
%watermarked_image=imread('PCA_watermarked004.jpg');
%% **********************noise*********************************************
%watermarked_image=imnoise(watermarked_image,'salt & pepper',.01);
%watermarked_image=imnoise(watermarked_image,'gaussian',0,.01);
%imwrite(watermarked_image,'PCA_watermarked02.bmp','bmp');
%% ***********************filtering*************************************************
%watermarked_image=wiener2(watermarked_image,[4 4]);
%watermarked_image=medfilt2(watermarked_image,[3 3]);
%watermarked_image=average_filter(watermarked_image);
%G = fspecial('gaussian',[5 5],0.01);
%watermarked_image = imfilter(watermarked_image,G,'same');
%% ******************** LPF**********************************************
%filter=ones(3,3)/9;
%watermarked_image=uint8(filter2(filter,watermarked_image));
%% ******.*****************crop*************************************************

%wtcropr(xmin:xmin+height,ymin:ymin+width)=watermarked_image(xmin:xmin+height,ymin:ymin+width);
%wtcropr(1:512,1:512)=watermarked_image(1:512,1:512);
%watermarked_image(215:265,275:325)=wtcropr(1:51,1:51);

%imwrite(watermarked_image,'PCA_watermarked02.bmp','bmp');
%watermarked_image=wtcropr;
%watermarked_image=uint8(wtcropr);
%watermarked_image=imcrop(watermarked_image,[100 100 500 500]);
%watermarked_image=imcrop(watermarked_image);
%imwrite(watermarked_image,'PCA_watermarked02.bmp','bmp');
%watermarked_image=imresize(watermarked_image, [512 512]);
%% *****************************rotate********************************
%watermarked_image=imrotate(watermarked_image,.25,'bilinear','crop');
%watermarked_image=imrotate(watermarked_image1,50,'bilinear','crop');

%imwrite(watermarked_image,'PCA_watermarked02.bmp','bmp');

%% **************************sharpen *********************************************88
%H = fspecial('unsharp');
%watermarked_image = imfilter(watermarked_image,H,'replicate');
 
%% ****************************************************************************
imwrite(watermarked_image,'Gray_watermarked.bmp','bmp');

% displ.ay psnr of watermarked image

%mse=mse(cover_image,watermarked_image)
%cover_image = double(cover_image);
psnr=psnr(cover_image,watermarked_image)  
%watermarked_image=uint8(watermarked_image); 
figure
imshow(watermarked_image,[])




