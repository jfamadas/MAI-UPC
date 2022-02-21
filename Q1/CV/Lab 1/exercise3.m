% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 3:
%- - - - - - 
close all
clear all

% Read the input image
im = imread('C:\Users\josep\Desktop\Computer Vision\Lab 1\images\clooney.jpg');

% Number of column in which we make the cut
c = 225; 

% Create the new image by cutting the original and swapping its two pieces
im2 = [im(:,c:end,:),im(:,1:(c-1),:)];


% Plot the original and the chopped image
figure
subplot(1,2,1)
imshow(im)
title('ORIGINAL IMAGE','fontsize',18)

subplot(1,2,2)
imshow(im2)
title('SWAPED IMAGE','fontsize',18)
