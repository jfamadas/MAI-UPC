% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jordi Riu - Josep Famadas 
% - - - - - - 


%%
%- - - - - - 
%Exercise 1:
%- - - - - - 
close all
clear all

% Read the image
im1 = imread('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 2\images_video\starbuck.jpg');

% Set the image to grayscale
im = rgb2gray(im1);

% Apply a Sobel filter with a threshold of 0.04
sob = edge(im,'Sobel',0.04);

% Apply a Prewitt filter with a threshold of 0.04
pre = edge(im,'Prewitt',0.04);

% Apply the Laplacian of Gaussian filter with a threshold of 0.02 and a
% sigma of 2
lap = edge(im,'log',0.02,2);

% Plot the images
figure
subplot(2,2,1)
imshow(im)
title('ORIGINAL','fontsize',18)

subplot(2,2,2)
imshow(sob)
title('SOBEL TH=0.04','fontsize',18)

subplot(2,2,3)
imshow(pre)
title('PREWITT TH=0.04','fontsize',18)

subplot(2,2,4)
imshow(lap)
title('LAPLACIAN OF GAUSSIAN TH=0.02 \sigma=2','fontsize',18)

% Apply the Canny filter with a threshold of 0.2 and a sigma of 2
can = edge(im,'Canny',0.2,2);

figure
imshow(can)
title('CANNY TH=0.2 \sigma=2','fontsize',18)

%Overlapping

over = im1;
over(:,:,1) = over(:,:,1) + 255*uint8(can);

figure
imshow(over)


