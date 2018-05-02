%Tatiana Ensslin
%Feb 7,2016
%Video and Image Processing Assignment 1



%Read in the files from the working directory%
i = imread('NoisyImage1.jpg');
i2= imread('NoisyImage2.jpg');

%%
%preform mean filter on i in 3x3 kernel%
meanimg = ones(3)/5;
Meanimg = meanimg*meanimg';
meanfilt1 = filter2(Meanimg,i);

%img = conv2(single(i), ones(3)/9);
subplot(2,1,1),imshow(i);subplot(2,1,2),imshow((meanfilt1/255));
%subplot(2,1,1),imshow(i);subplot(2,1,2),imshow((img/255));
%%

%%
%preform mean filter on i2 2x2 kernel%
meanimg = ones(2)/3;
Meanimg = meanimg*meanimg';
meanfilt2 = filter2(Meanimg,i2);
subplot(2,1,1),imshow(i2);subplot(2,1,2),imshow((meanfilt2/255));
%%
% Gaussian Algortihm with kernel size of 3 and standard deviation 1 on noisyimage1.jpg

%Read in the files from the working directory%
noisyimage1 = imread('NoisyImage1.jpg');
I = double(noisyimage1);

%Design the Gaussian Kernel
%Standard Deviation
sd = 1;

%Kernel size
ksize = 3;

% following gaussian formula obtained from and function help pages of:
%(https://en.wikipedia.org/wiki/Gaussian_blur)
%http://www.mathworks.com/company/newsletters/articles/using-matlabs-meshgrid-command-and-array-operators-to-implement-one-and-two-variable-functions.html
X = size(x,1)-1;
Y = size(y,1)-1;

%create the first and second coordinate matrices of the grid with kernel
%size between -3 and 3
[x,y]=meshgrid(-ksize:ksize,-ksize:ksize);
matrix = 1/(2*pi*sd*sd)*exp(-(x.^2+y.^2)/(2*sd*sd)); %guassian equation, (note: sd*sd=sd^2)

%Initialize new matrix for post convolution 
noisyImg=zeros(size(I)); %create the matrix the size of the image for the filter

%Convolution of filter with image 2D
for i = 1:size(I,1)-X 
    for j =1:size(I,2)-Y
        value = I(i:i+X,j:j+X).*matrix; %convolution between image and filter
        noisyImg(i,j)=sum(value(:)); %normalization .. fill the zeroed matrix with convoluted image
    end
end
%Image without Noise after Gaussian blur
noisyImg = uint8(noisyImg); %originally casted to int8 but was whiteish need to convert out of double and into unsigned int
subplot(2,1,1),imshow(noisyimage1); subplot(2,1,2),imshow(noisyImg);
%%

%% Gaussian Algortihm with kernel size of 3 and standard deviation 3 on noisyimage2.jpg

%Read in the files from the working directory%
noisyimage2 = imread('NoisyImage2.jpg');
I = double(noisyimage2);

%Design the Gaussian Kernel
%Standard Deviation
sd = 3;

%Kernel size
ksize = 3;

% following gaussian formula
%(https://en.wikipedia.org/wiki/Gaussian_blur)
%http://www.mathworks.com/company/newsletters/articles/using-matlabs-meshgrid-command-and-array-operators-to-implement-one-and-two-variable-functions.html
X = size(x,1)-1;
Y = size(y,1)-1;

%create the first and second coordinate matrices of the grid with kernel
%size between -3 and 3
[x,y]=meshgrid(-ksize:ksize,-ksize:ksize);
matrix = 1/(2*pi*sd*sd)*exp(-(x.^2+y.^2)/(2*sd*sd)); %define the function using array operators

%Initialize new matrix for post convolution 
noisyImg=zeros(size(I)); %create the matrix the size of the image for the filter

%Convolution of filter with image 2D
for i = 1:size(I,1)-X 
    for j =1:size(I,2)-Y
        value = I(i:i+X,j:j+X).*matrix; %convolution between image and filter
        noisyImg(i,j)=sum(value(:)); %normalization .. fill the zeroed matrix with convoluted image
    end
end
%Image without Noise after Gaussian blur
noisyImg = uint8(noisyImg); %originally casted to int8 but was whiteish need to convert out of double and into unsigned
subplot(2,1,1),imshow(noisyimage2); subplot(2,1,2),imshow(noisyImg);
%%

%%
%preform median filter on noisyimage1.jpg%

im = imread('NoisyImage1.jpg');

%kernel size defined here%
ksize = 9;

%create padding around picture%
borderpad = padarray(im, [round(ksize/2) round(ksize/2)]); %for edges to be more accurate

%seperate image blocks into columns%
columns = im2col(borderpad, [ksize ksize], 'sliding');

%sort pixel strength in ascending order%
sorted = sort(columns, 1, 'ascend');

%apply median of neighbohood to create filter%
medianfil = sorted(floor(ksize*ksize/2) + 1, :);

%apply filter to image
out = col2im(medianfil, [ksize ksize], size(borderpad), 'sliding');

%print image
subplot(2,1,1),imshow(noisyimage1); subplot(2,1,2),imshow(out);
%%

%%
%preform median filter on noisyimage2.jpg%

im2 = imread('NoisyImage2.jpg');

%kernel size defined here%
ksize = 6;

%create padding around picture%
borderpad = padarray(im2, [round(ksize/2) round(ksize/2)]); %for edges to be more accurate

%seperate image blocks into columns%
columns = im2col(borderpad, [ksize ksize], 'sliding');

%sort pixel strength in ascending order%
sorted = sort(columns, 1, 'ascend');

%apply median of neighbohood to create filter%
medianfil = sorted(floor(ksize*ksize/2) + 1, :);

%apply filter to image returning columns to image blocks%
output = col2im(medianfil, [ksize ksize], size(borderpad), 'sliding');

%print image
subplot(2,1,1),imshow(noisyimage2); subplot(2,1,2),imshow(output);
%%