function g = guassian(sd, ksize)
%Design the Gaussian Kernel

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

end