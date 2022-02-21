% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 2:
%- - - - - - 
close all
clear all

% Read the input image and divide it into the 3 RGB channels
im = imread('C:\Users\josep\Desktop\Computer Vision\Lab 1\images\buffet.jpg');

im_R = im(:,:,1);
im_G = im(:,:,2);
im_B = im(:,:,3);


% Display the 3 channels and the original image
figure
subplot(2,3,2)
imshow(im)
title('ORIGINAL','fontsize',18)

subplot(2,3,4)
imshow(im_R)
title('RED','fontsize',18)

subplot(2,3,5)
imshow(im_G)
title('GREEN','fontsize',18)

subplot(2,3,6)
imshow(im_B)
title('BLUE','fontsize',18)



% Recreate the color image but swaping the Red channel and the Green one

channel_interchange = cat(3,im_G,im_R,im_B);

figure
subplot(1,2,1)
imshow(im)
title('ORIGINAL','fontsize',18)
subplot(1,2,2)
imshow(channel_interchange)
title('SWAPPED R & G','fontsize',18)

% Save it
imwrite(channel_interchange,'C:\Users\josep\Desktop\Computer Vision\Lab 1\channel_interchange.jpg');


% Reduce the intensity of one of the 3 channels to 0.

% Reducing only Red
channelRx0 = im;
channelRx0(:,:,1) = 0;

% Reducing only Green
channelGx0 = im;
channelGx0(:,:,2) = 0;

% Reducing only Blue
channelBx0 = im;
channelBx0(:,:,3) = 0;

% Plots
figure
subplot(1,3,1)
imshow(channelRx0)
title('RED = 0','fontsize',18)

subplot(1,3,2)
imshow(channelGx0)
title('GREEN = 0','fontsize',18)

subplot(1,3,3)
imshow(channelBx0)
title('BLUE = 0','fontsize',18)

% Save the images
imwrite(channelRx0,'C:\Users\josep\Desktop\Computer Vision\Lab 1\channelRx0.jpg');
imwrite(channelGx0,'C:\Users\josep\Desktop\Computer Vision\Lab 1\channelGx0.jpg');
imwrite(channelBx0,'C:\Users\josep\Desktop\Computer Vision\Lab 1\channelBx0.jpg');

