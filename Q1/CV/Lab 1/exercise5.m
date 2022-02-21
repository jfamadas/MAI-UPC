% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 5:
%- - - - - - 
close all
clear ll

th1 = 20;
th2 = 30;
th3 = 150;
th4 = 255;

%Read the image
im = imread('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\images\car_gray.jpg');

% Binarize it with the different thresholds
im_th1 = imbinarize(im,th1/255);
im_th2 = imbinarize(im,th2/255);
im_th3 = imbinarize(im,th3/255);
im_th4 = imbinarize(im,th4/255);

% Plots
figure
imshow(im)
title('ORIGINAL','fontsize',18)

figure
subplot(2,2,1)
imshow(im_th1)
title(['TH = ', num2str(th1), ' (', num2str(th1/255*100,3), '%)'],'fontsize',18)

subplot(2,2,2)
imshow(im_th2)
title(['TH = ', num2str(th2), ' (', num2str(th2/255*100,3), '%)'],'fontsize',18)

subplot(2,2,3)
imshow(im_th3)
title(['TH = ', num2str(th3), ' (', num2str(th3/255*100,3), '%)'],'fontsize',18)

subplot(2,2,4)
imshow(im_th4)
title(['TH = ', num2str(th4), ' (', num2str(th4/255*100,3), '%)'],'fontsize',18)

% Save the image with threshold = 150
imwrite(im_th3,'C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\car_binary.jpg');


% Multiply the image by the 150 binarization
im_multiply = uint8(im.*(uint8(im_th3)));

% Multiply the image by the inverse of the 150 binarization
im_multiply_inv = uint8(im.*(uint8(1-im_th3)));

% Plots
figure
subplot(1,2,1)
imshow(im_multiply)
title('MULTIPLICATION','fontsize',18)

subplot(1,2,2)
imshow(im_multiply_inv)
title('MULTIPLICATION INVERTED','fontsize',18)
