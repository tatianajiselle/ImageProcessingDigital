%%Tatiana Ensslin
% Canny Edge Detector Algorithm
% Video and Image Proessing
% February 15, 2016


% Gaussian Algortihm with kernel size of 3 and standard deviation 1 on noisyimage1.jpg

%Read in the files from the working directory%
noisyimage1 = imread('puppy.jpeg');
noisyimage1 = rgb2gray(noisyimage1);
I = double(noisyimage1);

%Design the Gaussian Kernel
%Standard Deviation
sd = 1;

%Kernel size
ksize = 2;

% following gaussian formula obtained from and function help pages of:
%(https://en.wikipedia.org/wiki/Gaussian_blur)
%http://www.mathworks.com/company/newsletters/articles/using-matlabs-meshgrid-command-and-array-operators-to-implement-one-and-two-variable-functions.html
[x,y]=meshgrid(-ksize:ksize,-ksize:ksize);
X = size(x,1)-1;
Y = size(y,1)-1;

%create the first and second coordinate matrices of the grid with kernel
%size between -3 and 3

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
noisyImg = im2double(noisyImg); %convert img to double

% Canny Enhancer begins here
convx = [-1 0 1];
convy = [-1; 0; 1];

%imshow(noisyImg);


%find the derivates (gradient) in x and y direction
jx = conv2(convx,noisyImg);
jy = conv2(convy,noisyImg);

jx2 = jx.* jx; % get jx to the power of two
jy2 = jy.* jy; % get jy to the power of two
Jxy = jx .* jy; %get the Jxy by multipling jx and jy

%C=[jx2 Jxy; Jxy jy2];
for i = 1:size(jx) 
    for j = 1:size(jy)
    Es(i,j) = sqrt(jx(i,j).^2 + jy(i,j).^2);
    end;
end;



%find summation of gradient throught the neighborhood two for loops for
%each 2x+1 traverese neighborhood 

%smaller eig value found by comparing ex and ey ... and then threshold
%comes from ex ey .... compare small lambda to threshold if greater than
%save the lambda nda the coordinates of pt into  matrix

%largest sorted pts in neighborhood stay .. at this point will have list of
%lambda value with the coordinates.. take that pixel and create a box
%around it (highlights neighborhood)

