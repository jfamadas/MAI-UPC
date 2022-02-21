% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 4:
%- - - - - - 
close all
clear all

% Read the coral image
im = imread('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\images\corals.jpg');

% Reduce the image size
im_small = imresize(im,0.25);

% Resize the image to its original size
im_resized = imresize(im_small,4);


% Plot the original and resized images
figure
subplot(1,2,1)
imshow(im)
title('ORIGINAL','fontsize',18)
subplot(1,2,2)
imshow(im_resized)
title('RESIZED','fontsize',18)

% Plot the original and reduced image histograms
figure
subplot(1,2,1)
histogram(im)
title('ORIGINAL (HISTOGRAM)','fontsize',18)
subplot(1,2,2)
histogram(im_small)
title('ORIGINAL REDUCED(HISTOGRAM)','fontsize',18)




% Create a [1 1 1] mask
mask = 1/3*[1,1,1];

% Apply the mask to the image
im_masked = imfilter(im,mask);

% Apply a gaussian filter to the image
im_gaussian = imgaussfilt(im,2);

% Plot both filtered images
figure
subplot(1,2,1)
imshow(im_masked)
title('CREATED MASK','fontsize',18)
subplot(1,2,2)
imshow(im_gaussian)
title('GAUSSIAN FILTER','fontsize',18)

% Create 3 masks, horizontal, vertical and squared
mask1 = 1/5*[1,1,1,1,1];
mask2 = 1/5*[1;1;1;1;1];
mask3 = 1/25*[[1,1,1,1,1];[1,1,1,1,1];[1,1,1,1,1];[1,1,1,1,1];[1,1,1,1,1]];

im_mask1 = im;
im_mask2 = im;
im_mask3 = im;

% Apply each one of the filters to the original image 1000 times
for i = 1:1000
im_mask1 = imfilter(im_mask1,mask1);
im_mask2 = imfilter(im_mask2,mask2);
im_mask3 = imfilter(im_mask3,mask3);
end

% Plot the result
figure
subplot(1,3,1)
imshow(im_mask1)
title('HORIZONTAL MASK','fontsize',18)
subplot(1,3,2)
imshow(im_mask2)
title('VERTICAL MASK','fontsize',18)
subplot(1,3,3)
imshow(im_mask3)
title('SQUARED MASK','fontsize',18)

% Plot the filtered images and its substaction from the original image
figure
subplot(2,3,1)
imshow(im_mask1)
title('HORIZONTAL MASK','fontsize',18)
subplot(2,3,2)
imshow(im_mask2)
title('VERTICAL MASK','fontsize',18)
subplot(2,3,3)
imshow(im_mask3)
title('SQUARED MASK','fontsize',18)
subplot(2,3,4)
imshow(im-im_mask1)
title('HORIZONTAL MASK (SUBSTRACT)','fontsize',18)
subplot(2,3,5)
imshow(im-im_mask2)
title('VERTICAL MASK (SUBSTRACT)','fontsize',18)
subplot(2,3,6)
imshow(im-im_mask3)
title('SQUARED MASK (SUBSTRACT)','fontsize',18)