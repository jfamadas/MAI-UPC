% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jordi Riu - Josep Famadas
% - - - - - - 


%%
%- - - - - - 
%Exercise 1:
%- - - - - - 

% We create 3 "empty" images
im1 = zeros(200,200); 
im2 = im1;
im3 = im1;

% We design the images we have been asked to
im1(:,100:end) = 256;
im2(100:end,:) = 256;
im3(1:100,1:100) = 256;

% We create the 4th image as a combination of the 3 we already have
im4_R = im1;
im4_G = im2;
im4_B = im3;

im4 = cat(3,im4_R,im4_G,im4_B);

% Plot the images in a 1x4 figure
figure
subplot(1,4,1)
imshow(im1)
title('(1)')
subplot(1,4,2)
imshow(im2)
title('(2)')
subplot(1,4,3)
imshow(im3)
title('(3)')
subplot(1,4,4)
imshow(im4)
title('(4)')

% Save the image in the path
imwrite(im4,'C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 1\3channels.jpg');

