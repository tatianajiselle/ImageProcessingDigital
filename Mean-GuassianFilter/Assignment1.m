%Tatiana Ensslin
%Feb 7,2016
%Video and Image Processing Assignment 1



%Read in the files from the working directory%
i = imread('NoisyImage1.jpg');
i2= imread('NoisyImage2.jpg');

%%
%preform mean filter on i%
vector = 3;
meanfilter= fspecial('average', vector);
meanimg= filter2(meanfilter,i,'same');
imshow(meanimg/255);
subplot(2,1,1),imshow(i);subplot(2,1,2),imshow((meanimg/255));
%%

%%
%preform mean filter on i2%
vector2 = 3;
meanfilter= fspecial('average', vector2);
meanimg2= filter2(meanfilter,i2,'same');
imshow(meanimg2/255);
subplot(2,1,2),imshow(i);subplot(2,1,1),imshow((meanimg2/255));
%%

%%
%preform gaussian filter on noisy image one%
sd = 9 ; %the standard deviation%
hsize = 408; %size of the picture = 408x408 (boundaries)%
gf= fspecial('gaussian',hsize,sd);
gfimg = conv2(i,(gf/255),'same');
subplot(2,1,2),imshow(i);subplot(2,1,1),imshow(gfimg);
%%

%%
%preform gaussian filter on noisy image two%
sd = 5 ;
hsize = 408;
gf= fspecial('gaussian',hsize,sd);
gfimg2 = conv2(i2,(gf/255),'same');
subplot(2,1,2),imshow(i2);subplot(2,1,1),imshow(gfimg2);
%%

%%
%Here is the result plotted side by side each other and its original image%
subplot(2,2,1),imshow(i);subplot(2,2,2),imshow(gfimg);
subplot(2,2,3),imshow(i2);subplot(2,2,4),imshow(gfimg2);
%%

%%
%preform median filter on i and i2%
vectorA= 3;
vectorB= 8;
c= medfilt2(i,[vectorA vectorA]);
d= medfilt2(i,[vectorB vectorB]);
e= medfilt2(i2,[vectorA vectorA]);
f= medfilt2(i2,[vectorB vectorB]);

subplot(3,3,1), imshow(i); subplot(3,3,2), imshow(c); subplot(3,3,3), imshow(d);
subplot(3,3,4), imshow(i2);subplot(3,3,5), imshow(e);subplot(3,3,6), imshow(f);
%%