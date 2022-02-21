% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 6:
%- - - - - - 
close all
clear all

% Read both images
im_hand = imread('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\images\hand.jpg');
im_mapfre = imread('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\images\mapfre.jpg');

% Plot original hand and its grayscale and original tower
figure
subplot(1,2,1)
imshow(im_hand)
title('HAND ORIGINAL','fontsize',18)

subplot(1,2,2)
imshow(im_mapfre)
title('TOWER ORIGINAL','fontsize',18)

im_hand_gray = rgb2gray(im_hand);

figure
imshow(im_hand_gray)
title('HAND GRAYSCALE','fontsize',18)

% Set the threshold to 16
th = 16;

% Binarize the image with the threshold, and its inverse
im_hand_bin = imbinarize(im_hand_gray,th/255);
im_nohand_bin = 1-im_hand_bin;

% Plot both, hand (binarization) and no hand (inverse binarization)
figure
subplot(1,2,1)
imshow(im_hand_bin)
title('HAND BINARIZED','fontsize',18)

subplot(1,2,2)
imshow(im_nohand_bin)
title('HAND BINARIZED INVERSE','fontsize',18)

% Sets the final image as a multiplication of the hand by the binarization
% and the tower by the inverse of the binarization
im_final = im_hand .* uint8(repmat(im_hand_bin,[1,1,3])) + im_mapfre .* uint8(repmat(im_nohand_bin,[1,1,3]));

% Plot the image
figure
imshow(im_final)
title('SUPPERPOSED IMAGES','fontsize',18)

% Save the image
imwrite(im_final,'C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\hand_mapfre.jpg');