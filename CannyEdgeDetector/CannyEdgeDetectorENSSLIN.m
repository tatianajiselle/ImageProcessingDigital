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

M=size(jx)-2;
N=size(jy)-2;
%calculate the strength of edge
for i = 1:size(jx) 
    for j = 1:size(jy)
    Es(i,j) = sqrt(jx(i,j).^2 + jy(i,j).^2);
    end;
end;

%imshow(Es); %contour picture
%%

%%
%Non Supression Maxima begins here

%calculate angle 
for i = 1:size(jx) 
    for j = 1:size(jy)
    Eo(i,j) = (radtodeg(atan(jy(i,j)/jx(i,j))));
    end;
end;

%find direction Dk to approx direction and thin pixels
for i = 2:size(jx)-2
    for j = 2:size(jy)-2 % 0 degrees
        if ((0 < Eo(i,j) && (Eo(i,j) < 22.5)) || (157.5 < Eo(i,j) && (Eo(i,j) < 180)))
            Dk(i,j)=0;
            if((Es(i,j) < Es(i+1,j)) || (Es(i,j) < Es(i-1,j))) %check neighbors
                In(i,j)=0; %suppression
            else
                In(i,j)=Es(i,j);
            end;
        end;
        if ((22.5 < Eo(i,j)) && (Eo(i,j) < 67.5))
            Dk(i,j)=45; % 45 degrees
            if((Es(i,j) < Es(i+1,j-1)) || (Es(i,j) < Es(i-1,j+1)))%check neighbors
                In(i,j)=0;
            else
                In(i,j)=Es(i,j);
            end;
        end;
        if ((67.5 < Eo(i,j)) && (Eo(i,j) < 112.5))
            Dk(i,j)=90; % 90 degrees
            if((Es(i,j) < Es(i,j-1)) || (Es(i,j) < Es(i,j+1)))%check neighbors
                In(i,j)=0;
            else
                In(i,j)=Es(i,j);
            end
        end;
        if ((112.5 < Eo(i,j)) && (Eo(i,j) < 157.5))
            Dk(i,j)=135; %135 degrees
            if((Es(i,j) < Es(i+1,j+1)) || (Es(i,j) < Es(i-1,j-1)))%check neighbors
                In(i,j)=0;
            else
                In(i,j) = Es(i,j);
            end;
        end;
    end;
end;

%imshow(In); % thinned pixel image
%%

%%
%Hysteresis Thresh begins here

Th=.0900;
Tl=.0100;

for i = 2:size(jx)-3
    for j = 2:size(jy)-3
        if (In(i, j) < Tl)
            thresh(i, j) = 0;
        elseif (In(i, j) > Th)
            thresh(i, j) = 1;
        elseif ((In(i + 1, j) > Th) || (In(i - 1, j) > Th) || (In(i, j + 1) > Th) ||(In(i, j - 1) > Th))    
                thresh(i, j) = 1;
         
        end
    end
end

imshow(thresh);